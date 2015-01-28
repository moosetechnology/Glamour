"
asdasd
as

sdf
sfd

"
Class {
	#name : #GLMPhlowrPharoMethodBrick,
	#superclass : #GLMPhlowrBrick,
	#instVars : [
		'#textBrick => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #examples }
GLMPhlowrPharoMethodBrick class >> example [
	
	^ GLMCompositeBrick examplePharoMethod
]

{ #category : #phlowr }
GLMPhlowrPharoMethodBrick >> display: anObject [

	self setProperty: #phlowDisplay toValue: anObject
]

{ #category : #accessing }
GLMPhlowrPharoMethodBrick >> displayLogic [

	^ self valueOfProperty: #phlowDisplay ifAbsent: [ #yourself ]
]

{ #category : #phlowr }
GLMPhlowrPharoMethodBrick >> entity: anObject [
	super entity: anObject.
	
	self textBrick classOrMetaClass: (self smalltalkClassLogic phlowValue: self entity).
	self textBrick setTextWith: (self displayLogic phlowValue: self entity)
	
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
GLMPhlowrPharoMethodBrick >> smalltalkClass: anObject [
	
	self setProperty: #phlowSmalltalkClass toValue: anObject
]

{ #category : #accessing }
GLMPhlowrPharoMethodBrick >> smalltalkClassLogic [

	^ self valueOfProperty: #phlowSmalltalkClass ifAbsent: [ #yourself ]
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
		
	self textBrick textArea borderWidth: 0.
	self textBrick borderWidth: 0.
		
	self textBrick layoutProperties
		vSpaceFill;
		hSpaceFill.
	self addBrickBack: self textBrick
	

]
