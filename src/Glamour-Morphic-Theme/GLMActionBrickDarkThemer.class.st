Class {
	#name : #GLMActionBrickDarkThemer,
	#superclass : #GLMBrickDarkThemer,
	#category : #'Glamour-Morphic-Theme'
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
