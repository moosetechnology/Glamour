Class {
	#name : #GLMBrickDarkThemer,
	#superclass : #GLMBrickThemer,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-button' }
GLMBrickDarkThemer >> buttonBackgroundColor [

	^ Color veryDarkGray lighter
]

{ #category : #'brick-button' }
GLMBrickDarkThemer >> buttonPressedColor [

	^ self backgroundColor whiter
]

{ #category : #'brick-button' }
GLMBrickDarkThemer >> buttonSelectedColor [

	^ Color veryDarkGray lighter slightlyDarker
]

{ #category : #'brick-checkbox' }
GLMBrickDarkThemer >> checkboxBorderColor [

	^ Color lightGray
]

{ #category : #brick }
GLMBrickDarkThemer >> contentBackgroundColor [

	^ Color darkGray darker
]

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

{ #category : #'brick-scrollbar' }
GLMBrickDarkThemer >> scrollbarColor [

	^ Color black alpha: 0.5
]

{ #category : #brick }
GLMBrickDarkThemer >> secondaryTextColor [

	^ Color white
]

{ #category : #'*Glamour-Morphic-Brick' }
GLMBrickDarkThemer >> tabLabelThemer [

	^ self
		registerModule: GLMBrickTabLabelDarkThemer new
]

{ #category : #brick }
GLMBrickDarkThemer >> textColor [

	^ self color whiten
]
