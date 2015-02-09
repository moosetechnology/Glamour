Class {
	#name : #GLMLinearLayout,
	#superclass : #LayoutPolicy,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #layout }
GLMLinearLayout >> align: aBrick in: parentBrick anchorPoint: aPoint [

	^ self subclassResponsibility
]

{ #category : #floating }
GLMLinearLayout >> floatingMethodFor: aSymbol [

	^ ('layoutFloating', (aSymbol capitalized), ':in:') asSymbol
]

{ #category : #testing }
GLMLinearLayout >> hasHeightRestrictions: aBrick [

	^ aBrick layout hasMinHeight | aBrick layout hasMaxHeight
]

{ #category : #testing }
GLMLinearLayout >> hasWidthRestrictions: aBrick [

	^ aBrick layout hasMinWidth | aBrick layout hasMaxWidth
]

{ #category : #height }
GLMLinearLayout >> heightChildrenDependency: aBrick [

	^ self subclassResponsibility
]

{ #category : #height }
GLMLinearLayout >> heightMyselfDependency: aBrick [
	"when height depends only from aBrick just return its cutom height"
	
	^ aBrick customHeight
]

{ #category : #height }
GLMLinearLayout >> heightParentDependency: aBrick [

	^ self subclassResponsibility
]

{ #category : #floating }
GLMLinearLayout >> isFloating: aBrick [
	
	aBrick layoutProperties floating = #none ifTrue: [ ^ false ].
	
	^ self respondsTo: (self floatingMethodFor: aBrick layoutProperties floating)
]

{ #category : #layout }
GLMLinearLayout >> layout: aBrick in: newBounds [

	^ self subclassResponsibility
]

{ #category : #layout }
GLMLinearLayout >> layout: aBrick in: aRectangle inject: anInteger into: aBlock [

	aBrick subbricks inject: anInteger into:[ :origin :each | |result|
		result := origin + ((self isFloating: each)
			ifFalse: [ aBlock cull: origin cull: each ]
			ifTrue: [ self layoutFloating: each in: aRectangle ]).
		"applying aligning: #none, #left, #center, #right"
		self align: each in: aBrick anchorPoint: origin.
		each onLayouted.
		result ].
]

{ #category : #floating }
GLMLinearLayout >> layoutFloating: aBrick in: newBounds [
	"must return an integer that will be added to the offset, if necessary"
	
	|float symbol|
	float := aBrick layoutProperties floating.
	symbol := self floatingMethodFor: float.
	
	^ (self respondsTo: symbol)
		ifTrue: [ self perform: symbol with: aBrick with: newBounds ]
		ifFalse: [ 0 ]
]

{ #category : #floating }
GLMLinearLayout >> layoutFloatingLeft: aBrick in: newBounds [
	| left top |
	
	left := aBrick marginLeft.
	top := aBrick marginTop.
	
	aBrick brickBounds: (left@top extent: aBrick extent).
	
	^ 0
]

{ #category : #floating }
GLMLinearLayout >> layoutFloatingRight: aBrick in: newBounds [
	| left top |
	
	left := aBrick owner width - aBrick width - aBrick marginRight.
	top := aBrick marginTop.
	
	aBrick brickBounds: (left@top extent: aBrick extent).
	
	^ 0
]

{ #category : #enumerating }
GLMLinearLayout >> nonFloatSubbricks: aBrick [

	^ aBrick subbricks select: [ :each | each layout floating = #none ]
]

{ #category : #height }
GLMLinearLayout >> normalizeHeight: anInteger of: aBrick [

	^ (anInteger max: (aBrick layout minHeight brickValue: aBrick))
		min: (aBrick layout maxHeight brickValue: aBrick)
]

{ #category : #width }
GLMLinearLayout >> normalizeWidth: anInteger of: aBrick [

	^ (anInteger max: (aBrick layout minWidth brickValue: aBrick))
		min: (aBrick layout maxWidth brickValue: aBrick)
]

{ #category : #height }
GLMLinearLayout >> updateHeight: aBrick [
	"this method should be called only when height of aBrick is dirty"
	aBrick wrappedBounds isHeightClean ifTrue: [ Exception signal: 'Clean height can''t be updated!' ].
	"when my height depends on children I set it to be able to fit the highest subbrick"
	aBrick isHeightDependsOnChildren ifTrue: [ aBrick wrappedBounds height: (self normalizeHeight: (self heightChildrenDependency: aBrick) of: aBrick) ].
	"when my height depends only from myself I can directly set it"
	aBrick isHeightDependsOnMyself ifTrue: [ aBrick wrappedBounds height: (self normalizeHeight: (self heightMyselfDependency: aBrick) of: aBrick) ].
	"when my height depends only from my parent"
	aBrick isHeightDependsOnParent ifTrue: [ aBrick wrappedBounds outerHeight: (self normalizeHeight: (self heightParentDependency: aBrick) of: aBrick) ].
	
	
	
]

{ #category : #width }
GLMLinearLayout >> updateWidth: aBrick [
	"aBrick is a Brick that uses me as current layout"
	"this method should be called only when width of aBrick is dirty"
	aBrick wrappedBounds isWidthClean ifTrue: [ Exception signal: 'Clean width can''t be updated!' ].
	"when my width depends on children I set it to be able to fit all subbricks"
	aBrick isWidthDependsOnChildren ifTrue: [ aBrick wrappedBounds width: (self normalizeWidth: (self widthChildrenDependency: aBrick) of: aBrick) ].
	"when my width depends only from myself I can directly set it"
	aBrick isWidthDependsOnMyself ifTrue: [ aBrick wrappedBounds width: (self normalizeWidth: (self widthMyselfDependency: aBrick) of: aBrick) ].
	"when my width depends only from my parent"
	aBrick isWidthDependsOnParent ifTrue: [ aBrick wrappedBounds outerWidth: (self normalizeWidth: (self widthParentDependency: aBrick) of: aBrick) ].
	
	
	
]

{ #category : #width }
GLMLinearLayout >> widthChildrenDependency: aBrick [

	^ self subclassResponsibility
]

{ #category : #width }
GLMLinearLayout >> widthMyselfDependency: aBrick [

	^ aBrick customWidth
]

{ #category : #width }
GLMLinearLayout >> widthParentDependency: aBrick [
	
	^ self subclassResponsibility
]
