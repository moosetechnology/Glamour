Class {
	#name : #GLMPaneMorph,
	#superclass : #BorderedMorph,
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPaneMorph >> mouseDown: evt [
	super mouseDown: evt.
	Transcript show: self asString; cr.
]
