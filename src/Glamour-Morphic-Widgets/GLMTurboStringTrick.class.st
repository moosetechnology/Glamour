Class {
	#name : #GLMTurboStringTrick,
	#superclass : #GLMTurboTrick,
	#instVars : [
		'font',
		'color',
		'familyName',
		'fontSize',
		'textSize',
		'text',
		'position'
	],
	#category : #'Glamour-Morphic-Widgets-Turbo-UI'
}

{ #category : #accessing }
GLMTurboStringTrick >> color [
	^ color
]

{ #category : #accessing }
GLMTurboStringTrick >> color: aColor [
	color := aColor.
	self updateFont.
]

{ #category : #initialization }
GLMTurboStringTrick >> defaultColor [
	^ Color black
]

{ #category : #defaults }
GLMTurboStringTrick >> defaultFamilyName [
	^ 'Source Sans'
]

{ #category : #defaults }
GLMTurboStringTrick >> defaultSize [
	^ 12
]

{ #category : #accessing }
GLMTurboStringTrick >> familyName [
	^ familyName
]

{ #category : #accessing }
GLMTurboStringTrick >> familyName: aString [
	familyName := aString.
	self updateFont.
]

{ #category : #accessing }
GLMTurboStringTrick >> font [

	^ font
]

{ #category : #accessing }
GLMTurboStringTrick >> font: aFont [

	font := aFont.
	font ifNotNil: [ 
		familyName := font familyName.
		fontSize := font pointSize.
	]
]

{ #category : #accessing }
GLMTurboStringTrick >> fontSize [
	^ fontSize
]

{ #category : #accessing }
GLMTurboStringTrick >> fontSize: aNumber [
	fontSize := aNumber.
	self updateFont.
]

{ #category : #initialization }
GLMTurboStringTrick >> initialize [
	super initialize.
	
	fontSize := self defaultSize.
	familyName := self defaultFamilyName.
	color := self defaultColor.
	text := ''.
	
	position := #leftCenter.
	
	self updateFont.
]

{ #category : #testing }
GLMTurboStringTrick >> isFitInParent [

	^ self bounds containsRect: (self bounds origin extent: self textSize)
]

{ #category : #drawing }
GLMTurboStringTrick >> onDraw: aCanvas area: aRectangle [
	super onDraw: aCanvas area: aRectangle.

	aCanvas drawString: self text at: self textPosition font: self font color: self color.
	
	
]

{ #category : #accessing }
GLMTurboStringTrick >> position [

	^ position
]

{ #category : #accessing }
GLMTurboStringTrick >> position: aSymbol [

	"supported:
	#leftCenter
	#center
	"
	position := aSymbol.
]

{ #category : #private }
GLMTurboStringTrick >> privateSetText: aString [

	text := aString.
	textSize := nil.
]

{ #category : #public }
GLMTurboStringTrick >> sizeOf: aString [

	^ (self font widthOfString: aString) @ self font height
]

{ #category : #accessing }
GLMTurboStringTrick >> text [

	^ text
]

{ #category : #accessing }
GLMTurboStringTrick >> text: aString [
	|repaint|
	
	repaint := text size > 0.	
	self privateSetText: aString.

	repaint ifTrue: [ self owner doLayout. self root changed ]
]

{ #category : #'as yet unclassified' }
GLMTurboStringTrick >> textPosition [

	self position = #leftCenter ifTrue: [ 
		^ self bounds origin + self textPositionVerticalCenter.
	].

	self position = #center ifTrue: [ 
		^ self bounds origin + self textPositionVerticalCenter + self textPositionHorizontalCenter.
	].
]

{ #category : #'as yet unclassified' }
GLMTurboStringTrick >> textPositionHorizontalCenter [

	^ ((((self bounds width - self textSize x) max: 0) /2)@0)
]

{ #category : #'as yet unclassified' }
GLMTurboStringTrick >> textPositionVerticalCenter [

	^ (0@(self bounds height / 2)) - (0@(self fontSize/2)) - (0@3).
]

{ #category : #accessing }
GLMTurboStringTrick >> textSize [

	^ textSize ifNil: [ textSize := self sizeOf: self text ]
]

{ #category : #private }
GLMTurboStringTrick >> updateFont [
	font := LogicalFont familyName: self familyName pointSize: self fontSize.
]
