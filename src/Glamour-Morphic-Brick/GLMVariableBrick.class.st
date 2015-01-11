Class {
	#name : #GLMVariableBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'nameBrick',
		'valueBrick',
		'entity'
	],
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #phlowr }
GLMVariableBrick >> entity: anObject [

	entity := anObject
]

{ #category : #initialization }
GLMVariableBrick >> initialize [
	super initialize.
	
	self
		nameBrick: self newNameBrick;
		valueBrick: self newValueBrick
	
]

{ #category : #accessing }
GLMVariableBrick >> nameBrick [

	^ nameBrick
]

{ #category : #accessing }
GLMVariableBrick >> nameBrick: aBrick [

	nameBrick := aBrick.
	self addBrickBack: self nameBrick
]

{ #category : #'instance creation' }
GLMVariableBrick >> newNameBrick [

	^ GLMLabelBrick new
]

{ #category : #'instance creation' }
GLMVariableBrick >> newValueBrick [

	^ GLMLabelBrick new
]

{ #category : #accessing }
GLMVariableBrick >> valueBrick [

	^ valueBrick
]

{ #category : #accessing }
GLMVariableBrick >> valueBrick: aBrick [

	valueBrick := aBrick.
	self addBrickBack: valueBrick.
]
