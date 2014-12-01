"
A GLMBrickHorizontalFillProportionalLinearLayout is a slight modification of ProportionalLayout but all elements have the same height and it is the same as parent's
"
Class {
	#name : #GLMBrickHorizontalFillProportionalLinearLayout,
	#superclass : #GLMBrickHorizontalProportionalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #layouting }
GLMBrickHorizontalFillProportionalLinearLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	|extent|
	extent := super extentOf: aBrick in: owner withArguments: aHashTable.
	^ (extent x)@(owner brickInnerBounds height - aBrick layoutProperties verticalMargin)
]
