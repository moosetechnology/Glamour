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
	aView := ann presentation newViewBlock value. 
	ann presentation renderOn: aView.
	aView onMorph: myMorph 
]

{ #category : #rendering }
GLMMorphicRoassalRenderer >> render: aRoassalPresentation [
	| view |
	view := aRoassalPresentation view.
	aRoassalPresentation renderOn: view.
	aRoassalPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdate: to: self.
	^ myMorph := view newMorph 
]
