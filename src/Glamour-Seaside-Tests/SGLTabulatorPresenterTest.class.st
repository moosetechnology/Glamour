Class {
	#name : #SGLTabulatorPresenterTest,
	#superclass : #SGLPresenterTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLTabulatorPresenterTest >> buildPresentation [
	^ GLMTabulator new
]

{ #category : #setup }
SGLTabulatorPresenterTest >> presenterClass [
	^ SGLTabulatorPresenter
]

{ #category : #testing }
SGLTabulatorPresenterTest >> testInitialization [
	presentation row: #row.
	self establishSession.
	presenter browser = presentation
]
