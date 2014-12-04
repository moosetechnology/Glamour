Class {
	#name : #GLMPagerLayout,
	#superclass : #GLMBrickHorizontalFillLinearLayout,
	#category : #'Glamour-Morphic-Pager-Layouts'
}

{ #category : #bounds }
GLMPagerLayout >> boundsOf: aBrick in: owner withArguments: aHashTable [
	
	^ (super boundsOf: aBrick in: owner withArguments: aHashTable) translateBy: (owner scrollValue@ 0).
]
