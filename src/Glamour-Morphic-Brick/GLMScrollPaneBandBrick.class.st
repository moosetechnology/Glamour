Class {
	#name : #GLMScrollPaneBandBrick,
	#superclass : #GLMBandBrick,
	#instVars : [
		'scrollpane',
		'asyncTask'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Scrollpane'
}

{ #category : #accessing }
GLMScrollPaneBandBrick >> asyncTask [

	^ asyncTask ifNil: [ asyncTask := GLMAsyncTask new ]
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBandBrick >> onChildrenLayouted [
	super onChildrenLayouted.
	
	self scrollpane ifNotNil: [ :s | s updateScrollbar ].
	
	self updateMorphBounds
]

{ #category : #accessing }
GLMScrollPaneBandBrick >> scrollpane [
	^ scrollpane
]

{ #category : #accessing }
GLMScrollPaneBandBrick >> scrollpane: anObject [
	scrollpane := anObject
]
