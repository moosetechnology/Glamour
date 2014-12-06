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
	averageItemHeight := (visible inject: 0 into: [ :visibleHeight :each | visibleHeight + each height ]) / visible size.
	^ self scrollPane adapter count * averageItemHeight.
]

{ #category : #'as yet unclassified' }
GLMApproximateScrollbarBrick >> calculateScrollbarHeight [

	^ (((self scrollPane height) / (self approximateBandHeight)) * self height) ceiling.
	
]

{ #category : #'as yet unclassified' }
GLMApproximateScrollbarBrick >> calculateScrollbarTopOffset [

	^ (((self height) / (self approximateBandHeight)) * (self scrollPane band brickBounds top abs)) floor.
]
