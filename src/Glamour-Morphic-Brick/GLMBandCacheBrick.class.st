Class {
	#name : #GLMBandCacheBrick,
	#superclass : #GLMBandBrick,
	#instVars : [
		'cachedHeight'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMBandCacheBrick >> height [
	|height|
	
	cachedHeight ifNotNil: [ ^ cachedHeight ].
	
	self heightBlock ifNotNil: [ cachedHeight := self heightBlock cull: self. ^ cachedHeight ].
		
	height := self layoutProperties verticalPadding.
	self subbricks do: [ :each | height := height + each height + each layoutProperties verticalMargin ].
	cachedHeight := height.
	^ height
]
