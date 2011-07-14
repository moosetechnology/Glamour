"
GLMTextMorphForEditView is meant to work with GLMPluggableTextMorph.
"
Class {
	#name : #GLMTextMorphForEditView,
	#superclass : #TextMorphForEditView,
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #callbacks }
GLMTextMorphForEditView >> keyStroke: anEvent [
	| isHandledByModel |
	isHandledByModel := self editView model keystroke: anEvent from: self editView.
	isHandledByModel ifFalse: [ super keyStroke: anEvent ]
]
