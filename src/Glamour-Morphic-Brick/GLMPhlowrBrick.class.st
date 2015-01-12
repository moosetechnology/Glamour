Class {
	#name : #GLMPhlowrBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'titleBrick',
		'entity',
		'parameters'
	],
	#category : #'Glamour-Morphic-Brick-Phlowr'
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
	self setTitle: (self titleLogic cull: self entity)
	
]

{ #category : #'accessing-parameters' }
GLMPhlowrBrick >> hasParameter: aKey [

	^ self parameters includesKey: aKey
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

{ #category : #'accessing-parameters' }
GLMPhlowrBrick >> parameters [

	^ parameters ifNil: [ parameters := Dictionary new ]
]

{ #category : #'accessing-parameters' }
GLMPhlowrBrick >> removeParameter: aSymbol [

	self parameter removeKey: aSymbol ifAbsent: []
]

{ #category : #'accessing-parameters' }
GLMPhlowrBrick >> setParameter: aSymbol toValue: abObject [

	self parameters at: aSymbol put: abObject
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
GLMPhlowrBrick >> title: aStringOrSymbolOrBlock [
	
	self setParameter: #title toValue: ((aStringOrSymbolOrBlock isSymbol | aStringOrSymbolOrBlock isBlock)
		ifTrue: [ aStringOrSymbolOrBlock ]
		ifFalse: [ [ aStringOrSymbolOrBlock asString ] ])
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

	^ self valueOfParameter: #title ifAbsent: [ '' ]
]

{ #category : #'accessing-parameters' }
GLMPhlowrBrick >> valueOfParameter: aSymbol [
	^ self
		valueOfParameter: aSymbol
		ifAbsent: []
]

{ #category : #'accessing-parameters' }
GLMPhlowrBrick >> valueOfParameter: aSymbol ifAbsent: aBlock [ 

	^ self parameters at: aSymbol ifAbsent: [^ aBlock value]
]
