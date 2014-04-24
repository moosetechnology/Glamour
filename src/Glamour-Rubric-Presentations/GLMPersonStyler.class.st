Class {
	#name : #GLMPersonStyler,
	#superclass : #GLMHighlighterTextDecorator,
	#category : #'Glamour-Rubric-Presentations-Examples'
}

{ #category : #'as yet unclassified' }
GLMPersonStyler class >> key [

	^ #personStyler
]

{ #category : #'as yet unclassified' }
GLMPersonStyler >> parser [

	^ RbEPersonColorizer new 
]
