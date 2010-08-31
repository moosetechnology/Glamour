Class {
	#name : #SGLActionPresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'presentation',
		'showAsIconCount'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'jQuery-scripts' }
SGLActionPresenter >> actionScriptFor: anAction with: html [
	^ html jQuery ajax
		script: [:script| 
			anAction actOn: presentation.
			self renderer updateScript: script ] 
]

{ #category : #initialization }
SGLActionPresenter >> initializeFor: aPresentation [
	presentation := aPresentation.
	self showAsIconCount: 2
]

{ #category : #'jQuery-scripts' }
SGLActionPresenter >> menuScriptWith: html [
	^ html jQuery new buildMenu 
			menuWidth: 20;
			hasImages: false;
			closeOnMouseOut: true
]

{ #category : #rendering }
SGLActionPresenter >> renderAction: anAction on: html [
	html image 
		form: anAction icon;
		id: html nextId;
		title: anAction title;
		onClick: ( self actionScriptFor: anAction with: html )
]

{ #category : #rendering }
SGLActionPresenter >> renderActions: actions on: html [
	| headerIcons menuIcons count |
	count := 1.
	headerIcons := OrderedCollection new.
	menuIcons := OrderedCollection new.
	actions do: [:each|
		(each hasIcon and: [count <= self showAsIconCount])
			ifTrue: [
				headerIcons add: each. 
				count := count + 1] 
			ifFalse: [menuIcons add: each] ].
	headerIcons do: [:each|
		self renderAction: each on: html ].
	(menuIcons isEmpty) ifFalse: [
			self renderMenuForActions: actions on: html ]
]

{ #category : #rendering }
SGLActionPresenter >> renderContentOn: html [
	|actions|
	actions := (presentation actions select: [:action | action hasIcon or: [action hasTitle] ]) asOrderedCollection.
	html div
		class: 'glm-ac-container';
		with: [ self renderActions: actions on: html ]
]

{ #category : #mbmenu }
SGLActionPresenter >> renderMbMenuContentForActions: actions on: html [
	actions do: [ :each|
		html anchor
			action: (self actionScriptFor: each with: html);
			with: [
				"html image form: (actions at: index) icon."
				html text: each title] ] 
]

{ #category : #mbmenu }
SGLActionPresenter >> renderMbMenuHeaderContentForMenu: aMenuId on: html [
	html tableRow: [ 
		html tableData
			class: 'rootVoices';
			menu: aMenuId;
			with: [ 
				html image
					url: (SGLFileLibrary urlOf: #arrowDownPng) ] ]
]

{ #category : #mbmenu }
SGLActionPresenter >> renderMbMenuHeaderForMenu: aMenuId on:  html [
	html div 
		id: html nextId;
		class: 'glm-ac-container-menu';
		script: (self menuScriptWith: html);
		with: [
			html table 
				class: 'rootVoices';
				cellpadding: 0; cellspacing: 0;
				border: 0;
				with: [
					self renderMbMenuHeaderContentForMenu: aMenuId on: html ] ]

]

{ #category : #mbmenu }
SGLActionPresenter >> renderMbMenuWithId: anId forActions: actions on: html [
	|categories|
	html div 
		class: 'mbmenu';
		id: anId;
		with: [ self renderMbMenuContentForActions: actions on: html ] 
]

{ #category : #rendering }
SGLActionPresenter >> renderMenuForActions: actions on: html [
	|id|
	id := html nextId.
	self renderMbMenuHeaderForMenu: id on:  html.
	self renderMbMenuWithId: id forActions: actions on: html
]

{ #category : #accessing }
SGLActionPresenter >> showAsIconCount [
	^ showAsIconCount
]

{ #category : #accessing }
SGLActionPresenter >> showAsIconCount: anObject [
	showAsIconCount := anObject
]
