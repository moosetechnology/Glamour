Class {
	#name : #SGLAccordionCompositePresenterTest,
	#superclass : #SGLPresenterTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLAccordionCompositePresenterTest >> buildPresentation [
	| aPresentation |
	aPresentation := GLMCompositePresentation new.
	aPresentation accordionArrangement.
	^ aPresentation
]

{ #category : #setup }
SGLAccordionCompositePresenterTest >> presenterClass [
	^ SGLAccordionCompositePresenter
]

{ #category : #testing }
SGLAccordionCompositePresenterTest >> testInitialization [
	self establishSession.
	presenter presentation = presentation
]
