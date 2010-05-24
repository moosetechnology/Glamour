Class {
	#name : #GLMNoBrowser,
	#superclass : #GLMLoggedObject,
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

	uniqueInstance := self basicNew initialize
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
