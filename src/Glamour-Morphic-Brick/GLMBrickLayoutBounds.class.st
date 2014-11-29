Class {
	#name : #GLMBrickLayoutBounds,
	#superclass : #Object,
	#instVars : [
		'outerBounds',
		'bounds',
		'innerBounds'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #construction }
GLMBrickLayoutBounds class >> on: aRectangle of: aBrick [

	^ self new on: aRectangle of: aBrick
]

{ #category : #accessing }
GLMBrickLayoutBounds >> bounds [
	^ bounds ifNil: [ bounds := 0@0 extent: 0@0 ]
]

{ #category : #accessing }
GLMBrickLayoutBounds >> innerBounds [
	^ innerBounds ifNil: [ innerBounds := 0@0 extent: 0@0 ]
]

{ #category : #actions }
GLMBrickLayoutBounds >> makeOuterBoundsFitWidth: anInteger [
	|delta|
	
	delta := outerBounds width - anInteger.
	outerBounds := outerBounds withRight: (outerBounds right - delta).
	innerBounds := innerBounds withRight: (innerBounds right - delta).
	bounds := bounds withRight: (bounds right - delta).
	
]

{ #category : #actions }
GLMBrickLayoutBounds >> moveOuterToOrigin [

	self translateBy: (self bounds origin - self outerBounds origin).
]

{ #category : #construction }
GLMBrickLayoutBounds >> on: aRectangle of: aBrick [
	|left top right bottom|
	
	aRectangle ifNil: [ ^ self ].
	
	bounds := aRectangle.
	
	left := bounds origin x.
	top := bounds origin y.
	right := bounds corner x.
	bottom := bounds corner y.
	
	innerBounds := ((left + aBrick layoutProperties paddingLeft)@(top + aBrick layoutProperties paddingTop)) corner: ((right - aBrick layoutProperties paddingRight)@(bottom - aBrick layoutProperties paddingBottom)).
	outerBounds := ((left - aBrick layoutProperties marginLeft)@(top - aBrick layoutProperties marginTop)) corner: ((right + aBrick layoutProperties marginRight)@(bottom + aBrick layoutProperties marginBottom)).
]

{ #category : #accessing }
GLMBrickLayoutBounds >> outerBounds [
	^ outerBounds ifNil: [ outerBounds := 0@0 extent: 0@0 ]
]

{ #category : #actions }
GLMBrickLayoutBounds >> translateBy: aPoint [

	bounds := self bounds translateBy: aPoint.
	innerBounds := self innerBounds translateBy: aPoint.
	outerBounds := self outerBounds translateBy: aPoint.
]