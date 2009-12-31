Class {
	#name : #GLMSomeNotNilCondition,
	#superclass : #Object,
	#category : #'Glamour-Helpers'
}

{ #category : #'as yet unclassified' }
GLMSomeNotNilCondition >> glamourValueWithArgs: anArray [ 
	 
	^anArray anySatisfy: [:each | each notNil]
]
