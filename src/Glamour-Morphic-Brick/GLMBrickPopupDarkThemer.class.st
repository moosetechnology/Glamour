Class {
	#name : #GLMBrickPopupDarkThemer,
	#superclass : #GLMBrickPopupThemer,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-popup' }
GLMBrickPopupDarkThemer >> backgroundColor [

	^ Color darkGray
]

{ #category : #'brick-popup' }
GLMBrickPopupDarkThemer >> textColor [

	^ Color white slightlyDarker
]
