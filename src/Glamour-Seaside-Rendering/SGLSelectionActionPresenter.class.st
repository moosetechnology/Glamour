Class {
	#name : #SGLSelectionActionPresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'presentation',
		'showAsIconCount',
		'menuId'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'jQuery-scripts' }
SGLSelectionActionPresenter >> actionScriptFor: anAction with: html [
	^ html jQuery ajax
		script: [:script| 
			anAction actOn: presentation.
			self renderer updateScript: script ] 
]

{ #category : #initialization }
SGLSelectionActionPresenter >> initializeFor: aPresentation [
	presentation := aPresentation.
	self showAsIconCount: 2
]

{ #category : #accessing }
SGLSelectionActionPresenter >> menuId [

	^ menuId
]

{ #category : #accessing }
SGLSelectionActionPresenter >> menuId: aMenuId [

	menuId := aMenuId
]

{ #category : #'jQuery-scripts' }
SGLSelectionActionPresenter >> menuScriptWith: html [
	^ html jQuery new buildContextualMenu 
			menuWidth: 110;
			hasImages: false;
			closeOnMouseOut: true
]

{ #category : #accessing }
SGLSelectionActionPresenter >> presentation [

	^ presentation
]

{ #category : #rendering }
SGLSelectionActionPresenter >> renderContentOn: html [
	|actions|
	actions := (presentation selectionActions select: [:action | 
		action worksWithSeaside and: [
			action hasIcon or: [action hasTitle] ] ]) asOrderedCollection.
	self renderMbMenuWithId: self menuId forActions: actions on: html
]

{ #category : #mbmenu }
SGLSelectionActionPresenter >> renderMbMenuActionOrCategory: anActionOrCategory withMenuId: anId on: html [
	|anchor|
	anchor := html anchor.
	anId ifNil: [
			anchor := anActionOrCategory seasideAnchorFrom: self on: html.
				 ]
		ifNotNil: [anchor menu: anId].
	anchor 	with: [
			"html image form: (actions at: index) icon."
			html text: (anId ifNil: [anActionOrCategory title] ifNotNil: [anActionOrCategory]) ]
]

{ #category : #mbmenu }
SGLSelectionActionPresenter >> renderMbMenuCategories: categories on: html [
	|id ids|
	ids := Dictionary new.
	categories keys do: [:each|
		id := html nextId.
		ids at: each put: id.
		self renderMbMenuActionOrCategory: each withMenuId: id on: html ].
	^ ids
]

{ #category : #mbmenu }
SGLSelectionActionPresenter >> renderMbMenuContentForActions: actions on: html [
	actions do: [ :each|
		self renderMbMenuActionOrCategory: each withMenuId: nil on: html ] 
]

{ #category : #mbmenu }
SGLSelectionActionPresenter >> renderMbMenuWithId: anId forActions: actions on: html [
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
SGLSelectionActionPresenter >> renderMbSubmenuesFor: categories withIds: ids on: html [
	| category |
	categories keys do: [:each|
		 html div
			id: (ids at: each);
			class: 'mbmenu';
			with: [
				(categories at: each) do: [:action|
					self renderMbMenuActionOrCategory: action withMenuId: nil on: html ] ] ]
	
]

{ #category : #accessing }
SGLSelectionActionPresenter >> showAsIconCount [
	^ showAsIconCount
]

{ #category : #accessing }
SGLSelectionActionPresenter >> showAsIconCount: anObject [
	showAsIconCount := anObject
]
