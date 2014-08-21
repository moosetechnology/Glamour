Class {
	#name : #GLMPagerButtonGeometryModel,
	#superclass : #Object,
	#instVars : [
		'paddingLeft',
		'paddingRight',
		'paddingTop',
		'paddingBottom',
		'labelPosition',
		'announcer'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #accessing }
GLMPagerButtonGeometryModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #calculation }
GLMPagerButtonGeometryModel >> calculateExtent: baseExtent [
	^ (baseExtent x + self paddingLeft + self paddingRight)@(baseExtent y + self paddingBottom + self paddingTop)
]

{ #category : #calculation }
GLMPagerButtonGeometryModel >> calculateInnerBounds: baseInnerBounds [

		^ baseInnerBounds
			left: baseInnerBounds left + self paddingLeft;
			right: baseInnerBounds right - self paddingRight;
			top: baseInnerBounds top + self paddingTop;
			bottom: baseInnerBounds bottom - self paddingBottom.
]

{ #category : #initialization }
GLMPagerButtonGeometryModel >> initialize [
	super initialize.
	
	paddingLeft := 0.
	paddingRight := 0.
	paddingTop := 0.
	paddingBottom := 0.
	labelPosition := #center.
]

{ #category : #'accessing-label' }
GLMPagerButtonGeometryModel >> labelPosition [
	^ labelPosition
]

{ #category : #'accessing-label' }
GLMPagerButtonGeometryModel >> labelPosition: aSymbol [
	"aSymbol can be:
		#center 			- 	will be centered vertically and horizontally;
		#leftCenter 		- 	will be moved to the left and be centered vertically
		#rightCenter 	- 	will be moved to the right an be centered vertically"
				
	labelPosition := aSymbol.
	self notifyGeometryChanged.
]

{ #category : #private }
GLMPagerButtonGeometryModel >> notifyGeometryChanged [

	self announcer announce: GLMPagerButtonGeometryChanged new.
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> padding: anInteger [
	self paddingLeft: anInteger top: anInteger right: anInteger bottom: anInteger
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingBottom [
	^ paddingBottom
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingBottom: anInteger [
	self paddingLeft: nil top: nil right: nil bottom: anInteger
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingHorizontal: anInteger [
	self paddingLeft: anInteger top: nil right: anInteger bottom: nil.
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingLeft [
	^ paddingLeft
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingLeft: anInteger [
	self paddingLeft: anInteger top: nil right: nil bottom: nil
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingLeft: left top: top right: right bottom: bottom [

	left ifNotNil: [ paddingLeft := left ].
	top ifNotNil: [ paddingTop := top ].
	right ifNotNil: [ paddingRight := right ].
	bottom ifNotNil: [ paddingBottom := bottom ].
	
	self notifyGeometryChanged.
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingRight [
	^ paddingRight
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingRight: anInteger [
	self paddingLeft: nil top: nil right: anInteger bottom: nil
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingTop [
	^ paddingTop
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingTop: anInteger [
	self paddingLeft: nil top: anInteger right: nil bottom: nil
]

{ #category : #accessing }
GLMPagerButtonGeometryModel >> paddingVertical: anInteger [
	self paddingLeft: nil top: anInteger right: nil bottom: anInteger.
]
