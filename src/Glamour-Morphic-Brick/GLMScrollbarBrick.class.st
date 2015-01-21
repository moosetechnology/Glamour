"
A GLMScrollbarBrick is vertical scollbar for a scrollpane. User can't interact with it

Instance Variables
	bar:		<Object>
	scrollPane:		<Object>

bar
	- xxxxx

scrollPane
	- xxxxx

"
Class {
	#name : #GLMScrollbarBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'scrollPane',
		'bar'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMScrollbarBrick >> bar [

	^ bar
]

{ #category : #'as yet unclassified' }
GLMScrollbarBrick >> bar: aBrick [

	bar := aBrick.
	bar color: Color veryLightGray.
	self addBrickBack: aBrick
]

{ #category : #'as yet unclassified' }
GLMScrollbarBrick >> calculateScrollbarHeight [

	^ (((self scrollPane height) / (self scrollPane band height)) * self height) ceiling.
]

{ #category : #'as yet unclassified' }
GLMScrollbarBrick >> calculateScrollbarTopOffset [

	^ (((self height) / (self scrollPane band height)) * (self scrollPane band brickBounds top abs)) floor.
]

{ #category : #'as yet unclassified' }
GLMScrollbarBrick >> initialize [
	super initialize.
	
	self layoutPolicy: GLMBrickNoLayout new.
	self bar: self newBar
]

{ #category : #'as yet unclassified' }
GLMScrollbarBrick >> newBar [

	^ GLMBrick new
]

{ #category : #accessing }
GLMScrollbarBrick >> scrollPane [
	^ scrollPane
]

{ #category : #accessing }
GLMScrollbarBrick >> scrollPane: anObject [
	scrollPane := anObject.
	self update.
]

{ #category : #'as yet unclassified' }
GLMScrollbarBrick >> update [
	|height top width|
	
	self scrollPane band height = 0 ifTrue: [
		bar brickBounds: ((0@0) extent: 0@0).
		^ self changed.
	].
	
	height := self calculateScrollbarHeight.
	top := self calculateScrollbarTopOffset.
	
	width := (height >= self height)
		ifTrue: [ 0 ]
		ifFalse: [ self width ].
	
	bar brickBounds: ((0@top) extent: width@height).
	
	self changed
]
