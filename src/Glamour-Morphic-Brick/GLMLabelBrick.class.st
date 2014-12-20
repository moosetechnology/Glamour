"
A GLMLabelBrick is standard label Brick, that can shrink text if it's size becomes smaller then actual text size.

Text shrinking works out of box, you don't need to do anything

Instance Variables
	dotsBrick		<GLMStringBrick>
	isDotsAdded:		<boolean>
	stringBrick rick		<GLMStringBrick>

dotsBrick
	- represents a Brick that is added at the end of the text when Brick's size becomes smaller than actual text size

isDotsAdded
	- true if dotsBrick is currently added visible, false otherwise

stringBrick
	- represents actual label text Brick

"
Class {
	#name : #GLMLabelBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'isDotsAdded',
		'dotsBrick',
		'stringBrick'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #geometry }
GLMLabelBrick >> approximateWidth [

		^ self label approximateWidth + self layoutProperties horizontalMargin + self layoutProperties horizontalPadding
]

{ #category : #accessing }
GLMLabelBrick >> contents: aStringOrText [

	self text: aStringOrText asString
]

{ #category : #'default values' }
GLMLabelBrick >> defaultDotsText [
	^ '...'
]

{ #category : #'default values' }
GLMLabelBrick >> defaultInsetBeforeDots [
	^ 1
]

{ #category : #layouting }
GLMLabelBrick >> doLayout [
	"contolls logic of text schrinking"
	|isFit|
	
	super doLayout.
	
	"checking if label text fits in me"
	isFit := self label isFitsInParent.
	
	(isFit & (self isDotsAdded not)) ifTrue: [ ^ self ].
	(isFit not & self isDotsAdded) ifTrue: [ ^ self ].
	
	(isFit & self isDotsAdded) ifTrue: [
		self removeBrick: self dotsBrick.
		isDotsAdded := false.
		super doLayout.
	] ifFalse: [ 
		self addBrickBack: self dotsBrick.
		isDotsAdded := true.
		super doLayout.
	]
	
]

{ #category : #accessing }
GLMLabelBrick >> dotsBrick [

	^ dotsBrick
]

{ #category : #accessing }
GLMLabelBrick >> fontSize: anInteger [

	self label fontSize: anInteger
]

{ #category : #initialization }
GLMLabelBrick >> initialize [
	super initialize.
	
	stringBrick := self newStringBrick.
	stringBrick layoutProperties horizontalPercent: 100.
	stringBrick layoutProperties marginRight: self defaultInsetBeforeDots.
	self addBrickBack: stringBrick.
	
	"creating dots morph, that will be displayed when text is being clipped"
	dotsBrick := GLMStringBrick new.
	dotsBrick layoutProperties horizontalPercent: 0.
	dotsBrick text: self defaultDotsText.
	dotsBrick layoutProperties minWidth: (dotsBrick textSize x).
	dotsBrick fontSize: 9.
	
	isDotsAdded := false.
	
]

{ #category : #accessing }
GLMLabelBrick >> isDotsAdded [
	^ isDotsAdded
]

{ #category : #accessing }
GLMLabelBrick >> label [
	^ stringBrick
]

{ #category : #'instance creation' }
GLMLabelBrick >> newStringBrick [
	^ GLMStringBrick new
]

{ #category : #accessing }
GLMLabelBrick >> text [
	^ self label text
]

{ #category : #accessing }
GLMLabelBrick >> text: aString [

	self label text: aString
]

{ #category : #accessing }
GLMLabelBrick >> textColor: aColor [

	self label textColor: aColor.
	self dotsBrick textColor: aColor
]

{ #category : #accessing }
GLMLabelBrick >> textPosition: aSymbol [

	self label textPosition: aSymbol.
	self dotsBrick textPosition: aSymbol.
]

{ #category : #accessing }
GLMLabelBrick >> weightValue: anInteger [

	self label weightValue: anInteger.
	self dotsBrick weightValue: anInteger.
]
