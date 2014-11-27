"
A GLMStackedScrollPaneBrick is a more complicated scrollpane, with scrollbars and stacking mechanism of subbricks that have #stack floating parameter

"
Class {
	#name : #GLMStackedScrollPaneBrick,
	#superclass : #GLMScrollPaneBrick,
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMStackedScrollPaneBrick >> initialize [
	super initialize.
	
	self band layoutPolicy: GLMBrickVerticalStackLayout new
]

{ #category : #scrolling }
GLMStackedScrollPaneBrick >> update [
	super update.
	
	"we need to update band's layout to support stacking"
	self band doLayout.
]
