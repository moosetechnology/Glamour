"
A GLMScrollPaneBrick is a very simple scrollpane with support of light scrollbar.
Acceleration mechanism is used for scrolling, as longer user scrolls faster it becomes.

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
	#superclass : #GLMGeneralScrollPaneBrick,
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'accessing - defaults' }
GLMScrollPaneBrick class >> defaultMaxVelocity [
	^ self defaultScrollVelocity * 4
]

{ #category : #'accessing - defaults' }
GLMScrollPaneBrick class >> defaultScrollAcceleration [
	^ 2
]

{ #category : #'accessing - defaults' }
GLMScrollPaneBrick class >> defaultScrollTimeReset [
	^ 350
]

{ #category : #'accessing - defaults' }
GLMScrollPaneBrick class >> defaultScrollTurboTime [

	^ 30
]

{ #category : #'accessing - defaults' }
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

{ #category : #scrolling }
GLMScrollPaneBrick >> scrollDown: anInteger [
	
	band brickBounds corner y <= self height ifTrue: [
		band brickBounds: (band brickBounds translateBy: (0@ (self height - band brickBounds corner y))). ^ self ].
	band brickBounds: (band brickBounds translateBy: (0@ anInteger) negated).
	band brickBounds corner y < self height ifTrue: [ band brickBounds: (band brickBounds translateBy: (0@ (self height - band brickBounds corner y))) ]
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
	
	scrollPosition := band brickBounds top.
	
	self update.
	self changed.
	
	
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
