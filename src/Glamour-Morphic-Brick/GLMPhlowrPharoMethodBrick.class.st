Class {
	#name : #GLMPhlowrPharoMethodBrick,
	#superclass : #GLMPhlowrBrick,
	#instVars : [
		'displayLogic',
		'textBrick',
		'smalltalkClassLogic'
	],
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #examples }
GLMPhlowrPharoMethodBrick class >> example [
	
	^ GLMCompositeBrick examplePharoMethod
]

{ #category : #phlowr }
GLMPhlowrPharoMethodBrick >> display: aBlockOrSymbol [

	displayLogic := aBlockOrSymbol
	
]

{ #category : #phlowr }
GLMPhlowrPharoMethodBrick >> entity: anObject [
	super entity: anObject.
	
	self textBrick setTextWith: (displayLogic cull: self entity).
	self textBrick classOrMetaClass: (smalltalkClassLogic cull: self entity)
	
]

{ #category : #initialization }
GLMPhlowrPharoMethodBrick >> initialize [
	super initialize.
	
	self textBrick: self newTextBrick.
]

{ #category : #'as yet unclassified' }
GLMPhlowrPharoMethodBrick >> newTextBrick [

	^ RubScrolledTextMorph new
]

{ #category : #phlowr }
GLMPhlowrPharoMethodBrick >> smalltalkClass: aBlockOrSymbol [

	smalltalkClassLogic := aBlockOrSymbol
]

{ #category : #'as yet unclassified' }
GLMPhlowrPharoMethodBrick >> textBrick [

	^ textBrick
	

]

{ #category : #'as yet unclassified' }
GLMPhlowrPharoMethodBrick >> textBrick: aBrick [

	textBrick := aBrick.
	self textBrick
		layoutProperties: GLMBrickLayoutProperties new;
		wrapped: true;
		beForSmalltalkCode.
		
	self textBrick layoutProperties
		vSpaceFill;
		hSpaceFill.
	self addBrickBack: self textBrick
	

]
