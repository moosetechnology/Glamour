Class {
	#name : #GLMBrickTabLabelThemer,
	#superclass : #GLMBrickThemerModule,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-tab-label' }
GLMBrickTabLabelThemer >> normalBackgroundColor [

	^ self themer backgroundColor
]

{ #category : #'brick-tab-label' }
GLMBrickTabLabelThemer >> normalStyleFor: aBrick [

	aBrick fillStyle: (Smalltalk ui theme tabLabelNormalFillStyleFor: aBrick).
	aBrick borderStyle: (Smalltalk ui theme tabLabelNormalBorderStyleFor: aBrick)
]

{ #category : #'brick-tab-label' }
GLMBrickTabLabelThemer >> selectedBackgroundColor [

	^ Color r: 52 g: 152 b: 219 range: 255
]

{ #category : #'brick-tab-label' }
GLMBrickTabLabelThemer >> selectedStyleFor: aBrick [

	aBrick fillStyle: ((Smalltalk ui theme tabLabelSelectedFillStyleFor: aBrick) origin: aBrick brickBounds origin).
	aBrick borderStyle: (Smalltalk ui theme tabLabelSelectedBorderStyleFor: aBrick)
]
