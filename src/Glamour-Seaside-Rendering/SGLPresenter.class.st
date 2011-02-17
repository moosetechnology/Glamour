Class {
	#name : #SGLPresenter,
	#superclass : #WAPresenter,
	#instVars : [
		'renderer'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'instance creation' }
SGLPresenter class >> for: anObject from: aRenderer [
	^ self basicNew initializeFor: anObject from: aRenderer
]

{ #category : #initialization }
SGLPresenter >> initializeFor: anObject [
	self subclassResponsibility
]

{ #category : #initialization }
SGLPresenter >> initializeFor: anObject from: aRenderer [
	self initialize.
	self renderer: aRenderer.
	self initializeFor: anObject
]

{ #category : #private }
SGLPresenter >> render: aRenderable on: html [
	self renderer render: aRenderable on: html
]

{ #category : #private }
SGLPresenter >> renderActionsFrom: aPresentation on: html [
	html render: (SGLActionPresenter for: aPresentation from: self renderer) 
]

{ #category : #private }
SGLPresenter >> renderEmptyPresentationOn: html [
	html div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all';
		class: 'glm-empty-presentation'
]

{ #category : #private }
SGLPresenter >> renderPaneWithoutTitle: aPane on: html [
	html render: (SGLPaneWithoutTitlePresenter for: aPane from: self)
]

{ #category : #private }
SGLPresenter >> renderTitleOrIconOf: aPresentation on: html [
	aPresentation hasTitleIcon
		ifTrue: [ 
			html image
				form: aPresentation titleIconValue  ] 
		ifFalse:  [ html render: (aPresentation titleValue ifNil: ['']) ]
]

{ #category : #private }
SGLPresenter >> renderWithTitle: aPresentation andAddCloseButton: aBoolean on: html [
	|id|
	id := html nextId.
	(self widgetContainerWith: html)
		script: ( html jQuery new glamourTabs
			ifEmptyDo: 'remove';
			hasActions: true;
			closable: aBoolean );
		class: 'presentation-with-title';
		with: [
			html unorderedList				
				class: 'presentation-title';
				with: [
					html listItem: [ 
							html anchor
								url: '#', id asString;
								with: [self renderTitleOrIconOf: aPresentation on: html]  ].
					html listItem 
						class: 'glm-actions';
						with: [self renderActionsFrom: aPresentation on: html].
					].
			html div
				id: id;				
				class: 'presentation-content';
				with: [
					self render: aPresentation on: html ] ] 
]

{ #category : #private }
SGLPresenter >> renderWithTitle: aPresentation on: html [
	self renderWithTitle: aPresentation andAddCloseButton: false on: html
]

{ #category : #private }
SGLPresenter >> renderWithTitleOrNil: aPresentation on: html [
	(aPresentation hasTitleIcon or: [aPresentation hasTitle]) ifFalse: [ ^ self render: aPresentation on: html ].
	self renderWithTitle: aPresentation on: html
]

{ #category : #accessing }
SGLPresenter >> renderer [
	^ renderer
]

{ #category : #accessing }
SGLPresenter >> renderer: anObject [
	renderer := anObject
]

{ #category : #private }
SGLPresenter >> widgetContainerWith: html [
	^ html div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all';
		yourself
]
