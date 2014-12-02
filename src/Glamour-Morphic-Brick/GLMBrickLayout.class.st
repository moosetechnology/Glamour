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

{ #category : #bounds }
GLMBrickLayout >> boundsOf: aBrick in: owner withArguments: aHashTable [
	
	^ (owner layoutProperties paddingLeft@owner layoutProperties paddingTop) extent: (self extentOf: aBrick in: owner withArguments: aHashTable)
]

{ #category : #layouting }
GLMBrickLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	
	^ (self originalWidthOf: aBrick)@(self originalHeightOf: aBrick)
]

{ #category : #reflection }
GLMBrickLayout >> floatingMethodFor: aSymbol [

	^ ('layoutFloating', (aSymbol capitalized), ':in:withArguments:') asSymbol.
]

{ #category : #layouting }
GLMBrickLayout >> layout: aBrick in: newBounds [
	self subclassResponsibility
]

{ #category : #layouting }
GLMBrickLayout >> layoutFloating: aBrick in: newBounds withArguments: arguments [
	"must return an integer that will be added to the offset, if necessary"
	
	|float symbol|
	float := aBrick layoutProperties floating.
	symbol := self floatingMethodFor: float.
	
	^ (self respondsTo: symbol)
		ifTrue: [ self perform: symbol with: aBrick with: newBounds with: arguments ]
		ifFalse: [ 0 ]
]

{ #category : #layouting }
GLMBrickLayout >> layoutFloatingRight: aBrick in: newBounds withArguments: arguments [

	| left top right bottom |
	
	left := aBrick owner width - aBrick width - aBrick layoutProperties marginRight.
	top := aBrick layoutProperties marginTop.
	right := aBrick owner width - aBrick layoutProperties marginRight.
	bottom := aBrick owner height - aBrick layoutProperties marginBottom.
	
	self setNewBounds: (GLMBrickLayoutBounds on: ((left@top) corner: right@bottom) of: aBrick) to: aBrick in: aBrick owner.
	
	^ 0
]

{ #category : #'extent functions' }
GLMBrickLayout >> maxHeightOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties maxHeightBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger maxVal ]
]

{ #category : #'extent functions' }
GLMBrickLayout >> maxWidthOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties maxWidthBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger maxVal ]
]

{ #category : #'extent functions' }
GLMBrickLayout >> minHeightOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties minHeightBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger minVal ]
]

{ #category : #'extent functions' }
GLMBrickLayout >> minWidthOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties minWidthBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger minVal ]
]

{ #category : #'extent functions' }
GLMBrickLayout >> originalHeightOf: aBrick [

	^ ((aBrick height) max: (self minHeightOf: aBrick)) min: (self maxHeightOf: aBrick).
]

{ #category : #'extent functions' }
GLMBrickLayout >> originalWidthOf: aBrick [

	^ ((aBrick width) max: (self minWidthOf: aBrick)) min: (self maxWidthOf: aBrick).
]

{ #category : #'set up' }
GLMBrickLayout >> prepareArgumentsFor: aBrick [

	^ nil
]

{ #category : #'set up' }
GLMBrickLayout >> prepareLayout: aBrick [

	aBrick isBrick ifTrue: [ aBrick onPrepareLayout ]
]

{ #category : #events }
GLMBrickLayout >> sendEvent: aLayoutEvent to: aBrick [

	aBrick isBrick ifTrue: [ aBrick onLayoutEvent: aLayoutEvent ]
]

{ #category : #bounds }
GLMBrickLayout >> setNewBounds: aLayoutBounds to: aMorph in: aBrick [

	aMorph isBrick
				ifTrue: [ aMorph brickBounds: aLayoutBounds bounds compressed ]
				ifFalse: [ aMorph bounds: (aLayoutBounds bounds translateBy: aBrick globalBounds origin) ].
]

{ #category : #reflection }
GLMBrickLayout >> supportsFloating: aSymbol [
	
	aSymbol = #none ifTrue: [ ^ false ].
	
	^ self respondsTo: (self floatingMethodFor: aSymbol)
]

{ #category : #bounds }
GLMBrickLayout >> translate: aBrick by: anInteger [

	self subclassResponsibility
]
