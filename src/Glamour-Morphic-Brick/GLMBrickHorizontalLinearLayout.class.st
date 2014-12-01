"
A GLMBrickHorizontalLinearLayout is Linear layout, where all Bricks are being positioned horizintally in one line. The size of Bricks depends only from each Brick's extent. If any Bricks goes outside of the parent with this layout, outside part will not be drawn.

"
Class {
	#name : #GLMBrickHorizontalLinearLayout,
	#superclass : #GLMBrickLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #layouting }
GLMBrickHorizontalLinearLayout >> layout: aBrick in: newBounds [
	|arguments|
	arguments := self prepareArgumentsFor: aBrick.
	
	aBrick subbricks
		inject: 0
		into: [ :leftOffset :each |
			self prepareLayout: each.
			(self supportsFloating: each layoutProperties floating) ifFalse: [
				|layoutBounds|
			
				layoutBounds := GLMBrickLayoutBounds on: (self boundsOf: each in: aBrick withArguments: arguments) of: each.
				layoutBounds translateBy: (leftOffset@0).
				layoutBounds moveOuterToOrigin.
			
				self setNewBounds: layoutBounds to: each in: aBrick.
			
				leftOffset + layoutBounds outerBounds width ]
			ifTrue: [ leftOffset  + ( self layoutFloating: each in: newBounds withArguments: arguments) ] ]

	
]

{ #category : #bounds }
GLMBrickHorizontalLinearLayout >> translate: aBrick by: anInteger [

	aBrick brickBounds: (aBrick brickBounds translateBy: anInteger@0)
]
