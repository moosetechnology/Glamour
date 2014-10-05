Class {
	#name : #GLMTurboSelectorButtonTrick,
	#superclass : #GLMTurboButtonTrick,
	#instVars : [
		'scroll',
		'selectables',
		'selectedObject',
		'anchorTrick'
	],
	#category : #'Glamour-Morphic-Widgets-Turbo-UI'
}

{ #category : #adding }
GLMTurboSelectorButtonTrick >> addAllSelectableObjects: anArray [

	anArray do: [ :each |
		self addSelectableObject: each.
	]
]

{ #category : #adding }
GLMTurboSelectorButtonTrick >> addSelectableObject: anObject [
	selectables add: anObject.	
]

{ #category : #accessing }
GLMTurboSelectorButtonTrick >> anchorTrick [
	
	^ anchorTrick
]

{ #category : #accessing }
GLMTurboSelectorButtonTrick >> anchorTrick: aTrick [
	
	anchorTrick := aTrick
]

{ #category : #building }
GLMTurboSelectorButtonTrick >> buildSelectableButton: anObject [
	|selectable|
	
	selectable := self newSelectableButton: anObject.
	
	selectable buttonModel object: anObject.
	selectable buttonModel on: GLMPagerButtonClicked send: #onSelected: to: self.
	
	anObject = selectedObject ifTrue: [ 
		selectable buttonModel check.
	].
	
	^selectable.
]

{ #category : #building }
GLMTurboSelectorButtonTrick >> buildSelectableList [
	|maxWidth selectableButtons anchorWidth scrollTarget|
	
	anchorWidth := self anchorTrick
		ifNil: [ self width ]
		ifNotNil: [ self anchorTrick width ].
	
	scrollTarget := self newSelectableList.
			
	scroll := self newScrollPane.
	scroll scrollTarget: scrollTarget.
	
	scroll on: #mouseDown send: #listMouseDown: to: self.
	
	maxWidth := 0.
	selectableButtons := OrderedCollection new.
	selectables do: [ :each | |selectable|
		selectable := self buildSelectableButton: each.
		maxWidth := maxWidth max: (selectable width).
		selectableButtons add: selectable.
		scrollTarget addMorphBack: selectable.
	].

	maxWidth := maxWidth max: (anchorWidth - (self defaultScrollPaneBorderWidth * 2)).

	selectableButtons do: [ :each |
		each width: maxWidth.
	].
	
	scroll height: (
		(self defaultScrollMaxHeight min: (scrollTarget fullBounds height)) + (self defaultScrollPaneBorderWidth * 2)
	).
	
	scroll width: maxWidth + (self defaultScrollPaneBorderWidth * 2).
	
	scroll vScrollbarShowing ifTrue: [ 
		scroll width: scroll width + scroll scrollBarThickness + (self defaultScrollPaneBorderWidth).
	].
]

{ #category : #'event handling' }
GLMTurboSelectorButtonTrick >> click [
	scroll
		ifNil: [ self expandSelection ]
		ifNotNil: [ self collapseSelection ].
	
	^ true.
]

{ #category : #actions }
GLMTurboSelectorButtonTrick >> collapseSelection [

	scroll ifNil: [ ^ self "already collapsed"].
	self root activeHand removeMouseListener: self.
	
	scroll delete.
	scroll := nil.
	
	self uncheck.
]

{ #category : #accessing }
GLMTurboSelectorButtonTrick >> defaultScrollMaxHeight [
	^ 200
]

{ #category : #accessing }
GLMTurboSelectorButtonTrick >> defaultScrollPaneBorderWidth [
	^ 1
]

{ #category : #accessing }
GLMTurboSelectorButtonTrick >> defaultSelectableButtonHeight [
	^ 25
]

{ #category : #accessing }
GLMTurboSelectorButtonTrick >> defaultSelectableWidth [
	^ 200
]

{ #category : #actions }
GLMTurboSelectorButtonTrick >> expandSelection [
	|translate position|
	translate := 0@(self height).
	position := self anchorTrick
		ifNil: [ self worldBounds bottomLeft ]
		ifNotNil: [ self anchorTrick worldBounds bottomLeft ].
	
	scroll ifNotNil: [ self collapseSelection ].
	
	self buildSelectableList.
	scroll ifNil: [ Error signal: 'It seams that scroll morph was not build (is nil)' ].

	scroll openInWorld;
		position: position;
		takeKeyboardFocus.
		
	self root activeHand addMouseListener: self.
	
	self check.
	
	
	
]

{ #category : #'events-processing' }
GLMTurboSelectorButtonTrick >> handleListenEvent: anEvent [
	
	anEvent type = #mouseDown ifTrue: [ 
		(((scroll fullBoundsInWorld containsPoint: anEvent position) not) & ((self worldBounds containsPoint: anEvent position) not))
			ifTrue: [ self collapseSelection ]
	]
]

{ #category : #initialization }
GLMTurboSelectorButtonTrick >> initialize [
	super initialize.
			
	selectables := OrderedCollection new.
	
]

{ #category : #'events-processing' }
GLMTurboSelectorButtonTrick >> listMouseDown: event [
	"nothing to do here"
]

{ #category : #'instance creation' }
GLMTurboSelectorButtonTrick >> newScrollPane [
	|scrollPane|
	
	scrollPane := GeneralScrollPane new			
		changeScrollerTableLayout;
		borderWidth: self defaultScrollPaneBorderWidth;
		borderColor: Color lightGray;
		color: Color white.
	
	^ scrollPane.
]

{ #category : #'instance creation' }
GLMTurboSelectorButtonTrick >> newSelectableButton: anObject [
	|selectable|
	
	selectable := GLMButton new
		buttonModel: GLMTurboSelectableButtonModel new;
		yourself.
		
	self root theme codeWidgetThemer dropDownListButtonStyleFor: selectable.
	selectable label text: anObject asString.
	selectable height: self defaultSelectableButtonHeight.
	
	^ selectable
]

{ #category : #'instance creation' }
GLMTurboSelectorButtonTrick >> newSelectableList [
	^ Morph new
		changeTableLayout;
		changeListDirection: #topToBottom;
		listCentering: #top;
		wrapCentering: #left;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		cellInset: self defaultScrollPaneBorderWidth;
		layoutInset: 0;
		color: Color lightGray;
		yourself.
]

{ #category : #'event handling' }
GLMTurboSelectorButtonTrick >> onButtonClicked [
	scroll
		ifNil: [ self expandSelection ]
		ifNotNil: [ self collapseSelection ]
]

{ #category : #'event handling' }
GLMTurboSelectorButtonTrick >> onSelected: ann [

	self collapseSelection.	
	self announcer announce: (GLMTurboObjectInListSelected new object: ann buttonModel object).
]

{ #category : #initialize }
GLMTurboSelectorButtonTrick >> outOfWorld: aWorld [

	self collapseSelection.
	
	^ super outOfWorld: aWorld
]

{ #category : #accessing }
GLMTurboSelectorButtonTrick >> root: aGLMTurboMorph [
	super root: aGLMTurboMorph.
	
	self root ifNotNil: [ self root theme codeWidgetThemer selectorTurboButtonStyleFor: self ]
	
	
]

{ #category : #accessing }
GLMTurboSelectorButtonTrick >> selectedObject: anObject [

	selectedObject := anObject.
]
