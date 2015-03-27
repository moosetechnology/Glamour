"
Use me in case something went wrong on production
"
Class {
	#name : #GLMFallbackScrollListBrick,
	#superclass : #GLMScrollPaneBrick,
	#instVars : [
		'adaptor'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Scrollpane'
}

{ #category : #accessing }
GLMFallbackScrollListBrick >> adaptor [

	^ adaptor
]

{ #category : #accessing }
GLMFallbackScrollListBrick >> adaptor: anAdaptor [

	adaptor := anAdaptor.
	self initializeItems
]

{ #category : #initialization }
GLMFallbackScrollListBrick >> initializeItems [
	
	self band layoutAfter: [
		1 to: self adaptor count do: [ :index |
			self band addBrickBack: ((self adaptor morphAt: index convert: nil) asBrick with:[:b |
				b isHeightDependsOnParent ifTrue: [ b height: 30 ]]) ] ].
	
	self band hasSubbricks ifFalse: [ ^ self ]
]

{ #category : #scrolling }
GLMFallbackScrollListBrick >> invalidate [

	self band removeAllBricks.
	self initializeItems
]
