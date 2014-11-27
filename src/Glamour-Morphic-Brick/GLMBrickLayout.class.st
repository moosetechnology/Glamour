"
A GLMBrickLayout is low level layout class providing api for positioning bricks with specific order

"
Class {
	#name : #GLMBrickLayout,
	#superclass : #LayoutPolicy,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickLayout class >> example [

	|foundationBrick rootBrick brick1 brick2 brick3|
	
	rootBrick := GLMBrick new.
	rootBrick layoutPolicy: self new.
	
	rootBrick layoutProperties paddingLeft: 10.	
	rootBrick layoutProperties paddingTop: 15.
	rootBrick layoutProperties paddingRight: 20.	
	rootBrick layoutProperties paddingBottom: 5.
	rootBrick color: Color blue.
	
	brick1 := GLMBrick new.
	brick1 layoutProperties marginLeft: 10.	
	brick1 layoutProperties marginTop: 15.	
	brick1 layoutProperties marginRight: 20.	
	brick1 layoutProperties marginBottom: 5.
	brick1 layoutProperties horizontalPercent: 30.
	brick1 layoutProperties verticalPercent: 30.
	brick1 extent: 50@70.
	brick1 color: Color red.
	
	brick2 := GLMBrick new.
	brick2 layoutProperties marginLeft: 10.	
	brick2 layoutProperties marginTop: 15.	
	brick2 layoutProperties marginRight: 20.
	brick2 layoutProperties marginBottom: 5.
	brick2 layoutProperties horizontalPercent: 50.
	brick2 layoutProperties verticalPercent: 50.
	brick2 color: Color green.
	brick2 extent: 70@60.
	
	brick3 := GLMBrick new.
	brick3 layoutProperties marginLeft: 10.	
	brick3 layoutProperties marginTop: 15.	
	brick3 layoutProperties marginRight: 20.	
	brick3 layoutProperties marginBottom: 5.
	brick3 layoutProperties horizontalPercent: 20.
	brick3 layoutProperties verticalPercent: 20.
	brick3 color: Color yellow.
	brick3 extent: 100@50.
	
	rootBrick
		addBrickBack: brick1;
		addBrickBack: brick2;
		addBrickBack: brick3.
		
	foundationBrick := GLMFoundationBrick new.
	foundationBrick brickRoot: rootBrick.
	foundationBrick openInWindow.
	foundationBrick color: Color pink.

]

{ #category : #'as yet unclassified' }
GLMBrickLayout >> boundsOf: aBrick in: owner withArguments: aHashTable [
	
	^ (owner layoutProperties paddingLeft@owner layoutProperties paddingTop) extent: (self extentOf: aBrick in: owner withArguments: aHashTable)
]

{ #category : #'as yet unclassified' }
GLMBrickLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	
	^ (self originalWidthOf: aBrick)@(self originalHeightOf: aBrick)
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

{ #category : #'as yet unclassified' }
GLMBrickLayout >> maxHeightOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties maxHeightBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger maxVal ]
]

{ #category : #'as yet unclassified' }
GLMBrickLayout >> maxWidthOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties maxWidthBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger maxVal ]
]

{ #category : #'as yet unclassified' }
GLMBrickLayout >> minHeightOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties minHeightBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger minVal ]
]

{ #category : #'as yet unclassified' }
GLMBrickLayout >> minWidthOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties minWidthBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger minVal ]
]

{ #category : #'as yet unclassified' }
GLMBrickLayout >> originalHeightOf: aBrick [

	^ ((aBrick height) max: (self minHeightOf: aBrick)) min: (self maxHeightOf: aBrick).
]

{ #category : #'as yet unclassified' }
GLMBrickLayout >> originalWidthOf: aBrick [

	^ ((aBrick width) max: (self minWidthOf: aBrick)) min: (self maxWidthOf: aBrick).
]

{ #category : #'as yet unclassified' }
GLMBrickLayout >> prepareArgumentsFor: aBrick [

	^ nil
]

{ #category : #'as yet unclassified' }
GLMBrickLayout >> setNewBounds: aLayoutBounds to: aMorph in: aBrick [

	aMorph isBrick
				ifTrue: [ aMorph brickBounds: aLayoutBounds bounds ]
				ifFalse: [ aMorph bounds: (aLayoutBounds bounds translateBy: aBrick globalBounds origin) ].
]
