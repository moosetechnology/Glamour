Class {
	#name : #GLMVerticalLinearLayout,
	#superclass : #GLMLinearLayout,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMVerticalLinearLayout class >> example [
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
GLMVerticalLinearLayout class >> example2 [
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
GLMVerticalLinearLayout class >> reset [
	"
	self reset
	"
	uniqueInstance := nil
]

{ #category : #accessing }
GLMVerticalLinearLayout class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #layout }
GLMVerticalLinearLayout >> align: aBrick in: parentBrick anchorPoint: aPoint inContext: aContext [
	|align|
	
	self = aContext ifTrue: [ ^ self ].
	parentBrick subbricks size = 1 ifTrue: [ |context|
		context := aContext ifNil: [ self ].
		GLMHorizontalLinearLayout uniqueInstance align: aBrick in: parentBrick anchorPoint: aPoint inContext: context ].
	
	align := aBrick layout hAlign.
	
	align = #none ifTrue: [ ^ self ].
	align = #left ifTrue: [ ^ self ].
	align = #center ifTrue: [
		^ aBrick translateX: ((parentBrick innerBounds width - aBrick outerBounds width) / 2) asInteger ].
	align = #right ifTrue: [
		^ aBrick translateX: ((parentBrick innerBounds width - aBrick outerBounds width)) asInteger ].
]

{ #category : #height }
GLMVerticalLinearLayout >> heightChildrenDependency: aBrick [
	"returns the height of aBrick when it depends on children"
	^ aBrick paddingTop + aBrick paddingBottom + ((self nonFloatSubbricks: aBrick) detectSum: [ :each | each outerBounds height ])
]

{ #category : #width }
GLMVerticalLinearLayout >> heightParentDependency: aBrick [
	| allowedHeight |
	aBrick owner ifNil: [ Exception signal: 'My height depends on parent, but it is nil' ].
	allowedHeight := aBrick owner subbricks inject: aBrick owner wrappedBounds innerBounds height into: [ :height :each |
		each wrappedBounds isHeightClean ifTrue: [
			(each isHeightDependsOnParent not | (self hasHeightRestrictions: each))
				ifTrue: [ height - each wrappedBounds outerBounds height ]
				ifFalse: [ height ] ]
			ifFalse: [ height ] ].
	^ (allowedHeight * aBrick layout vPercent / 100) ceiling
]

{ #category : #layout }
GLMVerticalLinearLayout >> layout: aBrick in: newBounds [

	self
		layout: aBrick
		in: newBounds
		inject: aBrick paddingLeft @ aBrick paddingTop
		into: [ :origin :each |
			each wrappedBounds outerOrigin: origin.
			0@each wrappedBounds outerBounds height ]
]

{ #category : #width }
GLMVerticalLinearLayout >> widthChildrenDependency: aBrick [
	"returns the height of aBrick when it depends on children"
	"in case of horizontal linear layout it is the height of the highest subbrick + corresponding paddings"
	^ aBrick paddingLeft + aBrick paddingRight + (((self nonFloatSubbricks: aBrick) detectMax: [ :each | each outerBounds width ])
		ifNil: [ 0 ]
		ifNotNil: [ :m | m outerBounds width ])
]

{ #category : #width }
GLMVerticalLinearLayout >> widthParentDependency: aBrick [
	
	aBrick owner ifNil: [ Exception signal: 'My width depends on parent, but it is nil' ].
	^ (aBrick owner wrappedBounds innerBounds width * aBrick layout hPercent / 100) ceiling
]
