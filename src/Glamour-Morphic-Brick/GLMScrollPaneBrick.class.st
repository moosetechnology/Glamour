"
A GLMScrollPaneBrick is a very simple scrollpane, that has no scrollbars.
For scrolling used acceleration algorithm, so as longer user scroll so faster it becomes.

Instance Variables
	band:		<Object>
	currentVelocity:		<Object>
	lastScrollTimeStamp:		<Object>

band
	- xxxxx

currentVelocity
	- xxxxx

lastScrollTimeStamp
	- xxxxx

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

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> example [
	|foundation scrollPane|
	
	scrollPane := GLMScrollPaneBrick new.
	
	foundation := GLMFoundationBrick new.
	foundation brickRoot: scrollPane.
	
	1 to: 20 do: [ :index |
		scrollPane addBrickBack: (GLMBrick new
			color: Color random;
			extent: 200@50).
	].
	
	foundation extent: 200@200.
	
	foundation openInWindow
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> exampleLarge [
	|foundation scrollPane|
	
	scrollPane := GLMScrollPaneBrick new.
	
	foundation := GLMFoundationBrick new.
	foundation brickRoot: scrollPane.
	
	1 to: 20000 do: [ :index |
		scrollPane addBrickBack: (GLMBrick new
			color: Color random;
			extent: 200@50).
	].
	
	foundation extent: 200@200.
	
	foundation openInWindow
]

{ #category : #adding }
GLMScrollPaneBrick >> addBrick: aBrick before: anotherBrick [
	band addBrick: aBrick before: anotherBrick
]

{ #category : #adding }
GLMScrollPaneBrick >> addBrickBack: aBrick [
	band addBrickBack: aBrick
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
	
	^ currentVelocity
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
	
	band brickBounds: (band brickBounds translateBy: (0@(scrollPosition - band brickBounds top))).
	
	self verticalScrollbar update.
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
	
	self layoutPolicy: GLMBrickVerticalFillLinearLayout new.
	super addBrickBack: band.
	
	self verticalScrollbar: self newVerticalScrollbar
]

{ #category : #testing }
GLMScrollPaneBrick >> isVisible: aBrick [
	|myBounds testingBounds|
	"need to normalize bounds to take only y coordinate into account"
	
	myBounds := (self globalBounds withWidth: 0) translateBy: (self globalBounds origin negated x@0).
	testingBounds :=  (aBrick globalBounds withWidth: 0) translateBy: (aBrick globalBounds origin negated x@0).
	
	^ myBounds containsRect: testingBounds
]

{ #category : #'mouse events' }
GLMScrollPaneBrick >> mouseWheel: event [
	|velocity|
	
	velocity := self calculateVelocity: event.
	
	event direction = #up
		ifTrue: [ self scrollUp: velocity ].
		
	event direction = #down
		ifTrue: [ self scrollDown: -1 * velocity ].
	
	scrollPosition := band brickBounds top.
	
	self verticalScrollbar update.
	
	self changed
]

{ #category : #'instance creation' }
GLMScrollPaneBrick >> newBand [

	^ GLMBandBrick new
]

{ #category : #'instance creation' }
GLMScrollPaneBrick >> newVerticalScrollbar [
	^ GLMScrollbarBrick new
]

{ #category : #adding }
GLMScrollPaneBrick >> removeAllBricks [

	band subbricks do: [ :each |
		each isBrick ifTrue: [
			each brickRoot: nil.
			each brickOwner: nil ] ].
	
	band subbricks removeAll.
	band removeAllMorphs
]

{ #category : #adding }
GLMScrollPaneBrick >> removeBrick: aBrick [
	band removeBrick: aBrick
]

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollDown: anInteger [

	band brickBounds corner y <= self height ifTrue: [ ^ self ].
	band brickBounds: (band brickBounds translateBy: (0@ anInteger)).
	band brickBounds corner y < self height ifTrue: [ band brickBounds: (band brickBounds translateBy: (0@ (self height - band brickBounds corner y))) ]
]

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollTo: aBrick [
	|delta|
	"if already visible no need to scroll"
		
	(self isVisible: aBrick) ifTrue: [ ^ self ].
	
	delta := ((self globalBounds top - band globalBounds top) - (aBrick globalBounds top - band globalBounds top)).
	delta < 0 ifTrue: [ delta := delta + self height - aBrick height ].
		
	band brickBounds: (band brickBounds translateBy: (0@ delta)).
	
	scrollPosition := band brickBounds top.
	
	self verticalScrollbar update.
	self changed.
	
	
]

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollUp: anInteger [

	"preventing from scrolling if already at the top"
	band brickBounds origin y >= 0 ifTrue: [ ^ self ].
	"actuall scrolling"
	band brickBounds: (band brickBounds translateBy: (0@ anInteger)).
	"returning scrollpane back if went away"
	band brickBounds origin y > 0 ifTrue: [ band brickBounds: (band brickBounds translateBy: (0@ band brickBounds origin y) negated) ]
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
