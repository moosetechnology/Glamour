Class {
	#name : #GLMStackedScrollPaneBrick,
	#superclass : #GLMScrollPaneBrick,
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMStackedScrollPaneBrick >> update [
	super update.
	
	"we need to update band's layout to support stacking"
	self band doLayout.
]
