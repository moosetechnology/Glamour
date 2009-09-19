Class {
	#name : #GLMNoBrowser,
	#superclass : #Object,
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
GLMNoBrowser >> innerPortEvent: aPortEvent [ 

]
