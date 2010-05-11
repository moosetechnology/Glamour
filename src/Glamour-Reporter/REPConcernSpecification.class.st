Class {
	#name : #REPConcernSpecification,
	#superclass : #Object,
	#instVars : [
		'root',
		'model'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #'instance creation' }
REPConcernSpecification class >> on: aModel [
	^ self new 
			model: aModel;
			yourself
]

{ #category : #'concern building' }
REPConcernSpecification >> composite: aString with: aBlock [ 
	| state |
	state := self shallowCopy.
	self root: (self concern: ((
		REPCompositeConcern on: self model) label: aString; yourself)).
	aBlock ensure: [ self copyFrom: state ]
]

{ #category : #'concern building' }
REPConcernSpecification >> concern: aConcern [
	^ self root addChild: (aConcern model: self model; yourself)
]

{ #category : #'initialize-release' }
REPConcernSpecification >> initialize [
	root := REPCompositeConcern new
]

{ #category : #accessing }
REPConcernSpecification >> label: aString [ 
	self root label: aString
]

{ #category : #accessing }
REPConcernSpecification >> model [
	^ model
]

{ #category : #accessing }
REPConcernSpecification >> model: anObject [
	model := anObject.
	self root withAllChildrenDo: [:each | each model: anObject ]
]

{ #category : #opening }
REPConcernSpecification >> open [ 
	^ REPConcernBrowser openOn: self root 
]

{ #category : #'concern building' }
REPConcernSpecification >> query: aLabelString meaning: aMeaningString as: aBlock [
	^ self root addChild: 
		((REPQueryConcern on: self model)
			computation: aBlock;
			label: aLabelString;
			explanation: aMeaningString;
			yourself )
]

{ #category : #accessing }
REPConcernSpecification >> root [
	^ root
]

{ #category : #accessing }
REPConcernSpecification >> root: anObject [
	root := anObject
]
