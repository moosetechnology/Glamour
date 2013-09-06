Class {
	#name : #GLMMorphicGraphETRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'myMorph'
	],
	#category : #'Glamour-GraphET-Presentations'
}

{ #category : #rendering }
GLMMorphicGraphETRenderer >> actOnPresentationUpdate: ann [
	| aView |
	aView := ROMondrianViewBuilder new.
	ann presentation renderOn: aView.
	myMorph setView: aView stack
]

{ #category : #rendering }
GLMMorphicGraphETRenderer >> render: aChartetPresentation [
	| builder |
	builder := aChartetPresentation graphetBuilder.
	aChartetPresentation renderOn: aChartetPresentation graphetBuilder.
	aChartetPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdate: to: self.
	builder openIn: builder rawView.
	^ myMorph := ROPlatform current hostVisualElement on: builder stack
]
