Class {
	#name : #SGLActionPresenter,
	#superclass : #WAPresenter,
	#instVars : [
		'presentation',
		'renderer',
		'showAsIconCount'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'instance creation' }
SGLActionPresenter class >> for: aPresentation with: aRenderer [
	^ self basicNew initializeFor: aPresentation with: aRenderer 
]

{ #category : #scripts }
SGLActionPresenter >> actionScriptFor: anAction with: html [
	^ html jQuery ajax
		script: [:script| 
			anAction actOn: presentation.
			renderer updateScript: script ] 
]

{ #category : #initialization }
SGLActionPresenter >> initialize [
	super initialize.
	self showAsIconCount: 2
]

{ #category : #initialization }
SGLActionPresenter >> initializeFor: aPresentation with: aRenderer [
	self initialize.
	presentation := aPresentation.
	renderer := aRenderer
]

{ #category : #scripts }
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
	1 to: (self showAsIconCount min: actions size) do: [:index | 
		self renderAction: (actions at: index) on: html].
	(actions size > self showAsIconCount) ifTrue: [
			self renderMenuForActions: actions on: html ]
]

{ #category : #rendering }
SGLActionPresenter >> renderContentOn: html [
	|actions|
	actions := (presentation allActions select: [:action | action hasIcon and: [action hasTitle] ]) asOrderedCollection.
	html div
		class: 'glm-ac-container';
		with: [  self renderActions: actions on: html ]
]

{ #category : #mbmenu }
SGLActionPresenter >> renderMbMenuContentForActions: actions on: html [
	self showAsIconCount + 1to: actions size do: [ :index|
		html anchor
			action: (self actionScriptFor: ( actions at: index) with: html);
			with: [
				"html image form: (actions at: index) icon."
				html text: ( actions at: index) title] ] 
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
