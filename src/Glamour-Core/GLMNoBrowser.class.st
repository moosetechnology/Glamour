Class {
	#name : #GLMNoBrowser,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMNoBrowser class >> initialize [

	self initializeUniqueInstance
]

{ #category : #'as yet unclassified' }
GLMNoBrowser class >> initializeUniqueInstance [

	uniqueInstance := self basicNew
]

{ #category : #'as yet unclassified' }
GLMNoBrowser class >> new [

	^self uniqueInstance
]

{ #category : #'as yet unclassified' }
GLMNoBrowser class >> uniqueInstance [

	^uniqueInstance
]

{ #category : #accessing }
GLMNoBrowser >> browser [

	^self
]

{ #category : #accessing }
GLMNoBrowser >> context [
	context isNil ifTrue: [ context := (OrderedCollection new) ].
	^context
]

{ #category : #accessing }
GLMNoBrowser >> initializeContextWith: aPane [
	context := OrderedCollection with: aPane
]

{ #category : #accessing }
GLMNoBrowser >> innerPortEvent: aPortEvent [ 

]

{ #category : #accessing }
GLMNoBrowser >> pane [

	^self
]

{ #category : #accessing }
GLMNoBrowser >> updateContextWith: aPane [ 
	context isNil ifTrue: [context := OrderedCollection new].
	context add: aPane

]
