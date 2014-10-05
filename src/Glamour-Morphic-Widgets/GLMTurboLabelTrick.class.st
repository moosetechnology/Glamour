"
A GLMTurboLabelTrick is standard label Trick, that can shrink text if it's size becomes smaller then actual text size

Instance Variables
	dotsMorph:		<Object>
	isDotsAdded:		<Object>
	stringMorph:		<Object>

dotsMorph
	- xxxxx

isDotsAdded
	- xxxxx

stringMorph
	- xxxxx

"
Class {
	#name : #GLMTurboLabelTrick,
	#superclass : #GLMTurboTrick,
	#instVars : [
		'isDotsAdded',
		'dotsTrick',
		'stringTrick'
	],
	#category : #'Glamour-Morphic-Widgets-Turbo-UI'
}

{ #category : #layouting }
GLMTurboLabelTrick >> doLayout [
	"contolls logic of text schrinking"
	|isFit|
	
	super doLayout.
	
	isFit := stringTrick isFitInParent.
	
	(isFit & (isDotsAdded not)) ifTrue: [ ^ self ].
	(isFit not & isDotsAdded) ifTrue: [ ^ self ].
	
	(isFit & isDotsAdded) ifTrue: [
		self removeTrick: dotsTrick.
		isDotsAdded := false.
		super doLayout.
	] ifFalse: [ 
		self addTrickBack: dotsTrick.
		isDotsAdded := true.
		super doLayout.
	].
	
]

{ #category : #accessing }
GLMTurboLabelTrick >> dotsTrick [

	^ dotsTrick
]

{ #category : #initialization }
GLMTurboLabelTrick >> initialize [
	super initialize.
	
	self layoutManager: GLMTurboHorizontalFillProportionalLinearLayout new.
	
	stringTrick := GLMTurboStringTrick new.
	stringTrick layoutParams horizontalPercent: 100.
	
	self addTrickBack: stringTrick.
	
	dotsTrick := GLMTurboStringTrick new.
	dotsTrick layoutParams horizontalPercent: 0.
	dotsTrick text: '...'.
	dotsTrick layoutParams minWidth: (dotsTrick textSize x) + 2.
	isDotsAdded := false.
	
]

{ #category : #accessing }
GLMTurboLabelTrick >> label [
	^ stringTrick
]

{ #category : #accessing }
GLMTurboLabelTrick >> text [
	^ stringTrick text
]

{ #category : #accessing }
GLMTurboLabelTrick >> text: aString [

	self label text: aString
]
