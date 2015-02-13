Class {
	#name : #GLMHorizontalLinearLayout,
	#superclass : #GLMLinearLayout,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMHorizontalLinearLayout class >> example [
	<example>
	| brick brick1 brick2 |
	brick := GLMBrick new
		color: Color blue;
		layout: self new;
		hShrinkWrap;
		height: 200.
		
	brick1 := GLMBrick new
		color: Color red;
		layout: self new;
		width: 100;
		vSpaceFill.
		
	brick2 := GLMBrick new
		color: Color green;
		layout: self new;
		width: 150;
		height: 50.
		
	brick
		addBrickBack: brick1;
		addBrickBack: brick2.
		
	brick asBrickedMorph
		color: Color white;
		openInWindow
]

{ #category : #examples }
GLMHorizontalLinearLayout class >> example2 [
	<example>
	| brick brick1 brick2 brick3|
	brick := GLMBrick new
		color: Color blue;
		layout: self new;
		width: 400;
		height: 300.
		
	brick1 := GLMBrick new
		color: Color red;
		layout: self new;
		hSpaceFill: 75;
		vSpaceFill: 25.
	
	brick2 := GLMBrick new
		color: Color green;
		layout: self new;
		hSpaceFill: 25;
		vSpaceFill: 75.
	
	brick3 := GLMBrick new
		color: Color yellow;
		layout: self new;
		width: 50;
		height: 50.
	
	brick
		addBrickBack: brick1;
		addBrickBack: brick2;
		addBrickBack: brick3.
		
	brick asBrickedMorph
		color: Color white;
		openInWindow
]

{ #category : #accessing }
GLMHorizontalLinearLayout class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #layout }
GLMHorizontalLinearLayout >> align: aBrick in: parentBrick anchorPoint: aPoint inContext: aContext [
	|align|
	
	self = aContext ifTrue: [ ^ self ].
	parentBrick subbricks size = 1 ifTrue: [ |context|
		context := aContext ifNil: [ self ].
		GLMVerticalLinearLayout uniqueInstance align: aBrick in: parentBrick anchorPoint: aPoint inContext: context ].
	
	align := aBrick layout vAlign.
	
	align = #none ifTrue: [ ^ self ].
	align = #left ifTrue: [ ^ self ].
	align = #center ifTrue: [
		^ aBrick translateY: ((parentBrick innerBounds height - aBrick outerBounds height) / 2) asInteger ].
	align = #right ifTrue: [ ^ self ].
]

{ #category : #converting }
GLMHorizontalLinearLayout >> asString [
	^ 'horizontal'
]

{ #category : #height }
GLMHorizontalLinearLayout >> heightChildrenDependency: aBrick [
	"returns the height of aBrick when it depends on children"
	"in case of horizontal linear layout it is the height of the highest subbrick + corresponding paddings"
	^ aBrick paddingTop + aBrick paddingBottom + (((self nonFloatSubbricks: aBrick) detectMax: [ :each | each outerBounds height ])
		ifNil: [ 0 ]
		ifNotNil: [ :m | m outerBounds height ])
]

{ #category : #height }
GLMHorizontalLinearLayout >> heightParentDependency: aBrick [
	"if aBrick depends on parent we calculate it as a percentage of the parent"
	aBrick owner ifNil: [ Exception signal: 'My height depends on parent, but it is nil' ].
	^ (aBrick owner wrappedBounds innerBounds height * aBrick layout vPercent / 100) ceiling
]

{ #category : #layout }
GLMHorizontalLinearLayout >> layout: aBrick in: newBounds [

	self
		layout: aBrick
		in: newBounds
		inject: aBrick paddingLeft @ aBrick paddingTop
		into: [ :origin :each |
			each wrappedBounds outerOrigin: origin.
			each wrappedBounds outerBounds width@0 ]
]

{ #category : #width }
GLMHorizontalLinearLayout >> widthChildrenDependency: aBrick [
	"returns the width of aBrick when it depends on children"
	^ aBrick paddingLeft + aBrick paddingRight + ((self nonFloatSubbricks: aBrick) detectSum: [ :each | each outerBounds width ])
]

{ #category : #width }
GLMHorizontalLinearLayout >> widthParentDependency: aBrick [
	|allowedWidth|
	aBrick owner ifNil: [ Exception signal: 'My width depends on parent, but it is nil' ].
	allowedWidth := aBrick owner subbricks inject: aBrick owner wrappedBounds innerBounds width into: [ :width :each |
		each wrappedBounds isWidthClean ifTrue: [
			(each isWidthDependsOnParent not | (self hasWidthRestrictions: each))
				ifTrue: [ width - each wrappedBounds outerBounds width ]
				ifFalse: [ width ] ]
			ifFalse: [ width ] ].
	^ (allowedWidth * aBrick layout hPercent / 100) ceiling
]
