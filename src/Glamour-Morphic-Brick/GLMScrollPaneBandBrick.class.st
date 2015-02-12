Class {
	#name : #GLMScrollPaneBandBrick,
	#superclass : #GLMBandBrick,
	#instVars : [
		'scrollpane'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Scrollpane'
}

{ #category : #'as yet unclassified' }
GLMScrollPaneBandBrick >> onChildrenLayouted [
	super onChildrenLayouted.
	
	self scrollpane ifNotNil: [ :s | s updateScrollbar ]
]

{ #category : #accessing }
GLMScrollPaneBandBrick >> scrollpane [
	^ scrollpane
]

{ #category : #accessing }
GLMScrollPaneBandBrick >> scrollpane: anObject [
	scrollpane := anObject
]
