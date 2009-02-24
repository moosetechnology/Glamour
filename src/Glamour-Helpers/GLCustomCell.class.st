Class {
	#name : #GLCustomCell,
	#superclass : #Object,
	#instVars : [
		'children',
		'span',
		'id',
		'browser'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #accessing }
GLCustomCell >> browser [
	
	^browser
]

{ #category : #accessing }
GLCustomCell >> browser: anObject [
	
	browser := anObject
]

{ #category : #accessing }
GLCustomCell >> children [
	
	^children ifNil: [children := OrderedCollection new]
]

{ #category : #accessing }
GLCustomCell >> children: anObject [
	
	children := anObject
]

{ #category : #accessing }
GLCustomCell >> childrenCount [
	
	^self children sum: [:each | each span]
]

{ #category : #testing }
GLCustomCell >> hasId [
	
	^id notNil
]

{ #category : #accessing }
GLCustomCell >> id [
	
	^id ifNil: [#anonymous]
]

{ #category : #accessing }
GLCustomCell >> id: anObject [
	
	id := anObject
]

{ #category : #testing }
GLCustomCell >> isColumn [
	
	^false
]

{ #category : #testing }
GLCustomCell >> isRow [
	
	^false
]

{ #category : #testing }
GLCustomCell >> isSplitIntoColumns [
	
	^self children allSatisfy: [:each | each isColumn]
]

{ #category : #testing }
GLCustomCell >> isSplitIntoRows [
	
	^self children allSatisfy: [:each | each isRow]
]

{ #category : #accessing }
GLCustomCell >> span [
	
	^span ifNil: [span := 1]
]

{ #category : #accessing }
GLCustomCell >> span: anObject [
	
	span := anObject
]
