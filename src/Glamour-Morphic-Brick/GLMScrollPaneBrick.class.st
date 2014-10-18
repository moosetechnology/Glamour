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
		'currentVelocity'
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

{ #category : #adding }
GLMScrollPaneBrick >> addBrickBack: aBrick [
	band addBrickBack: aBrick
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick >> calculateVelocity: event [
	
	event timeStamp - lastScrollTimeStamp > self class defaultScrollTimeReset
		ifTrue: [ currentVelocity := self class defaultScrollVelocity ]
		ifFalse: [ currentVelocity := (currentVelocity + self class defaultScrollAcceleration) min: self class defaultMaxVelocity ].
		
	lastScrollTimeStamp := event timeStamp.
	
	^ currentVelocity
]

{ #category : #initialization }
GLMScrollPaneBrick >> initialize [
	super initialize.
	
	lastScrollTimeStamp := 0.
	currentVelocity := self class defaultScrollVelocity.
	
	band := GLMBandBrick new.
	
	self layoutPolicy: GLMBrickVerticalFillLinearLayout new.
	super addBrickBack: band.
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
