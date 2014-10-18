"
A GLMBrickVerticalFillLinearLayout is Linear layout, where all Bricks are being positioned vertically in one line. The size of Bricks depends only from each Brick's extent. If any Bricks goes outside of the parent with this layout, outside part will not be drawn. The width of all elements in this layout is the same

"
Class {
	#name : #GLMBrickVerticalFillLinearLayout,
	#superclass : #GLMBrickVerticalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickVerticalFillLinearLayout >> extentOf: aBrick in: owner [

	^ (owner width - aBrick layoutProperties marginLeft - aBrick layoutProperties marginRight) @ (aBrick height)
]
