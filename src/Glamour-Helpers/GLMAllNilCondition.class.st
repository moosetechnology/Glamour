Class {
	#name : #GLMAllNilCondition,
	#superclass : #Object,
	#category : #'Glamour-Helpers'
}

{ #category : #glamour }
GLMAllNilCondition >> glamourValueWithArgs: anArray [ 
	 
	^anArray allSatisfy: [:each | each isNil]
]
