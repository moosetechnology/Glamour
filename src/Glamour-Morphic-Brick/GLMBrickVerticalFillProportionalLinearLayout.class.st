"
A GLMBrickVerticalFillProportionalLinearLayout is a slight modification of VerticalProportionalLayout but all elements have the same width and it is the same as parent's
"
Class {
	#name : #GLMBrickVerticalFillProportionalLinearLayout,
	#superclass : #GLMBrickVerticalProportionalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickVerticalFillProportionalLinearLayout >> extentOf: aBrick in: owner [
	
	^ (owner width - aBrick layoutProperties marginLeft - aBrick layoutProperties marginRight) @ ((owner height * aBrick layoutProperties verticalPercent / 100) ceiling - aBrick layoutProperties marginTop - aBrick layoutProperties marginBottom)
]
