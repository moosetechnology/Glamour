Class {
	#name : #GLMBrickMorphWrapper,
	#superclass : #GLMBrickGeneralWrapper,
	#category : #'Glamour-Morphic-Brick-Layouts-Utils'
}

{ #category : #api }
GLMBrickMorphWrapper >> isBrick [

	^ false
]

{ #category : #api }
GLMBrickMorphWrapper >> subbricks [

	^ self brick submorphs
]
