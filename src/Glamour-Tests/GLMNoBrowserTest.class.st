Class {
	#name : #GLMNoBrowserTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMNoBrowserTest >> testCreation [

	self deny: GLMNoBrowser new isNil.
	self assert: (GLMNoBrowser new) == GLMNoBrowser new
]
