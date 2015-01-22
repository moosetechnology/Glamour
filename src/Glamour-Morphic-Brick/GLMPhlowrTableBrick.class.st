"
asdasds
df
s
df
s
"
Class {
	#name : #GLMPhlowrTableBrick,
	#superclass : #GLMPhlowrListBrick,
	#instVars : [
		'columns',
		'transformedEntity'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #examples }
GLMPhlowrTableBrick class >> example [
	
	^ GLMCompositeBrick exampleTable
]

{ #category : #accessing }
GLMPhlowrTableBrick >> addColumn: aColumn [

	self columns add: aColumn
]

{ #category : #phlowr }
GLMPhlowrTableBrick >> column: aStringOrBlockOrSymbol evaluated: aBlockOrSymbol [

	self column: aStringOrBlockOrSymbol evaluated: aBlockOrSymbol styled: nil
]

{ #category : #phlowr }
GLMPhlowrTableBrick >> column: aStringOrBlockOrSymbol evaluated: aBlockOrSymbol styled: aBlockOrSymbolForStyle [

	self addColumn: (GLMPhlowrTableColumn new 
		title: aStringOrBlockOrSymbol;
		computation: aBlockOrSymbol;
		style: aBlockOrSymbolForStyle)
]

{ #category : #accessing }
GLMPhlowrTableBrick >> columns [

	^ columns ifNil: [ columns := OrderedCollection new ]
]

{ #category : #phlowr }
GLMPhlowrTableBrick >> display: aBlockOrSymbol [
	
	self setParameter: #display toValue: aBlockOrSymbol
	
]

{ #category : #accessing }
GLMPhlowrTableBrick >> displayLogic [

	^ self valueOfParameter: #display ifAbsent: #yourself
]

{ #category : #phlowr }
GLMPhlowrTableBrick >> entity: anObject [
	super entity: anObject.
	
	self transformedEntity: (self displayLogic cull: anObject).
	self listBrick adaptor on: self transformedEntity
]

{ #category : #initialization }
GLMPhlowrTableBrick >> initialize [
	super initialize.

	self listBrick adaptor
		morphAtLogic: [ :index | GLMPhlowrTableRowBrick new in: self; entity: (self transformedEntity at: index) ]
]

{ #category : #accessing }
GLMPhlowrTableBrick >> transformedEntity [

	^ transformedEntity
]

{ #category : #accessing }
GLMPhlowrTableBrick >> transformedEntity: anObject [

	transformedEntity := anObject
]
