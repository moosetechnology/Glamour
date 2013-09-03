Class {
	#name : #GLMMorphicChartetRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'myMorph'
	],
	#category : #'Glamour-Chartet-Presentations'
}

{ #category : #rendering }
GLMMorphicChartetRenderer >> actOnPresentationUpdate: ann [
	| aView |
	aView := ROMondrianViewBuilder new.
	ann presentation renderOn: aView.
	myMorph setView: aView stack
]

{ #category : #rendering }
GLMMorphicChartetRenderer >> render: aChartetPresentation [
	| builder |
	builder := aChartetPresentation chartetBuilder.
	aChartetPresentation renderOn: aChartetPresentation chartetBuilder.
	aChartetPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdate: to: self.
	builder openIn: builder rawView.
	^ myMorph := ROPlatform current hostVisualElement on: builder stack
]
