Class {
	#name : #GLMActionBrickDarkThemer,
	#superclass : #GLMBrickDarkThemer,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #modules }
GLMActionBrickDarkThemer >> popupThemer [

	^ self registerModule: GLMActionBrickPopupDarkThemer new
]

{ #category : #'brick-scrollbar' }
GLMActionBrickDarkThemer >> scrollbarWidth [

	^ 2
]

{ #category : #'brick-scrollpane' }
GLMActionBrickDarkThemer >> scrollpaneBackgroundColor [

	^ Color transparent
]
