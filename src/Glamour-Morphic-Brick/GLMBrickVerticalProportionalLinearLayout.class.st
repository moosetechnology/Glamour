"
A GLMBrickVerticalProportionalLinearLayout is an improvement of standard VerticalLinearLayout such that element are positioned proportionaly in the parent based on Brick>>layoutProperties verticalPercent.

"
Class {
	#name : #GLMBrickVerticalProportionalLinearLayout,
	#superclass : #GLMBrickVerticalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickVerticalProportionalLinearLayout >> extentOf: aBrick in: owner [
	
	^ (aBrick width) @ ((owner height * aBrick layoutProperties verticalPercent / 100) ceiling - aBrick layoutProperties marginTop - aBrick layoutProperties marginBottom)
]

{ #category : #accessing }
GLMBrickVerticalProportionalLinearLayout >> layout: aBrick in: newBounds [
	
	|allowedHeight maxPercent|
	allowedHeight := aBrick height.
	maxPercent := 100.
	
	aBrick subbricks do: [ :each |
		(self percentageHeightOf: each in: aBrick) < (each layoutProperties minHeight) ifTrue: [ 
			allowedHeight := allowedHeight - each layoutProperties minHeight.
			maxPercent := maxPercent - each layoutProperties verticalPercent.
		]
	].
	
	aBrick subbricks
		inject: 0
		into: [ :height :each |
			|left top extent maxHeight|
			left := each layoutProperties marginLeft.
			
			height := height + each layoutProperties marginTop.
			top := height.
						
			maxHeight := (each layoutProperties maxHeightBlock value: each) >= 0
						ifTrue: [ each layoutProperties maxHeightBlock value: each ]
						ifFalse: [ SmallInteger maxVal ].
			
			(self percentageHeightOf: each in: aBrick) < (each layoutProperties minHeight) ifTrue: [ 
				extent := ((self extentOf: each in: aBrick) x) @ (each layoutProperties minHeight - each layoutProperties marginTop - each layoutProperties marginBottom).
			]
			ifFalse: [ 	
				extent := ((self extentOf: each in: aBrick) x) @ ((((allowedHeight * each layoutProperties verticalPercent / maxPercent) ceiling) - each layoutProperties marginTop - each layoutProperties marginBottom) min: maxHeight).
			].
			
			each isBrick
				ifTrue: [ each brickBounds: ((left@top) extent: extent) ]
				ifFalse: [ each bounds: (((left@top) extent: extent) translateBy: aBrick globalBounds origin) ].
			
			height + each height + each layoutProperties marginBottom.
		]

]

{ #category : #'as yet unclassified' }
GLMBrickVerticalProportionalLinearLayout >> percentageHeightOf: aBrick in: owner [

	^ (owner height * aBrick layoutProperties verticalPercent / 100) ceiling
]
