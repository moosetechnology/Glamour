Class {
	#name : #GLMBrickVerticalStackLayout,
	#superclass : #GLMBrickVerticalFillLinearLayout,
	#instVars : [
		'topStackHeight',
		'bottomStackHeight',
		'visibleBounds'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> layout: aBrick in: newBounds [
	
	visibleBounds := newBounds.
	topStackHeight := 0.
	bottomStackHeight := 0.
	
	super layout: aBrick in: newBounds.
]
