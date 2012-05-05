Class {
	#name : #GLMMorphicRoassalRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicRoassalRenderer >> render: aRoassalPresentation [
	| view |
	view := ROView new.
	aRoassalPresentation renderOn: view.
	^ ROMorph on: view
]
