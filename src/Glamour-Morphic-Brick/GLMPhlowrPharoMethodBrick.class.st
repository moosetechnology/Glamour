"
asdasd
"
Class {
	#name : #GLMPhlowrPharoMethodBrick,
	#superclass : #GLMPhlowrBrick,
	#instVars : [
		'textBrick'
	],
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #examples }
GLMPhlowrPharoMethodBrick class >> example [
	
	^ GLMCompositeBrick examplePharoMethod
]

{ #category : #phlowr }
GLMPhlowrPharoMethodBrick >> display: aBlockOrSymbol [

	self setParameter: #display toValue: aBlockOrSymbol
]

{ #category : #accessing }
GLMPhlowrPharoMethodBrick >> displayLogic [

	^ self valueOfParameter: #display ifAbsent: #yourself
]

{ #category : #phlowr }
GLMPhlowrPharoMethodBrick >> entity: anObject [
	super entity: anObject.
	
	self textBrick setTextWith: (self displayLogic cull: self entity).
	self textBrick classOrMetaClass: (self smalltalkClassLogic cull: self entity)
	
]

{ #category : #initialization }
GLMPhlowrPharoMethodBrick >> initialize [
	super initialize.
	
	self textBrick: self newTextBrick.
]

{ #category : #'instance creation' }
GLMPhlowrPharoMethodBrick >> newTextBrick [

	^ RubScrolledTextMorph new
]

{ #category : #phlowr }
GLMPhlowrPharoMethodBrick >> smalltalkClass: aBlockOrSymbol [
	
	self setParameter: #smalltalkClass toValue: aBlockOrSymbol
]

{ #category : #accessing }
GLMPhlowrPharoMethodBrick >> smalltalkClassLogic [

	^ self valueOfParameter: #smalltalkClass ifAbsent: #yourself
]

{ #category : #accessing }
GLMPhlowrPharoMethodBrick >> textBrick [

	^ textBrick
	

]

{ #category : #accessing }
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
