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
		into: [ :currentWidth :each |
			|left top newWidth|
			top := each layoutProperties marginTop.
			
			newWidth := currentWidth + each layoutProperties marginLeft.
			left := newWidth.
			
			each isBrick
				ifTrue: [ each brickBounds: ((left@top) extent: (self extentOf: each in: aBrick)) ]
				ifFalse: [ each bounds: (((left@top) extent: (self extentOf: each in: aBrick)) translateBy: aBrick globalBounds origin) ].
				
			newWidth + each width + each layoutProperties marginRight ]

	
]
