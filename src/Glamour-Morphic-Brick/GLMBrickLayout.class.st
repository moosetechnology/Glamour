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

{ #category : #'as yet unclassified' }
GLMBrickLayout >> layoutFloating: aBrick in: newBounds [
	|float left top right bottom|
	float := aBrick layoutProperties floating.
	float = #none ifTrue: [ ^ self ].
	
	float = #right ifTrue: [
		left := aBrick owner width - aBrick width - aBrick layoutProperties marginRight.
		top := aBrick layoutProperties marginTop.
		right := aBrick owner width - aBrick layoutProperties marginRight.
		bottom := aBrick owner height - aBrick layoutProperties marginBottom.
		
		aBrick isBrick
				ifTrue: [ aBrick brickBounds: ((left@top) corner: right@bottom) ]
				ifFalse: [ aBrick bounds: (((left@top) corner: right@bottom) translateBy: aBrick globalBounds origin) ] ].
]
