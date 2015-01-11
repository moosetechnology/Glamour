Class {
	#name : #GLMPhlowrTableBrick,
	#superclass : #GLMPhlowrListBrick,
	#instVars : [
		'columns',
		'transformation',
		'transformedEntity'
	],
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #accessing }
GLMPhlowrTableBrick >> addColumn: aColumn [

	self columns add: aColumn
]

{ #category : #phlowr }
GLMPhlowrTableBrick >> column: aStringOrBlockOrSymbol evaluated: aBlockOrSymbol [

	self addColumn: (GLMTableColumn new 
		title: aStringOrBlockOrSymbol;
		computation: aBlockOrSymbol)
]

{ #category : #accessing }
GLMPhlowrTableBrick >> columns [

	^ columns ifNil: [ columns := OrderedCollection new ]
]

{ #category : #accessing }
GLMPhlowrTableBrick >> columnsCount [

	^ self columns size
]

{ #category : #phlowr }
GLMPhlowrTableBrick >> display: aBlockOrSymbol [
	
	transformation := aBlockOrSymbol
]

{ #category : #phlowr }
GLMPhlowrTableBrick >> entity: anObject [
	super entity: anObject.
	
	self transformedEntity: (transformation
		ifNil: [ anObject ]
		ifNotNil: [ transformation cull: anObject ]).
	
	self listBrick adaptor on: self transformedEntity
]

{ #category : #initialization }
GLMPhlowrTableBrick >> initialize [
	super initialize.

	self listBrick adaptor morphAtLogic: [ :index | GLMPhlowrTableRowBrick new in: self; entity: (self transformedEntity at: index) ]
]

{ #category : #accessing }
GLMPhlowrTableBrick >> transformedEntity [

	^ transformedEntity
]

{ #category : #accessing }
GLMPhlowrTableBrick >> transformedEntity: anObject [

	transformedEntity := anObject
]
