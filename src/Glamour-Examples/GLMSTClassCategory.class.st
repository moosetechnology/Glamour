Class {
	#name : #GLMSTClassCategory,
	#superclass : #GLMSTModel,
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMSTClassCategory class >> all [
	^ Smalltalk organization categories collect: [:each | self named: each]
]

{ #category : #accessing }
GLMSTClassCategory >> classes [
	^ (Smalltalk organization listAtCategoryNamed: self name) collect: [ :className |
		GLMSTClass new stBehavior: (Smalltalk classNamed: className) ]
]

{ #category : #accessing }
GLMSTClassCategory >> name [
	^ name
]

{ #category : #accessing }
GLMSTClassCategory >> name: anObject [
	name := anObject
]
