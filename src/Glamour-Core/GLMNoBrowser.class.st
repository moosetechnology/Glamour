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
GLMNoBrowser >> context [
	^OrderedCollection new
]

{ #category : #accessing }
GLMNoBrowser >> initializeContextWith: aPane [ 

]

{ #category : #accessing }
GLMNoBrowser >> innerPortEvent: aPortEvent [ 

]

{ #category : #accessing }
GLMNoBrowser >> updateContextWith: aPane [ 

]
