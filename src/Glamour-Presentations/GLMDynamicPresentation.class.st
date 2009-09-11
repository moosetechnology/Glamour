Class {
	#name : #GLMDynamicPresentation,
	#superclass : #GLMPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #'as yet unclassified' }
GLMDynamicPresentation >> currentPresentation [ 
	^ self displayValue pane: self pane
]

{ #category : #'as yet unclassified' }
GLMDynamicPresentation >> renderGlamorouslyOn: aRenderer [ 
	^ self currentPresentation renderGlamorouslyOn: aRenderer
]
