"
asdasd
"
Class {
	#name : #GLMFallbackScrollListBrick,
	#superclass : #GLMScrollPaneBrick,
	#instVars : [
		'adaptor'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #accessing }
GLMFallbackScrollListBrick >> adaptor [

	^ adaptor
]

{ #category : #accessing }
GLMFallbackScrollListBrick >> adaptor: anAdaptor [

	adaptor := anAdaptor
]

{ #category : #'as yet unclassified' }
GLMFallbackScrollListBrick >> doLayout [
	super doLayout.
	self band hasSubbricks not ifTrue: [ self initializeItems ]
]

{ #category : #'as yet unclassified' }
GLMFallbackScrollListBrick >> initializeItems [

	1 to: self adaptor count do: [ :index |
		self band addBrickBack: (self adaptor morphAt: index convert: nil) ].
	
	self doLayout.
	self changed.
]

{ #category : #'as yet unclassified' }
GLMFallbackScrollListBrick >> invalidate [

	self band removeAllBricks.
	self initializeItems
]
