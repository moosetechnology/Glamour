Class {
	#name : #GLMSTClassCategory,
	#superclass : #GLMSTNamedModel,
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMSTClassCategory class >> all [
	|env|
	env := self defaultEnvironment.
	^ env categories collect: [:each | self named: each environment: env]
]

{ #category : #accessing }
GLMSTClassCategory >> classes [
	^ (Smalltalk organization listAtCategoryNamed: self name) collect: [ :className |
		GLMSTClass behavior: (Smalltalk classNamed: className) environment: self environment]
]
