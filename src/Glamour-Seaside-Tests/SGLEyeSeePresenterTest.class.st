Class {
	#name : #SGLEyeSeePresenterTest,
	#superclass : #SGLPresenterTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLEyeSeePresenterTest >> buildPresentation [
	^ GLMEyeSeePresentation new
]

{ #category : #setup }
SGLEyeSeePresenterTest >> presenterClass [
	^ SGLEyeSeePresenter
]

{ #category : #testing }
SGLEyeSeePresenterTest >> testInitialization [
	presentation diagram: [:renderer :input | 
		renderer verticalBarDiagram y: #yourself; models: (1 to: 5) ].
	self establishSession.
	presenter presentation = presentation
]
