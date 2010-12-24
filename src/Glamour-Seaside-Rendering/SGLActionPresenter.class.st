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
			menuWidth: 110;
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
	actions := (presentation actions select: [:action | 
		action worksWithSeaside and: [
			action hasIcon or: [action hasTitle] ] ]) asOrderedCollection.
	html div
		class: 'glm-ac-container';
		with: [ self renderActions: actions on: html ]
]

{ #category : #mbmenu }
SGLActionPresenter >> renderMbMenuActionOrCategory: anActionOrCategory withMenuId: anId on: html [
	|anchor|
	anchor :=html anchor.
	anId ifNil: [
			anchor action: (self actionScriptFor: anActionOrCategory with: html) ]
		ifNotNil: [anchor menu: anId].
	anchor 	with: [
			"html image form: (actions at: index) icon."
			html text: (anId ifNil: [anActionOrCategory title] ifNotNil: [anActionOrCategory]) ]
]

{ #category : #mbmenu }
SGLActionPresenter >> renderMbMenuCategories: categories on: html [
	|id ids|
	ids := Dictionary new.
	categories keys do: [:each|
		id := html nextId.
		ids at: each put: id.
		self renderMbMenuActionOrCategory: each withMenuId: id on: html ].
	^ ids
]

{ #category : #mbmenu }
SGLActionPresenter >> renderMbMenuContentForActions: actions on: html [
	actions do: [ :each|
		self renderMbMenuActionOrCategory: each withMenuId: nil on: html ] 
]

{ #category : #mbmenu }
SGLActionPresenter >> renderMbMenuHeaderContentForMenu: aMenuId on: html [
	html tableRow: [ 
		html tableData
			class: 'rootVoices';
			menu: aMenuId;
			with: [ 
				html image
					form: GLMUIThemeIcons windowMenuForm;
					class: 'glm-mbMenu-header-icon'
					"url: (SGLFileLibrary urlOf: #arrowDownPng)" ] ]
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
	|categories uncategorizedActions categoriesId|
	categories := Dictionary new.
	uncategorizedActions := OrderedCollection new.
	actions do: [:each|
		(each category) 
			ifNil: [uncategorizedActions add: each] 
			ifNotNil: [ 
				|category|
				category := categories at: each category ifAbsentPut: [OrderedCollection new].
				category add: each ] ].
	html div 
		class: 'mbmenu';
		id: anId;
		with: [ 
			self renderMbMenuContentForActions: uncategorizedActions on: html.
			categoriesId := self renderMbMenuCategories: categories on: html ].
	self renderMbSubmenuesFor: categories withIds: categoriesId on: html.
]

{ #category : #mbmenu }
SGLActionPresenter >> renderMbSubmenuesFor: categories withIds: ids on: html [
	| category |
	categories keys do: [:each|
		 html div
			id: (ids at: each);
			class: 'mbmenu';
			with: [
				(categories at: each) do: [:action|
					self renderMbMenuActionOrCategory: action withMenuId: nil on: html ] ] ]
	
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
