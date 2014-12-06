"
A GLMApproximateScrollbarBrick can be used only with GLMScrollListBrick or with other lists that uses adapters.

Approximates the height of band depending on average height of all visible items.

"
Class {
	#name : #GLMApproximateScrollbarBrick,
	#superclass : #GLMScrollbarBrick,
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMApproximateScrollbarBrick >> approximateBandHeight [
	|visible averageItemHeight|
	
	visible := self scrollPane band submorphs select: [ :each | self scrollPane isVisible: each ].
	visible isEmpty ifTrue: [ ^ 0 ].
	
	averageItemHeight := (visible inject: 0 into: [ :visibleHeight :each | visibleHeight + each height ]) / visible size.
	^ self scrollPane adapter count * averageItemHeight.
]

{ #category : #'as yet unclassified' }
GLMApproximateScrollbarBrick >> calculateScrollbarHeight [
	|bandHeight|
	bandHeight := self approximateBandHeight.
	bandHeight = 0 ifTrue: [ ^ 0 ].
	
	^ (self scrollPane height / bandHeight * self height) ceiling.
	
]

{ #category : #'as yet unclassified' }
GLMApproximateScrollbarBrick >> calculateScrollbarTopOffset [
	|bandHeight|
	bandHeight := self approximateBandHeight.
	bandHeight = 0 ifTrue: [ ^ 0 ].
	
	^ (self height / bandHeight * self scrollPane band brickBounds top abs) floor.
]
