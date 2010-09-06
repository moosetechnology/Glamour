Class {
	#name : #SGLAccumulatorPresenterTest,
	#superclass : #SGLPresenterTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLAccumulatorPresenterTest >> presentationClass [
	^ GLMAccumulator
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
