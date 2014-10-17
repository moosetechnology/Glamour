"
A GLMBrickLayout is low level layout class providing api for positioning bricks with specific order

"
Class {
	#name : #GLMBrickLayout,
	#superclass : #LayoutPolicy,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickLayout >> extentOf: aBrick in: owner [
	^ aBrick extent
]

{ #category : #accessing }
GLMBrickLayout >> layout: aBrick in: newBounds [
	self subclassResponsibility
]
