Class {
	#name : #SGLFinderPresenterTest,
	#superclass : #SGLPresenterTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLFinderPresenterTest >> buildPresentation [
	^ GLMFinder new
]

{ #category : #setup }
SGLFinderPresenterTest >> presenterClass [
	^ SGLFinderPresenter
]

{ #category : #testing }
SGLFinderPresenterTest >> testInitialization [
	self establishSession.
	presenter browser = presentation
]
