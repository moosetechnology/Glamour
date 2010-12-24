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
SGLPresenter >> render: aRenderable on: aRenderer [
	self renderer render: aRenderable on: aRenderer
]

{ #category : #private }
SGLPresenter >> renderActionsFrom: aPresentation on: aRenderer [
	aRenderer render: (SGLActionPresenter for: aPresentation from: self renderer) 
]

{ #category : #private }
SGLPresenter >> renderEmptyPresentationOn: aRenderer [
	aRenderer div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all';
		class: 'glm-empty-presentation'
]

{ #category : #private }
SGLPresenter >> renderPaneWithoutTitle: aPane on: aRenderer [
	aRenderer render: (SGLPaneWithoutTitlePresenter for: aPane from: self)
]

{ #category : #private }
SGLPresenter >> renderTitleOrIconOf: aPresentation on: aRenderer [
	aPresentation hasTitleIcon
		ifTrue: [ 
			aRenderer image
				form: aPresentation titleIconValue  ] 
		ifFalse:  [ aRenderer render: (aPresentation titleValue ifNil: ['']) ]
]

{ #category : #private }
SGLPresenter >> renderWithTitle: aPresentation andAddCloseButton: aBoolean on: aRenderer [
	|id|
	id := aRenderer nextId.
	(self widgetContainerWith: aRenderer)
		script: ( aRenderer jQuery new glamourTabs
			ifEmptyDo: 'remove';
			hasActions: true;
			closable: aBoolean );
		class: 'presentation-with-title';
		with: [
			aRenderer unorderedList				
				class: 'presentation-title';
				with: [
					aRenderer listItem: [ 
							aRenderer anchor
								url: '#', id asString;
								with: [self renderTitleOrIconOf: aPresentation on: aRenderer]  ].
					aRenderer listItem 
						class: 'glm-actions';
						with: [self renderActionsFrom: aPresentation on: aRenderer].
					].
			aRenderer div
				id: id;				
				class: 'presentation-content';
				with: [
					self render: aPresentation on: aRenderer ] ] 
]

{ #category : #private }
SGLPresenter >> renderWithTitle: aPresentation on: aRenderer [
	self renderWithTitle: aPresentation andAddCloseButton: false on: aRenderer
]

{ #category : #private }
SGLPresenter >> renderWithTitleOrNil: aPresentation on: aRenderer [
	(aPresentation hasTitleIcon or: [aPresentation hasTitle]) ifFalse: [ ^ self render: aPresentation on: aRenderer ].
	self renderWithTitle: aPresentation on: aRenderer
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
SGLPresenter >> widgetContainerWith: aRenderer [
	^ aRenderer div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all';
		yourself
]
