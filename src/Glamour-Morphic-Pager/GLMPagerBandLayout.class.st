Class {
	#name : #GLMPagerBandLayout,
	#superclass : #GLMBrickHorizontalFillLinearLayout,
	#category : #'Glamour-Morphic-Pager-Layouts'
}

{ #category : #layouting }
GLMPagerBandLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	
	^ (owner width / (owner subbricksCount) - aBrick layoutProperties horizontalMargin)@(owner brickInnerBounds height - aBrick layoutProperties verticalMargin)
]
