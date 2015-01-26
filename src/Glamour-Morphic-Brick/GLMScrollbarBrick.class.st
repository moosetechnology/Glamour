"
A GLMScrollbarBrick is vertical scollbar for a scrollpane. User can't interact with it

Instance Variables
	bar:		<Object>
	scrollPane:		<Object>

bar
	- xxxxx

scrollPane
	- xxxxx

"
Class {
	#name : #GLMScrollbarBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'scrollPane',
		'bar'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #private }
GLMScrollbarBrick >> bar [

	^ bar
]

{ #category : #private }
GLMScrollbarBrick >> bar: aBrick [

	bar := aBrick.
	self addBrickBack: aBrick
]

{ #category : #private }
GLMScrollbarBrick >> calculateScrollbarHeight [

	^ (((self scrollPane height) / (self scrollPane band height)) * self height) ceiling.
]

{ #category : #private }
GLMScrollbarBrick >> calculateScrollbarTopOffset [

	^ (((self height) / (self scrollPane band height)) * (self scrollPane band brickBounds top abs)) floor.
]

{ #category : #initialization }
GLMScrollbarBrick >> initialize [
	super initialize.
	
	self layoutPolicy: GLMBrickNoLayout new.
	self bar: self newBar.
]

{ #category : #'instance creation' }
GLMScrollbarBrick >> newBar [

	^ GLMBrick new
]

{ #category : #'brick-properties-events' }
GLMScrollbarBrick >> onThemerChanged [
	super onThemerChanged.

	self updateStyle
]

{ #category : #'brick-properties' }
GLMScrollbarBrick >> scrollBarColor [

	^ self valueOfProperty: #brickScrollbarColor ifAbsent: [ self themer scrollbarColor ]
]

{ #category : #'brick-properties' }
GLMScrollbarBrick >> scrollBarColor: aColor [

	self setProperty: #brickScrollbarColor toValue: aColor.
	self updateStyle
]

{ #category : #private }
GLMScrollbarBrick >> scrollPane [
	^ scrollPane
]

{ #category : #private }
GLMScrollbarBrick >> scrollPane: anObject [
	scrollPane := anObject.
	self update.
]

{ #category : #'brick-properties' }
GLMScrollbarBrick >> scrollbarOffset [

	^ self valueOfProperty: #brickScrollbarOffset ifAbsent: [ self themer scrollbarOffset ]
]

{ #category : #'brick-properties' }
GLMScrollbarBrick >> scrollbarOffset: anInteger [

	self setProperty: #brickScrollbarOffset toValue: anInteger.
	self updateStyle
]

{ #category : #'brick-properties' }
GLMScrollbarBrick >> scrollbarPosition [

	^ self valueOfProperty: #brickScrollbarPosition ifAbsent: [ self themer scrollbarPosition ]
]

{ #category : #'brick-properties' }
GLMScrollbarBrick >> scrollbarPosition: aSymbol [

	self setProperty: #brickScrollbarPosition toValue: aSymbol.
	self updateStyle
]

{ #category : #'brick-properties' }
GLMScrollbarBrick >> scrollbarWidth [

	^ self valueOfProperty: #brickScrollbarWidth ifAbsent: [ self themer scrollbarWidth ]
]

{ #category : #'brick-properties' }
GLMScrollbarBrick >> scrollbarWidth: anInteger [

	self setProperty: #brickScrollbarWidth toValue: anInteger.
	self updateStyle
]

{ #category : #updating }
GLMScrollbarBrick >> update [
	|height top width|
	
	self scrollPane band height = 0 ifTrue: [
		bar brickBounds: ((0@0) extent: 0@0).
		^ self changed.
	].
	
	height := self calculateScrollbarHeight.
	top := self calculateScrollbarTopOffset.
	
	width := (height >= self height)
		ifTrue: [ 0 ]
		ifFalse: [ self width ].
	
	bar brickBounds: ((0@top) extent: width@height).
	
	self changed
]

{ #category : #updating }
GLMScrollbarBrick >> updateStyle [

	self bar color: self scrollBarColor.
	self layout floating: self scrollbarPosition.
	self width: self scrollbarWidth.
	
	self layout floating = #right ifTrue: [ self marginRight: self scrollbarOffset ].
	self layout floating = #bottom ifTrue: [ self marginBottom: self scrollbarOffset ].
	self layout floating = #left ifTrue: [ self marginLeft: self scrollbarOffset ].
	self layout floating = #top ifTrue: [ self marginTop: self scrollbarOffset ]
]
