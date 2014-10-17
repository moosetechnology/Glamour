"
A GLMStringBrick is low level String Brick. Text can't be drawn outside of Brick's bounds, which makes it very usefull for smart text shrinking.

Instance Variables
	familyName:		<Object>
	font:		<Object>
	fontSize:		<Object>
	text:		<Object>
	textColor:		<Object>
	textPosition:		<Object>
	textSize:		<Object>

familyName
	- xxxxx

font
	- xxxxx

fontSize
	- xxxxx

text
	- xxxxx

textColor
	- xxxxx

textPosition
	- xxxxx

textSize
	- xxxxx

"
Class {
	#name : #GLMStringBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'font',
		'familyName',
		'fontSize',
		'textSize',
		'text',
		'textColor',
		'textPosition'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #accessing }
GLMStringBrick >> calculateTextPosition [

	self textPosition = #leftCenter ifTrue: [ 
		^ self brickBounds origin + self textPositionVerticalCenter.
	].

	self textPosition = #center ifTrue: [ 
		^ self brickBounds origin + self textPositionVerticalCenter + self textPositionHorizontalCenter.
	].

	^ 0@0
]

{ #category : #initialization }
GLMStringBrick >> defaultColor [
	^ Color black
]

{ #category : #defaults }
GLMStringBrick >> defaultFamilyName [
	^ self theme labelFont familyName
]

{ #category : #defaults }
GLMStringBrick >> defaultSize [
	^ self theme labelFont pointSize
]

{ #category : #accessing }
GLMStringBrick >> familyName [
	^ familyName
]

{ #category : #accessing }
GLMStringBrick >> familyName: aString [
	familyName := aString.
	self updateFont.
]

{ #category : #accessing }
GLMStringBrick >> font [

	^ font
]

{ #category : #accessing }
GLMStringBrick >> font: aFont [

	font := aFont.
	font ifNotNil: [ 
		familyName := font familyName.
		fontSize := font pointSize.
	]
]

{ #category : #accessing }
GLMStringBrick >> fontSize [
	^ fontSize
]

{ #category : #accessing }
GLMStringBrick >> fontSize: aNumber [
	fontSize := aNumber.
	self updateFont.
]

{ #category : #initialization }
GLMStringBrick >> initialize [
	super initialize.
	
	fontSize := self defaultSize.
	familyName := self defaultFamilyName.
	textColor := self defaultColor.
	text := ''.
	
	textPosition := #leftCenter.
	
	self updateFont.
]

{ #category : #testing }
GLMStringBrick >> isFitsInParent [

	^ self brickOwner
		ifNil: [ self brickBounds containsRect: (self brickOuterBounds origin extent: self textSize) ]
		ifNotNil: [
			self brickOwner brickBounds extent >= self textSize ]
				
]

{ #category : #drawing }
GLMStringBrick >> onDraw: aCanvas [
	super onDraw: aCanvas.
	aCanvas
		drawString: self text
		at: self calculateTextPosition
		font: self font
		color: self textColor
]

{ #category : #private }
GLMStringBrick >> privateSetText: aString [

	text := aString.
	textSize := nil.
]

{ #category : #public }
GLMStringBrick >> sizeOf: aString [

	^ (self font widthOfString: aString) @ self font height
]

{ #category : #accessing }
GLMStringBrick >> text [

	^ text
]

{ #category : #accessing }
GLMStringBrick >> text: aString [
	|repaint|
	
	repaint := text size > 0.	
	self privateSetText: aString.

	repaint ifTrue: [ self brickOwner doLayout. self root changed ]
]

{ #category : #accessing }
GLMStringBrick >> textColor [
	^ textColor
]

{ #category : #accessing }
GLMStringBrick >> textColor: aColor [
	textColor := aColor.
	self updateFont.
]

{ #category : #accessing }
GLMStringBrick >> textPosition [

	^ textPosition
]

{ #category : #accessing }
GLMStringBrick >> textPosition: aSymbol [
	"supported:
	#leftCenter
	#center
	"
	textPosition := aSymbol.
]

{ #category : #geometry }
GLMStringBrick >> textPositionHorizontalCenter [

	^ ((((self brickBounds width - self textSize x) max: 0) /2)@0)
]

{ #category : #geometry }
GLMStringBrick >> textPositionVerticalCenter [

	^ (0@(self brickBounds height / 2)) - (0@(self fontSize/2)) - (0@3).
]

{ #category : #accessing }
GLMStringBrick >> textSize [

	^ textSize ifNil: [ textSize := self sizeOf: self text ]
]

{ #category : #private }
GLMStringBrick >> updateFont [
	font := LogicalFont familyName: self familyName pointSize: self fontSize.
]