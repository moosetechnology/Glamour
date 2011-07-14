Class {
	#name : #GLMSomeNotNilCondition,
	#superclass : #GLMCondition,
	#category : #'Glamour-Helpers'
}

{ #category : #glamour }
GLMSomeNotNilCondition >> glamourValueWithArgs: anArray [ 
	 
	^anArray anySatisfy: [:each | each notNil]
]
