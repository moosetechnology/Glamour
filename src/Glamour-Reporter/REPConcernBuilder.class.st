Class {
	#name : #REPConcernBuilder,
	#superclass : #Object,
	#instVars : [
		'root',
		'model'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #'instance creation' }
REPConcernBuilder class >> on: aModel [
	^ self new 
			model: aModel;
			yourself
]

{ #category : #'concern building' }
REPConcernBuilder >> composite: aString with: aBlock [ 
	| state |
	state := self shallowCopy.
	self root: (self concern: (REPCompositeConcern on: self model)).
	aBlock ensure: [ self copyFrom: state ]
]

{ #category : #'concern building' }
REPConcernBuilder >> concern: aConcern [
	^ self root addChild: (aConcern model: self model)
]

{ #category : #'initialize-release' }
REPConcernBuilder >> initialize [
	root := REPCompositeConcern new
]

{ #category : #accessing }
REPConcernBuilder >> label: aString [ 
	self root label: aString
]

{ #category : #accessing }
REPConcernBuilder >> model [
	^ model
]

{ #category : #accessing }
REPConcernBuilder >> model: anObject [
	model := anObject.
	self root withAllChildrenDo: [:each | each model: anObject ]
]

{ #category : #opening }
REPConcernBuilder >> open [ 
	^ REPConcernBrowser openOn: self root 
]

{ #category : #'concern building' }
REPConcernBuilder >> query: aLabelString meaning: aMeaningString as: aBlock [
	^ self root addChild: 
		((REPQueryConcern on: self model)
			computation: aBlock;
			label: aLabelString;
			explanation: aMeaningString;
			yourself )
]

{ #category : #accessing }
REPConcernBuilder >> root [
	^ root
]

{ #category : #accessing }
REPConcernBuilder >> root: anObject [
	root := anObject
]
