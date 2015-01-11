"
A GLMBrickVerticalLinearLayout is Linear layout, where all Bricks are being positioned vertically in one line. The size of Bricks depends only from each Brick's extent. If any Bricks goes outside of the parent with this layout, outside part will not be drawn.

"
Class {
	#name : #GLMBrickVerticalLinearLayout,
	#superclass : #GLMBrickLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMBrickVerticalLinearLayout class >> example [
	"self example"
	super example
]

{ #category : #layouting }
GLMBrickVerticalLinearLayout >> layout: aBrick in: newBounds [
	|arguments|
	arguments := self prepareArgumentsFor: aBrick.
	
	aBrick subbricks
		inject: 0
		into: [ :topOffset :each |
			self prepareLayout: each.
			
			(self supportsFloating: each layoutProperties floating) ifFalse: [
				|layoutBounds|
			
				layoutBounds := GLMBrickLayoutBounds on: (self boundsOf: each in: aBrick withArguments: arguments) of: each.
				layoutBounds translateBy: (0@topOffset).
				layoutBounds moveOuterToOrigin.
			
				self setNewBounds: layoutBounds to: each in: aBrick.
			
				topOffset + layoutBounds outerBounds height ]
			ifTrue: [ topOffset + (self layoutFloating: each in: newBounds withArguments: arguments) ] ]
]

{ #category : #bounds }
GLMBrickVerticalLinearLayout >> translate: aBrick by: anInteger [

	aBrick brickBounds: (aBrick brickBounds translateBy: 0@anInteger)
]
