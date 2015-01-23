"
asdasd
sd
fs
df

"
Class {
	#name : #GLMPhlowrBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'titleBrick',
		'entity',
		'parameters'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #phlowr }
GLMPhlowrBrick >> display: aBlockOrSymbol [

	self subclassResponsibility
]

{ #category : #phlowr }
GLMPhlowrBrick >> entity [

	^ entity
]

{ #category : #phlowr }
GLMPhlowrBrick >> entity: anObject [

	entity := anObject.
	self setTitle: (self titleLogic phlowValue: self entity)
	
]

{ #category : #initialization }
GLMPhlowrBrick >> initialize [
	super initialize.
		
	self
		layoutPolicy: GLMBrickVerticalFillProportionalLinearLayout new;
		titleBrick: self newTitleBrick.
		
	self layoutProperties	hSpaceFill; vSpaceFill.
]

{ #category : #'instance creation' }
GLMPhlowrBrick >> newTitleBrick [

	^ GLMLabelBrick new
]

{ #category : #accessing }
GLMPhlowrBrick >> setTitle: aString [

	self titleBrick text: aString.
	
	titleBrick layoutProperties staticHeight: (
		(aString isEmpty | aString isNil)
			ifFalse: [ 30 ]
			ifTrue: [ 0 ])
]

{ #category : #phlowr }
GLMPhlowrBrick >> title: anObject [
	
	self setProperty: #phlowTitle toValue: anObject
]

{ #category : #accessing }
GLMPhlowrBrick >> titleBrick [
	^ titleBrick
]

{ #category : #accessing }
GLMPhlowrBrick >> titleBrick: aBrick [

	titleBrick := aBrick.
	titleBrick textPosition: #center.
	titleBrick layoutProperties staticHeight: 0.
	self addBrickBack: titleBrick
]

{ #category : #accessing }
GLMPhlowrBrick >> titleLogic [

	^ self valueOfProperty: #phlowTitle ifAbsent: [ '' ]
]
