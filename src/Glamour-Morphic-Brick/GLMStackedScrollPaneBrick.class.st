Class {
	#name : #GLMStackedScrollPaneBrick,
	#superclass : #GLMScrollPaneBrick,
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMStackedScrollPaneBrick >> update [
	super update.
	
	self band doLayout.
]
