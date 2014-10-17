"
A GLMBrickHorizontalFillProportionalLinearLayout is a slight modification of ProportionalLayout but all elements have the same height and it is the same as parent's
"
Class {
	#name : #GLMBrickHorizontalFillProportionalLinearLayout,
	#superclass : #GLMBrickHorizontalProportionalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickHorizontalFillProportionalLinearLayout >> extentOf: aBrick in: owner [
	
	^ ((owner width * aBrick layoutProperties horizontalPercent / 100) ceiling - aBrick layoutProperties marginLeft - aBrick layoutProperties marginRight) @ (owner height - aBrick layoutProperties marginTop - aBrick layoutProperties marginBottom)
]
