"
A GLMBrickHorizontalLinearLayout is Linear layout, where all Bricks are being positioned horizintally in one line. The size of Bricks depends only from each Brick's extent. If any Bricks goes outside of the parent with this layout, outside part will not be drawn.

"
Class {
	#name : #GLMBrickHorizontalLinearLayout,
	#superclass : #GLMBrickLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #accessing }
GLMBrickHorizontalLinearLayout >> layout: aBrick in: newBounds [
	
	aBrick subbricks
		inject: 0
		into: [ :width :each |
			|left top |
			top := each layoutProperties marginTop.
			
			width := width + each layoutProperties marginLeft.
			left := width.
			
			each brickBounds: ((left@top) extent: (self extentOf: each in: aBrick)).
			width + each width + each layoutProperties marginRight.
		]

	
]
