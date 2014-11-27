Class {
	#name : #GLMScrollPaneBandBrick,
	#superclass : #GLMBandBrick,
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMScrollPaneBandBrick >> doLayout [
	"most of the time you don't want to call this method manually"
	"nice example to check is GLMLabelBrick>>doLayout"
		
	self owner
		ifNotNil: [ self layoutPolicy layout: self in: self owner brickGlobalInnerBounds ]
		ifNil: [ 	self layoutPolicy layout: self in: self brickGlobalInnerBounds ].

	subbricks do: [ :each | each isBrick ifTrue: [ each doLayout ] ]
]
