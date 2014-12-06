Class {
	#name : #GLMListBandBrick,
	#superclass : #GLMBandBrick,
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMListBandBrick >> height [
	
	self heightBlock ifNotNil: [ ^ self heightBlock cull: self ].
	self subbricks isEmpty ifTrue: [ ^ 0 ].
	^ self lastSubbrick brickBounds bottom
]
