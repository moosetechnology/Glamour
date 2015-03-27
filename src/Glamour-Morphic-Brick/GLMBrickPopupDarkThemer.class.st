"
I'm a style module related to popup and modified for Dark Theme
"
Class {
	#name : #GLMBrickPopupDarkThemer,
	#superclass : #GLMBrickPopupThemer,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-popup' }
GLMBrickPopupDarkThemer >> backgroundColor [

	^ Color veryDarkGray
]

{ #category : #'brick-popup' }
GLMBrickPopupDarkThemer >> borderColor [

	^ self themer color darken lighter
]

{ #category : #'brick-popup' }
GLMBrickPopupDarkThemer >> textColor [

	^ Color white slightlyDarker
]
