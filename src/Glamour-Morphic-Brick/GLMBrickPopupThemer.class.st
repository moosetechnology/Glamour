"
I'm a style module related to popup
"
Class {
	#name : #GLMBrickPopupThemer,
	#superclass : #GLMBrickThemerModule,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-popup' }
GLMBrickPopupThemer >> backgroundColor [

	^ Color r: 240 g: 240 b: 240 range: 256
]

{ #category : #'brick-popup' }
GLMBrickPopupThemer >> borderColor [

	^ Color veryLightGray
]

{ #category : #'brick-popup' }
GLMBrickPopupThemer >> borderWidth [

	^ 1
]

{ #category : #'brick-popup' }
GLMBrickPopupThemer >> textColor [

	^ Color lightGray darker
]
