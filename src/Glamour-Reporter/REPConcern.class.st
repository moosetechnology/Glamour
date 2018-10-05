Class {
	#name : #REPConcern,
	#superclass : #Object,
	#instVars : [
		'model',
		'label',
		'explanation',
		'condition'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #'as yet unclassified' }
REPConcern class >> on: aModel [
	^ self new 
		model: aModel;
		yourself
]

{ #category : #accessing }
REPConcern >> browser [
	| browser |
	browser := GLMTabulator new.
	browser title: #label.
	browser column: #explanation.
	browser transmit to: #explanation; andShow: [:a | 
		a text 
			display: #explanation ].
	^ browser 
]

{ #category : #accessing }
REPConcern >> children [ 
	^ OrderedCollection new
]

{ #category : #accessing }
REPConcern >> condition [
	^ condition
]

{ #category : #accessing }
REPConcern >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
REPConcern >> explanation [
	^ explanation
]

{ #category : #accessing }
REPConcern >> explanation: anObject [
	^ explanation := anObject
]

{ #category : #'initialize-release' }
REPConcern >> initialize [ 
	label := explanation := self class name.
	condition := [nil] "the status is undefined by default".
]

{ #category : #testing }
REPConcern >> isComposite [
	^ false
]

{ #category : #accessing }
REPConcern >> label [ 
	^ label
]

{ #category : #accessing }
REPConcern >> label: anObject [
	label := anObject
]

{ #category : #accessing }
REPConcern >> model [
	^ model
]

{ #category : #accessing }
REPConcern >> model: anObject [
	model := anObject
]

{ #category : #accessing }
REPConcern >> result [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
REPConcern >> status [
	^ (REPConcernStatus new)
		concern: self;
		value: self statusValue;
		yourself
]

{ #category : #accessing }
REPConcern >> statusValue [
	^ self condition 
		glamourValue: self result asGlamorousMultiValue , 
		self model asGlamorousMultiValue
]

{ #category : #accessing }
REPConcern >> withAllChildrenDo: aBlock [
	aBlock value: self.
	self children do: [:each |
		each withAllChildrenDo: aBlock ]
]
