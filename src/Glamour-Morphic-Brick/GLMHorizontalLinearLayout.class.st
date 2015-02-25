Class {
	#name : #GLMHorizontalLinearLayout,
	#superclass : #GLMLinearLayout,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #accessing }
GLMHorizontalLinearLayout class >> reset [
	"
	self reset
	"
	uniqueInstance := nil
]

{ #category : #accessing }
GLMHorizontalLinearLayout class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #layout }
GLMHorizontalLinearLayout >> align: aBrick in: parentBrick anchorPoint: aPoint inContext: aContext [
	|align|
	
	self = aContext ifTrue: [ ^ self ].
	(parentBrick subbricks size = 1) & (aContext isNil) ifTrue: [
		GLMVerticalLinearLayout uniqueInstance align: aBrick in: parentBrick anchorPoint: aPoint inContext: self ].
	
	align := aBrick layout vAlign.
	
	align = #none ifTrue: [ ^ self ].
	align = #left ifTrue: [ ^ self ].
	align = #center ifTrue: [
		^ aBrick translateY: ((parentBrick innerBounds height - aBrick outerBounds height) / 2) asInteger ].
	align = #right ifTrue: [
		^ aBrick translateX: ((parentBrick innerBounds width - aBrick outerBounds width)) asInteger ].
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
