"
A GLMBrickHorizontalProportionalLinearLayout is an improvement of standard LinearLayout such that element are positioned proportionaly in the parent based on Brick>>layoutProperties horizontalPercent.

"
Class {
	#name : #GLMBrickHorizontalProportionalLinearLayout,
	#superclass : #GLMBrickHorizontalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickHorizontalProportionalLinearLayout >> extentOf: aBrick in: owner [
	
	^ ((owner width * aBrick layoutProperties horizontalPercent / 100) ceiling - aBrick layoutProperties marginLeft - aBrick layoutProperties marginRight) @ (aBrick height)
]

{ #category : #accessing }
GLMBrickHorizontalProportionalLinearLayout >> layout: aBrick in: newBounds [
	
	|allowedWidth maxPercent|
	allowedWidth := aBrick width.
	maxPercent := 100.
	
	aBrick subbricks do: [ :each |
		(self percentageWidthOf: each in: aBrick) < (each layoutProperties minWidth) ifTrue: [ 
			allowedWidth := allowedWidth - each layoutProperties minWidth.
			maxPercent := maxPercent - each layoutProperties horizontalPercent.
		]
	].
	
	aBrick subbricks
		inject: 0
		into: [ :width :each |
			|left top extent maxWidth|
			top := each layoutProperties marginTop.
			
			width := width + each layoutProperties marginLeft.
			left := width.
						
			maxWidth := (each layoutProperties maxWidthBlock value: each) >= 0
						ifTrue: [ each layoutProperties maxWidthBlock value: each ]
						ifFalse: [ SmallInteger maxVal ].
			
			(self percentageWidthOf: each in: aBrick) < (each layoutProperties minWidth) ifTrue: [ 
				extent := (each layoutProperties minWidth - each layoutProperties marginLeft - each layoutProperties marginRight) @ ((self extentOf: each in: aBrick) y).
			]
			ifFalse: [ 	
				extent := ((((allowedWidth * each layoutProperties horizontalPercent / maxPercent) ceiling) - each layoutProperties marginLeft - each layoutProperties marginRight) min: maxWidth) @ ((self extentOf: each in: aBrick) y).
			].
			
			each isBrick
				ifTrue: [ each brickBounds: ((left@top) extent: extent) ]
				ifFalse: [ each bounds: (((left@top) extent: extent) translateBy: aBrick globalBounds origin) ].
			
			width + each width + each layoutProperties marginRight.
		]

]

{ #category : #'as yet unclassified' }
GLMBrickHorizontalProportionalLinearLayout >> percentageWidthOf: aBrick in: owner [

	^ (owner width * aBrick layoutProperties horizontalPercent / 100) ceiling
]
