Class {
	#name : #GLMBrickDarkThemer,
	#superclass : #GLMBrickThemer,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-scrollbar' }
GLMBrickDarkThemer >> scrollbarColor [

	^ Color black alpha: 0.5
]

{ #category : #'brick-scrollpane' }
GLMBrickDarkThemer >> scrollpaneBackgroundColor [

	^ Color darkGray
]
