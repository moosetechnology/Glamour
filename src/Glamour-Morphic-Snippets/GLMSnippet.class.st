Class {
	#name : #GLMSnippet,
	#superclass : #Object,
	#instVars : [
		'snippets',
		'parent',
		'content'
	],
	#category : #'Glamour-Morphic-Snippets-Model'
}

{ #category : #accessing }
GLMSnippet >> parent [

	^ parent
]

{ #category : #accessing }
GLMSnippet >> snippets [

	^ snippets ifNil: [ snippets := OrderedCollection new ]
]
