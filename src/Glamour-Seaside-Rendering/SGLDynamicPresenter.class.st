Class {
	#name : #SGLDynamicPresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #initialization }
SGLDynamicPresenter >> initializeFor: aPresentation [
	presentation := aPresentation
]

{ #category : #rendering }
SGLDynamicPresenter >> renderContentOn: html [
	self renderer render: presentation currentPresentation
]
