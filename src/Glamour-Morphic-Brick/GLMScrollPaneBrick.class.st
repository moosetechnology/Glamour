"
asdasd
asd
asd
"
Class {
	#name : #GLMScrollPaneBrick,
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

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> defaultMaxVelocity [
	^ self defaultScrollVelocity * 4
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> defaultScrollAcceleration [
	^ 2
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> defaultScrollTimeReset [
	^ 350
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> defaultScrollTurboTime [

	^ 30
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> defaultScrollVelocity [
	^ 15
]

{ #category : #examples }
GLMScrollPaneBrick class >> example [
	|foundation scrollPane|
	
	scrollPane := self new.
	
	foundation := GLMFoundationBrick new.
	foundation brickRoot: scrollPane.
	
	1 to: 20 do: [ :index |
		scrollPane addBrickBack: (GLMBrick new
			color: Color random;
			extent: 50@50).
	].
	
	foundation extent: 200@200.
	
	foundation openInWindow
]

{ #category : #examples }
GLMScrollPaneBrick class >> exampleLarge [
	|foundation scrollPane|
	
	scrollPane := self new.
	
	foundation := GLMFoundationBrick new.
	foundation brickRoot: scrollPane.
	
	1 to: 10000 do: [ :index |
		scrollPane addBrickBack: (GLMBrick new
			color: Color random;
			extent: 200@50).
	].
	
	foundation extent: 400@300.
	
	foundation openInWindow
]

{ #category : #adding }
GLMScrollPaneBrick >> addBrick: aBrick before: anotherBrick [
	self band addBrick: aBrick before: anotherBrick
]

{ #category : #adding }
GLMScrollPaneBrick >> addBrickBack: aBrick [
	self band addBrickBack: aBrick
]

{ #category : #accessing }
GLMScrollPaneBrick >> allowedBounds [

	^ self globalBounds
]

{ #category : #accessing }
GLMScrollPaneBrick >> band [

	^ band
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick >> calculateMaxVelocity [

	"max velocity must depend from the height of the band"
	^ (self band height / 15) max: self class defaultMaxVelocity
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick >> calculateVelocity: event [
	|delta|
	delta := event timeStamp - lastScrollTimeStamp.
		
	delta > self class defaultScrollTimeReset
		ifTrue: [ currentVelocity := self class defaultScrollVelocity ]
		ifFalse: [ currentVelocity := (currentVelocity + self class defaultScrollAcceleration * (delta <= self class defaultScrollTurboTime ifTrue: [ 2 ] ifFalse: [ 1 ] )) min: self calculateMaxVelocity ].
		
	lastScrollTimeStamp := event timeStamp.
	
	^ currentVelocity ceiling
]

{ #category : #accessing }
GLMScrollPaneBrick >> defaultScrollbarPosition [

	^ #right
]

{ #category : #accessing }
GLMScrollPaneBrick >> defaultScrollbarWidth [

	^ 5
]

{ #category : #layouting }
GLMScrollPaneBrick >> doLayout [
	super doLayout.
	self update.
]

{ #category : #'mouse events' }
GLMScrollPaneBrick >> handleListenEvent: anEvent [
	
	"checking if it's keyboard event (mouse wheel is keyboard event on windows o_O (wtf?)"
	anEvent type = #keystroke ifTrue: [
		"checking if mouse is inside me"
		((self boundsInWorld containsPoint: anEvent position)) ifTrue: [
			"actuall scrolling"
			self scrollByKeyboard: anEvent ] ]
]

{ #category : #'mouse events' }
GLMScrollPaneBrick >> handlesMouseWheel: evt [
	^ true
]

{ #category : #initialization }
GLMScrollPaneBrick >> initialize [
	super initialize.
	
	lastScrollTimeStamp := 0.
	currentVelocity := self class defaultScrollVelocity.
	scrollPosition := 0.
	
	band := self newBand.
	
	self layoutPolicy: GLMBrickVerticalFillLayout new.
	super addBrickBack: band.
	
	self verticalScrollbar: self newVerticalScrollbar.
	
	"initializes listener for mouse wheel scroll on windows vm"
	self initializeListeners.
]

{ #category : #initialize }
GLMScrollPaneBrick >> initializeListeners [

	"using the most general event subscribtion for all events spawned by the hand"
	self activeHand addEventListener: self.
]

{ #category : #testing }
GLMScrollPaneBrick >> isFirstVisible [

	self band hasSubbricks ifFalse: [ ^ true ].
	^ self isVisible: self band firstSubbrick
]

{ #category : #testing }
GLMScrollPaneBrick >> isFullyVisible [

	^ self isFirstVisible & self isLastVisible
]

{ #category : #testing }
GLMScrollPaneBrick >> isKeyboardScrollEvent: anEvent [

	(anEvent controlKeyPressed | anEvent commandKeyPressed) ifFalse: [^ false ].
	anEvent keyValue = 30 ifTrue: [ ^ true ].
	anEvent keyValue = 31 ifTrue: [ ^ true ].
	^ false
]

{ #category : #testing }
GLMScrollPaneBrick >> isLastVisible [

	self band hasSubbricks ifFalse: [ ^ true ].
	^ self isVisible: self band lastSubbrick
]

{ #category : #testing }
GLMScrollPaneBrick >> isPartiallyVisible: aBrick [
	|myBounds testingBounds|
	"need to normalize bounds to take only y coordinate into account"
	
	myBounds := (self allowedBounds withWidth: 1) translateBy: (self allowedBounds origin negated x@0).
	testingBounds :=  (aBrick globalBounds withWidth: 1) translateBy: (aBrick globalBounds origin negated x@0).
	
	^ myBounds intersects: testingBounds
]

{ #category : #testing }
GLMScrollPaneBrick >> isVisible: aBrick [
	|myBounds testingBounds|
	"need to normalize bounds to take only y coordinate into account"
	
	myBounds := (self allowedBounds withWidth: 0) translateBy: (self allowedBounds origin negated x@0).
	testingBounds :=  (aBrick globalBounds withWidth: 0) translateBy: (aBrick globalBounds origin negated x@0).
	
	^ myBounds containsRect: testingBounds
]

{ #category : #'mouse events' }
GLMScrollPaneBrick >> mouseWheel: event [

	self scrollBy: (self calculateVelocity: event) direction: event direction.
]

{ #category : #'instance creation' }
GLMScrollPaneBrick >> newBand [

	^ GLMBandBrick new
]

{ #category : #'instance creation' }
GLMScrollPaneBrick >> newVerticalScrollbar [
	^ GLMScrollbarBrick new
]

{ #category : #initialize }
GLMScrollPaneBrick >> outOfWorld: aWorld [
	super outOfWorld: aWorld.
	
	self unsubscribeListeners
]

{ #category : #private }
GLMScrollPaneBrick >> privateAddBrickBack: aBrick [

	super addBrickBack: aBrick
]

{ #category : #adding }
GLMScrollPaneBrick >> removeAllBricks [
	
	self band removeAllBricks.
	self scrollToTop
]

{ #category : #adding }
GLMScrollPaneBrick >> removeBrick: aBrick [
	self band removeBrick: aBrick
]

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollBy: anInteger direction: aSymbol [

	self isFullyVisible ifTrue: [ ^ self ].
	
	aSymbol = #up ifTrue: [ self scrollUp: anInteger ].
	aSymbol = #down ifTrue: [ self scrollDown: anInteger ].
	
	self update.
	scrollPosition := band brickBounds top.
	self changed
]

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollByKeyboard: anEvent [
	|velocity direction|
	
	(self isKeyboardScrollEvent: anEvent) ifFalse: [^ self ].
	velocity := self calculateVelocity: anEvent.
	
	"keycode 30 is Event direction = #up"
	anEvent keyValue = 30 ifTrue: [ direction := #up ].
	"keycode 31 is Event direction = #down"
	anEvent keyValue = 31 ifTrue: [ direction := #down ].
	self scrollBy: velocity direction: direction
]

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollDown: anInteger [
	
	band brickBounds corner y <= self height ifTrue: [
		band brickBounds: (band brickBounds translateBy: (0@ (self height - band brickBounds corner y))). ^ self ].
	band brickBounds: (band brickBounds translateBy: (0@ anInteger) negated).
	band brickBounds corner y < self height ifTrue: [ band brickBounds: (band brickBounds translateBy: (0@ (self height - band brickBounds corner y))) ]
]

{ #category : #accessing }
GLMScrollPaneBrick >> scrollPositionBottom [

	^ self scrollPositionTop + self innerBounds height
]

{ #category : #accessing }
GLMScrollPaneBrick >> scrollPositionTop [

	^ scrollPosition ifNil: [ scrollPosition := 0 ]
]

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollTo: aBrick [
	|delta|
	"if already visible no need to scroll"
	(self isVisible: aBrick) ifTrue: [ ^ self ].
	
	delta := ((self allowedBounds top - band globalBounds top) - (aBrick globalBounds top - band globalBounds top)).
	delta < 0 ifTrue: [ delta := delta + self allowedBounds height - aBrick height ].
		
	band brickBounds: (band brickBounds translateBy: (0@ delta)).
	band brickBounds corner y < self height
		ifTrue: [ band brickBounds: (band brickBounds translateBy: (0@ (self height - band brickBounds corner y))) ].
		
	(band brickBounds origin y > 0)
		ifTrue: [ band brickBounds: (band brickBounds translateBy: (0@ band brickBounds origin y) negated) ].
	
	self update.
	scrollPosition := band brickBounds top.
	self changed.
	
	
]

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollToBottom [

	self band hasSubbricks ifFalse: [ ^ self ].
	self scrollTo: self band lastSubbrick
]

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollToTop [

	self scrollBy: self scrollPositionTop negated direction: #up
]

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollUp: anInteger [

	"preventing from scrolling if already at the top"
	band brickBounds origin y >= 0 ifTrue: [
		band brickBounds: (band brickBounds translateBy: (0@ band brickBounds origin y negated)). ^ self ].
	"actuall scrolling"
	band brickBounds: (band brickBounds translateBy: (0@ anInteger)).
	"returning scrollpane back if went away"
	band brickBounds origin y > 0 ifTrue: [ band brickBounds: (band brickBounds translateBy: (0@ band brickBounds origin y) negated) ]
]

{ #category : #initialize }
GLMScrollPaneBrick >> unsubscribeListeners [

	self activeHand removeEventListener: self
]

{ #category : #scrolling }
GLMScrollPaneBrick >> update [

	self scrollDown: 0.
	self scrollUp: 0.
	self verticalScrollbar update
]

{ #category : #accessing }
GLMScrollPaneBrick >> verticalScrollbar [

	^ verticalScrollbar
]

{ #category : #accessing }
GLMScrollPaneBrick >> verticalScrollbar: aBrick [

	verticalScrollbar := aBrick.
	verticalScrollbar width: self defaultScrollbarWidth.
	verticalScrollbar layoutProperties floating: self defaultScrollbarPosition.
	verticalScrollbar scrollPane: self.
	super addBrickBack: verticalScrollbar
]
