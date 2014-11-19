"
A GLMBrickVerticalLinearLayout is Linear layout, where all Bricks are being positioned vertically in one line. The size of Bricks depends only from each Brick's extent. If any Bricks goes outside of the parent with this layout, outside part will not be drawn.

"
Class {
	#name : #GLMBrickVerticalLinearLayout,
	#superclass : #GLMBrickLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickVerticalLinearLayout >> layout: aBrick in: newBounds [
	
	aBrick subbricks
		inject: 0
		into: [ :currentTopOffset :each |
			|left top maxHeight extent newTopOffset|
			each layoutProperties floating = #none ifTrue: [
				newTopOffset := currentTopOffset + each layoutProperties marginTop.
			
				left := each layoutProperties marginLeft.
				top := newTopOffset.
			
				maxHeight := (each layoutProperties maxHeightBlock value: each) >= 0
						ifTrue: [ each layoutProperties maxHeightBlock value: each ]
						ifFalse: [ SmallInteger maxVal ].
			
				extent := self extentOf: each in: aBrick.
				extent := extent x @ (extent y min: maxHeight).
			
				each isBrick
					ifTrue: [ each brickBounds: ((left@top) extent: extent) ]
					ifFalse: [ each bounds: (((left@top) extent: extent) translateBy: aBrick globalBounds origin) ].
				
				newTopOffset + each height + each layoutProperties marginBottom ]
			ifFalse: [ self layoutFloating: each in: newBounds ]
		]

	
]
