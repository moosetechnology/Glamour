Class {
	#name : #GLMBrickPopupDarkThemer,
	#superclass : #GLMBrickPopupThemer,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-popup' }
GLMBrickPopupDarkThemer >> backgroundColor [

	^ Color darkGray darker
]

{ #category : #'as yet unclassified' }
GLMBrickPopupDarkThemer >> textColor [

	^ Color white slightlyDarker
]
