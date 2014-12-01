Class {
	#name : #GLMBrickVerticalLinedStackLayout,
	#superclass : #GLMBrickVerticalStackLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickVerticalLinedStackLayout >> isFullyVisible: aBrick in: aRectangle [
	
	^ aRectangle containsRect: aBrick brickGlobalOuterBounds
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalLinedStackLayout >> isVisible: aBrick in: aRectangle [
	
	^ aRectangle intersects: aBrick brickGlobalOuterBounds
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalLinedStackLayout >> layoutProportional: aCollection in: aBrick position: aSymbol [
	| fullWidth eachWidth index |
	aCollection isEmpty ifTrue: [ ^ self ].
	
	fullWidth := aBrick brickInnerBounds width.
	index := 0.
	aCollection inject: aBrick layoutProperties paddingLeft into: [ :leftOffset :each |
		|layoutBounds|
		
		self sendEvent: (GLMBrickLayoutStacked new index: (index + 1); position: aSymbol; yourself) to: each.
		
		eachWidth := ((fullWidth - leftOffset) / (aCollection size - index)) ceiling.
		
		layoutBounds := GLMBrickLayoutBounds on: each brickBounds of: each.
		index = 0
			ifTrue: [ layoutBounds makeOuterBoundsFitWidth: (((self maxWidthOf: each) max: eachWidth) min: (fullWidth - leftOffset)) ]
			ifFalse: [				
				(index = (aCollection size - 1))
					ifFalse: [ layoutBounds makeOuterBoundsFitWidth: (eachWidth min: (self maxWidthOf: each)) ]
					ifTrue: [ layoutBounds makeOuterBoundsFitWidth: eachWidth ] ].
		
		layoutBounds translateBy: (leftOffset@0).
		self setNewBounds: layoutBounds to: each in: aBrick.
		index := index + 1.
		leftOffset + layoutBounds outerBounds width ]
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalLinedStackLayout >> layoutStacked: aBrick in: newBounds [
	| origStackedBricks stackedBricks allowedBounds forward stackedTopBricks stackedBottomBricks stackedTopHeight stackedBottomHeight|

	allowedBounds := newBounds.
	stackedBricks := self gatherStacked: aBrick.
	origStackedBricks := DoubleLinkedList new.
	origStackedBricks addAll: stackedBricks.
	forward := true.
	
	stackedTopHeight := 0.
	stackedBottomHeight := 0.
	stackedTopBricks := OrderedCollection new.
	stackedBottomBricks := OrderedCollection new.
	
	"going from top to bottom"
	[ stackedBricks isEmpty not & forward] whileTrue: [ |brick|
		brick := stackedBricks removeFirst value.
		(self isVisible: brick in: allowedBounds) ifFalse: [
			(self isAbove: brick in: allowedBounds) ifTrue: [ |delta|
				delta := allowedBounds origin y - brick brickGlobalOuterBounds origin y - stackedTopHeight.
				self translate: brick by: delta.
				brick layoutProperties zIndex: 2.
				stackedTopBricks isEmpty ifTrue: [
					stackedTopHeight := stackedTopHeight + brick brickGlobalOuterBounds height.
					allowedBounds := allowedBounds top: (allowedBounds top + brick brickGlobalOuterBounds height) ].
				stackedTopBricks add: brick.
			] ifFalse: [ forward := false. stackedBricks addFirst: brick ]
		] ifTrue: [
			((self isFullyVisible: brick in: allowedBounds) not & (self isAbove: brick in: allowedBounds)) ifTrue: [ |delta|
				delta := allowedBounds origin y - brick brickGlobalOuterBounds origin y.
				self translate: brick by: delta.
				brick layoutProperties zIndex: 2.
				allowedBounds := allowedBounds top: (allowedBounds top + brick brickGlobalOuterBounds height).
			] ifFalse: [ forward := false.	brick layoutProperties zIndex: 1.	stackedBricks addFirst: brick ] ] ].

	"going from bottom to top"
	[ stackedBricks isEmpty not ] whileTrue: [ |brick|
		brick := stackedBricks removeLast value.
		(self isVisible: brick in: allowedBounds) ifFalse: [ |delta|
			delta := brick brickGlobalOuterBounds corner y -  allowedBounds corner y - stackedBottomHeight.
			self translate: brick by: delta negated.
			brick layoutProperties zIndex: 2.
			stackedBottomBricks isEmpty ifTrue: [
				stackedBottomHeight := stackedBottomHeight + brick brickGlobalOuterBounds height.
				allowedBounds := allowedBounds bottom: (allowedBounds bottom - brick brickGlobalOuterBounds height) ].
			stackedBottomBricks add: brick.
		] ifTrue: [
			(self isFullyVisible: brick in: allowedBounds ) ifFalse: [ |delta|
				delta := brick brickGlobalOuterBounds corner y -  allowedBounds corner y.
				self translate: brick by: delta negated.
				brick layoutProperties zIndex: 2.
				allowedBounds := allowedBounds bottom: (allowedBounds bottom - brick brickGlobalOuterBounds height)
			] ifTrue: [ 	brick layoutProperties zIndex: 1 ] ] ].

	self layoutProportional: stackedTopBricks reverse in: aBrick position: #top.
	self layoutProportional: stackedBottomBricks reverse in: aBrick position: #bottom.
	
	origStackedBricks do: [ :each | each doLayout ].
	
	^ allowedBounds
]
