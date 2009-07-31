Class {
	#name : #GLMMenu,
	#superclass : #Object,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMenu class >> actionsFor: aPresentation [ 
	|actions|
	aPresentation isMultiple 
							ifTrue: [actions := (aPresentation selection) ifNil: [OrderedCollection new]]
							ifFalse: [actions := OrderedCollection with: aPresentation selection ].
	^ actions collect: [:i |
					(GLMAction new) 
						action: [:each | Transcript show: 'Menu - Item', i printString; cr]; 
						title: 'Menu - Item', i printString; 
						yourself ]
]

{ #category : #'access to cache' }
GLMMenu class >> for: aPresentation [ 

	^self new initializeFor: aPresentation
	
]

{ #category : #initializing }
GLMMenu >> initializeFor: aPresentation [ 
	presentation := aPresentation
]
