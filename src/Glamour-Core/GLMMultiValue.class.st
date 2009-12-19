"
GLMMultiValue is helper class that is used in #glamourValue:.
"
Class {
	#name : #GLMMultiValue,
	#superclass : #OrderedCollection,
	#type : #variable,
	#category : #'Glamour-Core'
}

{ #category : #testing }
GLMMultiValue >> asGlamorousArray [ 
	 
	^self asArray
]

{ #category : #testing }
GLMMultiValue >> asGlamorousMultiValue [
	^ self
]
