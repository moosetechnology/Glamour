Class {
	#name : #GLMPhlowPharoMethodBrick,
	#superclass : #GLMPhlowBrick,
	#instVars : [
		'#textBrick => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #examples }
GLMPhlowPharoMethodBrick class >> example [
	
	^ GLMCompositeBrick examplePharoMethod
]

{ #category : #phlow }
GLMPhlowPharoMethodBrick >> display: anObject [

	self setProperty: #phlowDisplay toValue: anObject
]

{ #category : #accessing }
GLMPhlowPharoMethodBrick >> displayLogic [

	^ self valueOfProperty: #phlowDisplay ifAbsent: [ #yourself ]
]

{ #category : #phlow }
GLMPhlowPharoMethodBrick >> entity: anObject [
	super entity: anObject.
	
	self textBrick classOrMetaClass: (self smalltalkClassLogic phlowValue: self entity).
	self textBrick setTextWith: (self displayLogic phlowValue: self entity)
	
]

{ #category : #initialization }
GLMPhlowPharoMethodBrick >> initialize [
	super initialize.
	
	self textBrick: self newTextBrick.
]

{ #category : #'instance creation' }
GLMPhlowPharoMethodBrick >> newTextBrick [

	^ RubScrolledTextMorph new
]

{ #category : #phlow }
GLMPhlowPharoMethodBrick >> smalltalkClass: anObject [
	
	self setProperty: #phlowSmalltalkClass toValue: anObject
]

{ #category : #accessing }
GLMPhlowPharoMethodBrick >> smalltalkClassLogic [

	^ self valueOfProperty: #phlowSmalltalkClass ifAbsent: [ #yourself ]
]

{ #category : #accessing }
GLMPhlowPharoMethodBrick >> textBrick [

	^ textBrick
	

]

{ #category : #accessing }
GLMPhlowPharoMethodBrick >> textBrick: aBrick [

	textBrick := aBrick.
	self textBrick
		layoutProperties: GLMBrickLayoutProperties new;
		wrapped: true;
		beForSmalltalkCode.
		
	self textBrick textArea borderWidth: 0.
	self textBrick borderWidth: 0.
		
	self textBrick layoutProperties
		vSpaceFill;
		hSpaceFill.
	self addBrickBack: self textBrick
	

]
