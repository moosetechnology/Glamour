Class {
	#name : #GLMMorphicRoassalRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'myMorph'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicRoassalRenderer >> actOnPresentationUpdate: ann [
	| aView |
	aView := ROMondrianViewBuilder new.
	ann presentation renderOn: aView.
	myMorph setView: aView stack
]

{ #category : #rendering }
GLMMorphicRoassalRenderer >> render: aRoassalPresentation [
	| view |
	view := aRoassalPresentation view.
	aRoassalPresentation renderOn: view.
	aRoassalPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdate: to: self.
	^ myMorph := ROPlatform current widgetFactory forView: view stack
]
