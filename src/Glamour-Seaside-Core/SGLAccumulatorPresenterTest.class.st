Class {
	#name : #SGLAccumulatorPresenterTest,
	#superclass : #SGLPresenterTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLAccumulatorPresenterTest >> buildPresentation [
	^ GLMAccumulator new
]

{ #category : #setup }
SGLAccumulatorPresenterTest >> presenterClass [
	^ SGLAccumulatorPresenter
]

{ #category : #testing }
SGLAccumulatorPresenterTest >> testInitialization [
	self establishSession.
	presenter browser = presentation
]
