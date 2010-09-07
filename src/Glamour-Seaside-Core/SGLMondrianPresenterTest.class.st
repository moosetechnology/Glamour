Class {
	#name : #SGLMondrianPresenterTest,
	#superclass : #SGLPresenterTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLMondrianPresenterTest >> buildPresentation [
	^ GLMMondrianPresentation new
]

{ #category : #setup }
SGLMondrianPresenterTest >> presenterClass [
	^ SGLMondrianPresenter
]

{ #category : #testing }
SGLMondrianPresenterTest >> testInitialization [
	presentation painting: [:view :number |
		view nodes: (1 to: 10) ].
	self establishSession.
	presenter presentation = presentation
]
