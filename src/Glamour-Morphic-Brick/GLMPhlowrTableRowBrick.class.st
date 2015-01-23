"
asdasd
a
sd
as
d
"
Class {
	#name : #GLMPhlowrTableRowBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'#entity => GLMPhlowSlot',
		'#table => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #adding }
GLMPhlowrTableRowBrick >> addColumn: aColumn [
	|brick|
	brick := (aColumn computation phlowValue: self entity) asBrick.
	brick := aColumn style phlowValue: brick.
	^ self addBrickBack: brick
]

{ #category : #phlowr }
GLMPhlowrTableRowBrick >> entity [

	^ entity
]

{ #category : #phlowr }
GLMPhlowrTableRowBrick >> entity: anObject [
	
	entity := anObject.
	self initializeColumns.
]

{ #category : #acessing }
GLMPhlowrTableRowBrick >> in: aTableBrick [

	table := aTableBrick.
	self initializeColumns.
]

{ #category : #initialization }
GLMPhlowrTableRowBrick >> initialize [
	super initialize.
	
	"My height is the height of the tallest subbrick"
	self layout vShrinkWrap
]

{ #category : #initialization }
GLMPhlowrTableRowBrick >> initializeColumns [
	"you can initialize only if entity and table both not nil"
	self removeAllBricks.
	(self entity isNil | self table isNil) ifTrue: [ ^ self ].
	self table columns do: [ :each | self addColumn: each ].
	self updateWidthPercentage
]

{ #category : #acessing }
GLMPhlowrTableRowBrick >> table [

	^ table
]

{ #category : #updating }
GLMPhlowrTableRowBrick >> updateWidthPercentage [
	
	self subbricks ifEmpty: [ ^ self ].
	self subbricks do: [ :each | each layoutProperties horizontalPercent: (100 / self subbricksCount) ]
]
