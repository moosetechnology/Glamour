Class {
	#name : #GLMMenu,
	#superclass : #Object,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMenu class >> actionsFor: aSelection [ 

	| actions |
	actions := OrderedCollection new.
	actions add: ((GLMAction new) 
				action: [:each | Transcript show: 'Menu - Item1'; cr]; 
				"shortcut: $x; "
				title: 'Menu - Item1'; 
				yourself).	 
	actions add: ((GLMAction new) 
				action: [:each | Transcript show: 'Menu - Item2'; cr]; 
				"shortcut: $y;"
				title: 'Menu - Item2'; 
				yourself).
				
	^actions
]

{ #category : #'access to cache' }
GLMMenu class >> for: aPresentation [ 

	^self new initializeFor: aPresentation
	
]

{ #category : #initializing }
GLMMenu >> initializeFor: aPresentation [ 
	presentation := aPresentation
]
