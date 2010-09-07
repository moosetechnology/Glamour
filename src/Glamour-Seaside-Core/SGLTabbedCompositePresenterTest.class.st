Class {
	#name : #SGLTabbedCompositePresenterTest,
	#superclass : #SGLPresenterTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLTabbedCompositePresenterTest >> buildPresentation [
	| aPresentation |
	aPresentation := GLMCompositePresentation new.
	aPresentation tabbedArrangement.
	^ aPresentation
]

{ #category : #setup }
SGLTabbedCompositePresenterTest >> presenterClass [
	^ SGLTabbedCompositePresenter
]

{ #category : #testing }
SGLTabbedCompositePresenterTest >> testInitialization [
	self establishSession.
	presenter presentation = presentation
]
