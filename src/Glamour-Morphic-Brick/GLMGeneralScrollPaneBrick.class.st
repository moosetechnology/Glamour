"
A GLMGeneralScrollPaneBrick is an abstract scroll pane implementation, that takes controll of keyboard and mouse events

Instance Variables
	band:		<Object>
	currentVelocity:		<Object>
	lastScrollTimeStamp:		<Object>
	scrollPosition:		<Object>
	verticalScrollbar:		<Object>

band
	- xxxxx

currentVelocity
	- xxxxx

lastScrollTimeStamp
	- xxxxx

scrollPosition
	- xxxxx

verticalScrollbar
	- xxxxx

"
Class {
	#name : #GLMGeneralScrollPaneBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'band',
		'lastScrollTimeStamp',
		'currentVelocity',
		'verticalScrollbar',
		'scrollPosition'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #adding }
GLMGeneralScrollPaneBrick >> addBrick: aBrick before: anotherBrick [
	band addBrick: aBrick before: anotherBrick
]

{ #category : #adding }
GLMGeneralScrollPaneBrick >> addBrickBack: aBrick [
	band addBrickBack: aBrick
]

{ #category : #accessing }
GLMGeneralScrollPaneBrick >> allowedBounds [

	^ self globalBounds
]

{ #category : #accessing }
GLMGeneralScrollPaneBrick >> band [

	^ band
]

{ #category : #'as yet unclassified' }
GLMGeneralScrollPaneBrick >> calculateMaxVelocity [

	"max velocity must depend from the height of the band"
	^ (self band height / 15) max: self class defaultMaxVelocity
]

{ #category : #'as yet unclassified' }
GLMGeneralScrollPaneBrick >> calculateVelocity: event [
	|delta|
	delta := event timeStamp - lastScrollTimeStamp.
		
	delta > self class defaultScrollTimeReset
		ifTrue: [ currentVelocity := self class defaultScrollVelocity ]
		ifFalse: [ currentVelocity := (currentVelocity + self class defaultScrollAcceleration * (delta <= self class defaultScrollTurboTime ifTrue: [ 2 ] ifFalse: [ 1 ] )) min: self calculateMaxVelocity ].
		
	lastScrollTimeStamp := event timeStamp.
	
	^ currentVelocity ceiling
]

{ #category : #accessing }
GLMGeneralScrollPaneBrick >> defaultScrollbarPosition [

	^ #right
]

{ #category : #accessing }
GLMGeneralScrollPaneBrick >> defaultScrollbarWidth [

	^ 5
]

{ #category : #layouting }
GLMGeneralScrollPaneBrick >> doLayout [
	super doLayout.
	
	self band brickBounds: (self band brickBounds translateBy: (0@(self scrollPositionTop - self band brickBounds top))).
	
	self update
]

{ #category : #'mouse events' }
GLMGeneralScrollPaneBrick >> handleListenEvent: anEvent [
	
	"checking if it's keyboard event (mouse wheel is keyboard event on windows o_O (wtf?)"
	anEvent type = #keystroke ifTrue: [
		"checking if mouse is inside me"
		((self boundsInWorld containsPoint: anEvent position)) ifTrue: [
			"actuall scrolling"
			self scrollByKeyboard: anEvent ] ]
]

{ #category : #'mouse events' }
GLMGeneralScrollPaneBrick >> handlesMouseWheel: evt [
	^ true
]

{ #category : #initialization }
GLMGeneralScrollPaneBrick >> initialize [
	super initialize.
	
	lastScrollTimeStamp := 0.
	currentVelocity := self class defaultScrollVelocity.
	scrollPosition := 0.
	
	band := self newBand.
	
	self layoutPolicy: GLMBrickVerticalFillLinearLayout new.
	super addBrickBack: band.
	
	self verticalScrollbar: self newVerticalScrollbar.
	
	"initializes listener for mouse wheel scroll on windows vm"
	self initializeListeners.
]

{ #category : #initialize }
GLMGeneralScrollPaneBrick >> initializeListeners [

	"using the most general event subscribtion for all events spawned by the hand"
	self activeHand addEventListener: self.
]

{ #category : #testing }
GLMGeneralScrollPaneBrick >> isKeyboardScrollEvent: anEvent [

	(anEvent controlKeyPressed | anEvent commandKeyPressed) ifFalse: [^ false ].
	anEvent keyValue = 30 ifTrue: [ ^ true ].
	anEvent keyValue = 31 ifTrue: [ ^ true ].
	^ false
]

{ #category : #testing }
GLMGeneralScrollPaneBrick >> isVisible: aBrick [
	|myBounds testingBounds|
	"need to normalize bounds to take only y coordinate into account"
	
	myBounds := (self allowedBounds withWidth: 0) translateBy: (self allowedBounds origin negated x@0).
	testingBounds :=  (aBrick globalBounds withWidth: 0) translateBy: (aBrick globalBounds origin negated x@0).
	
	^ myBounds containsRect: testingBounds
]

{ #category : #'mouse events' }
GLMGeneralScrollPaneBrick >> mouseWheel: event [
	|velocity|
	
	velocity := self calculateVelocity: event.
	
	event direction = #up
		ifTrue: [ self scrollUp: velocity ].
		
	event direction = #down
		ifTrue: [ self scrollDown: velocity ].
	
	scrollPosition := band brickBounds top.
	
	self update.
	self changed
]

{ #category : #'instance creation' }
GLMGeneralScrollPaneBrick >> newBand [

	^ GLMBandBrick new
]

{ #category : #'instance creation' }
GLMGeneralScrollPaneBrick >> newVerticalScrollbar [
	^ GLMScrollbarBrick new
]

{ #category : #initialize }
GLMGeneralScrollPaneBrick >> outOfWorld: aWorld [
	super outOfWorld: aWorld.
	
	self unsubscribeListeners
]

{ #category : #adding }
GLMGeneralScrollPaneBrick >> removeAllBricks [

	band subbricks do: [ :each |
		each isBrick ifTrue: [
			each brickRoot: nil.
			each brickOwner: nil ] ].
	
	band subbricks removeAll.
	band removeAllMorphs
]

{ #category : #adding }
GLMGeneralScrollPaneBrick >> removeBrick: aBrick [
	band removeBrick: aBrick
]

{ #category : #scrolling }
GLMGeneralScrollPaneBrick >> scrollByKeyboard: anEvent [
	|velocity|
	
	(self isKeyboardScrollEvent: anEvent) ifFalse: [^ self ].
	velocity := self calculateVelocity: anEvent.
	
	"keycode 30 is Event direction = #up"
	anEvent keyValue = 30 ifTrue: [ self scrollUp: velocity ].
	"keycode 31 is Event direction = #down"
	anEvent keyValue = 31 ifTrue: [ self scrollDown: velocity ].
	
	scrollPosition := band brickBounds top.
	
	self update.
	self changed
]

{ #category : #scrolling }
GLMGeneralScrollPaneBrick >> scrollDown: anInteger [

	self subclassResponsibility
]

{ #category : #accessing }
GLMGeneralScrollPaneBrick >> scrollPositionBottom [

	^ self scrollPositionTop + self brickInnerBounds height
]

{ #category : #accessing }
GLMGeneralScrollPaneBrick >> scrollPositionTop [

	^ scrollPosition ifNil: [ scrollPosition := 0 ]
]

{ #category : #scrolling }
GLMGeneralScrollPaneBrick >> scrollTo: aBrick [

	self subclassResponsibility
]

{ #category : #scrolling }
GLMGeneralScrollPaneBrick >> scrollUp: anInteger [

	self subclassResponsibility
]

{ #category : #initialize }
GLMGeneralScrollPaneBrick >> unsubscribeListeners [

	self activeHand removeEventListener: self
]

{ #category : #scrolling }
GLMGeneralScrollPaneBrick >> update [

	self verticalScrollbar update
]

{ #category : #accessing }
GLMGeneralScrollPaneBrick >> verticalScrollbar [

	^ verticalScrollbar
]

{ #category : #accessing }
GLMGeneralScrollPaneBrick >> verticalScrollbar: aBrick [

	verticalScrollbar := aBrick.
	verticalScrollbar width: self defaultScrollbarWidth.
	verticalScrollbar layoutProperties floating: self defaultScrollbarPosition.
	verticalScrollbar scrollPane: self.
	super addBrickBack: verticalScrollbar
]
