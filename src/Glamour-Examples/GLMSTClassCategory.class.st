Class {
	#name : #GLMSTClassCategory,
	#superclass : #GLMSTNamedModel,
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMSTClassCategory class >> all [
	|environment|
	environment := self defaultEnvironment.
	^ environment categories collect: [:each | self named: each environment: environment]
]

{ #category : #accessing }
GLMSTClassCategory >> classes [
	^ (Smalltalk organization listAtCategoryNamed: self name) collect: [ :className |
		GLMSTClass behavior: (Smalltalk classNamed: className) environment: self environment]
]
