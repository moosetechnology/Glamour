Extension { #name : #GLMBrickDarkThemer }

{ #category : #'*Glamour-Morphic-Brick' }
GLMBrickDarkThemer >> popupErrorThemer [

	^ self
		registerModule: GLMBrickPopupErrorDarkThemer new
		to: self
		named: #popupThemer
]

{ #category : #'*Glamour-Morphic-Brick' }
GLMBrickDarkThemer >> popupHelpThemer [

	^ self
		registerModule: GLMBrickPopupHelpDarkThemer new
		to: self
		named: #popupThemer
]

{ #category : #'*Glamour-Morphic-Brick' }
GLMBrickDarkThemer >> popupSuccessThemer [

	^ self
		registerModule: GLMBrickPopupSuccessDarkThemer new
		to: self
		named: #popupThemer
]

{ #category : #'*Glamour-Morphic-Brick' }
GLMBrickDarkThemer >> popupThemer [

	^ self
		registerModule: GLMBrickPopupDarkThemer new
]
