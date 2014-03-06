"
browser := GLMTabulator new.
browser row: #r1; row: #r2; row: #r3.

browser transmit to: #r1; andShow: [ :aComposite |
	aComposite workspace].
browser transmit to: #r2; andShow: [ :aComposite |
	aComposite workspace
		selectionAct: [ :workspace :page |
				workspace evaluateSelection ]
			on: $d
			entitled: 'Do it';
		selectionAct: [ :workspace :page |
				workspace evaluateSelectionAndDo: [:result | result inspect] ]
			on: $i
			entitled: 'Inspect it';
		selectionAct: [ :workspace :page |
				workspace evaluateSelectionAndDo: [:result | result explore] ]
			on: $e
			entitled: 'Explore it'] .
browser transmit to: #r3; andShow: [ :aComposite |
	aComposite workspace
		variableBindings: [{#browser -> browser}] ].


browser openOn: 'browser := GLMTabulator new.
browser row: #r1; row: #r2.

browser transmit to: #r1; andShow: [ :aComposite |
	aComposite workspace].
browser openOn:''self halt'' '

"
Class {
	#name : #GLMWorkspacePresentation,
	#superclass : #GLMNewSmalltalkCodePresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #'as yet unclassified' }
GLMWorkspacePresentation >> evaluateSelection [

	self evaluateSelectionAndDo: [ :result | result ]
]

{ #category : #'as yet unclassified' }
GLMWorkspacePresentation >> evaluateSelectionAndDo: aBlock [

	self announce: (GLMEvaluateSelection new action: aBlock)
]

{ #category : #'as yet unclassified' }
GLMWorkspacePresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderWorkspacePresentation: self
]
