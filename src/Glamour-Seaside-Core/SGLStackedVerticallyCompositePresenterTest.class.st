Class {
	#name : #SGLStackedVerticallyCompositePresenterTest,
	#superclass : #SGLPresenterTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLStackedVerticallyCompositePresenterTest >> buildPresentation [
	| aPresentation |
	aPresentation := GLMCompositePresentation new.
	aPresentation stackedVerticallyArrangement.
	^ aPresentation
]

{ #category : #setup }
SGLStackedVerticallyCompositePresenterTest >> presenterClass [
	^ SGLStackedVerticallyCompositePresenter
]

{ #category : #testing }
SGLStackedVerticallyCompositePresenterTest >> testInitialization [
	self establishSession.
	presenter presentation = presentation
]
