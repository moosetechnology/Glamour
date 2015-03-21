Class {
	#name : #GLMBrickTabLabelDarkThemer,
	#superclass : #GLMBrickTabLabelThemer,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-tab-label' }
GLMBrickTabLabelDarkThemer >> normalBorderStyleFor: aBrick [

	^ BorderStyle simple
			width: 1;
			baseColor: Color transparent
]

{ #category : #'brick-tab-label' }
GLMBrickTabLabelDarkThemer >> selectedBorderStyleFor: aBrick [

	^ self normalBorderStyleFor: aBrick
]
