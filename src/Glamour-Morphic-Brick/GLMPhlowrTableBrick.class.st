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
GLMPhlowrTableBrick >> column: anObject evaluated: otherObject [

	self column: anObject evaluated: otherObject styled: nil
]

{ #category : #phlowr }
GLMPhlowrTableBrick >> column: anObject evaluated: otherObject styled: anotherObject [

	self addColumn: (GLMPhlowrTableColumn new 
		title: anObject;
		computation: otherObject;
		style: anotherObject)
]

{ #category : #accessing }
GLMPhlowrTableBrick >> columns [

	^ columns ifNil: [ columns := OrderedCollection new ]
]

{ #category : #phlowr }
GLMPhlowrTableBrick >> display: anObject [
	
	self setProperty: #phlowDisplay toValue: anObject
	
]

{ #category : #accessing }
GLMPhlowrTableBrick >> displayLogic [

	^ self valueOfProperty: #phlowDisplay ifAbsent: [ #yourself ]
]

{ #category : #phlowr }
GLMPhlowrTableBrick >> entity: anObject [
	super entity: anObject.
	
	self transformedEntity: (self displayLogic phlowValue: anObject).
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
