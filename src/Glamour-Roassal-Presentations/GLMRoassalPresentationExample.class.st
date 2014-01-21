Class {
	#name : #GLMRoassalPresentationExample,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #'*glamour-roassal-presentations' }
GLMRoassalPresentationExample >> roassalDirect [
	"self new roassalDirect openOn: (1 to: 20)"

	^ GLMWrapper new with: [ :browser |
		browser show: [ :a |
			a roassal 
				initializeView: [ ROView new @ RODraggable ] ;
				painting: [	:view :numbers | 
					numbers do: [ :number | 
						view add: (ROElement spriteOn: number) + ROLabel ].
					ROTreeLayout on: view elements
				] ] ]
]
