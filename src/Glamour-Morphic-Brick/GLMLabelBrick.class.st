"
A GLMLabelBrick is standard label Brick, that can shrink text if it's size becomes smaller then actual text size.

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
	
	isDotsAdded := false.
	isExpandableOnHover := true.
	
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
