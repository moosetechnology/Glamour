Class {
	#name : #REPCompositeConcern,
	#superclass : #REPConcern,
	#instVars : [
		'children'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #accessing }
REPCompositeConcern >> addChild: aConcern [
	^ self children add: aConcern
]

{ #category : #accessing }
REPCompositeConcern >> children [
	^ children
]

{ #category : #accessing }
REPCompositeConcern >> children: anObject [
	children := anObject
]

{ #category : #'initialize-release' }
REPCompositeConcern >> initialize [
	super initialize.
	children := OrderedCollection new
]

{ #category : #testing }
REPCompositeConcern >> isComposite [
	^ true
]

{ #category : #accessing }
REPCompositeConcern >> leafChildrenDo: aBlock [
	self children do: [:each |
		each isComposite 
			ifFalse: [aBlock value: each ]
			ifTrue: [each leafChildrenDo: aBlock ]]
]

{ #category : #accessing }
REPCompositeConcern >> statusValue [
	| hasTrue hasFalse |
	hasTrue := false.
	hasFalse := false.
	self leafChildrenDo: [ :each | 
		each statusValue = false ifTrue: [ hasFalse := true ].
		each statusValue = true ifTrue: [ hasTrue := true ] ].
	hasFalse ifTrue: [ ^ false ].
	hasTrue ifTrue: [ ^ true ].
	^ nil 
]
