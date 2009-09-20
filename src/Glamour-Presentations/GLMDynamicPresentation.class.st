"
A GLMDynamicPresentation is a presentation that takes the actual presentation from the display value. Like this, we can have the block of display return a presentation depending on the input.

A usage for this behavior is the Glamorous Editor, which takes the text as input and based on this it displays the browser.
"
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
