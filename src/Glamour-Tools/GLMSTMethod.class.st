Class {
	#name : #GLMSTMethod,
	#superclass : #GLMSTNamedModel,
	#instVars : [
		'glmCategory'
	],
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMSTMethod class >> fromMethodReference: aMethodReference [
	| cls cat |
	cls := GLMSTClass new.
	cls stBehavior: (Smalltalk at: aMethodReference classSymbol).
	cat := GLMSTProtocol new.
	cat name: aMethodReference category.
	cat glmBehavior: cls.
	^ GLMSTMethod new
		name: aMethodReference methodSymbol;
		glmCategory: cat;
		yourself
]

{ #category : #accessing }
GLMSTMethod >> glmBehavior [ 
	^ self glmCategory glmBehavior 
]

{ #category : #accessing }
GLMSTMethod >> glmCategory [
	^ glmCategory
]

{ #category : #accessing }
GLMSTMethod >> glmCategory: anObject [
	glmCategory := anObject
]

{ #category : #accessing }
GLMSTMethod >> implementors [
	^ (self systemNavigation allImplementorsOf:	self name) collect: [:each | 
			GLMSTMethod fromMethodReference: each ]
]

{ #category : #testing }
GLMSTMethod >> isMethod [
	^ true
]

{ #category : #accessing }
GLMSTMethod >> senders [
	^ (self systemNavigation allSendersOf:	self name) collect: [:each | 
			GLMSTMethod fromMethodReference: each ]
]

{ #category : #accessing }
GLMSTMethod >> sourceCode [
	^ self glmCategory glmBehavior sourceCodeAt: self name
]
