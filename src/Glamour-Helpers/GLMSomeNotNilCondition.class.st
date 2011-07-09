Class {
	#name : #GLMSomeNotNilCondition,
	#superclass : #Object,
	#category : #'Glamour-Helpers'
}

{ #category : #glamour }
GLMSomeNotNilCondition >> glamourValueWithArgs: anArray [ 
	 
	^anArray anySatisfy: [:each | each notNil]
]
