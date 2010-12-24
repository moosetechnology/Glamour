Class {
	#name : #SGLCompositePresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #private }
SGLCompositePresenter >> indexForSelectedPresentation [
	|index|
	index := 1.
	self presentation matchingPresentations withIndexDo: [ :each :i | 
		self presentation pane lastActivePresentation notNil and: [ 
			each title = self presentation pane lastActivePresentation title ifTrue: [ index := i ] ] ].
	^ index
]

{ #category : #initialization }
SGLCompositePresenter >> initializeFor: aPresentation [
	presentation := aPresentation
]

{ #category : #accessing }
SGLCompositePresenter >> presentation [
	^ presentation
]
