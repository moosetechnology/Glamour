Class {
	#name : #GLMTurboHorizontalProportionalLinearLayout,
	#superclass : #GLMTurboHorizontalLinearLayout,
	#category : #'Glamour-Morphic-Widgets-Turbo-Layouts'
}

{ #category : #'as yet unclassified' }
GLMTurboHorizontalProportionalLinearLayout >> extentOf: aTrick in: owner [
	
	^ ((owner width * aTrick layoutParams horizontalPercent / 100) ceiling - aTrick layoutParams marginLeft - aTrick layoutParams marginRight) @ (aTrick height)
]

{ #category : #'as yet unclassified' }
GLMTurboHorizontalProportionalLinearLayout >> percentageWidthOf: aTrick in: owner [

	^ (owner width * aTrick layoutParams horizontalPercent / 100) ceiling
]

{ #category : #'as yet unclassified' }
GLMTurboHorizontalProportionalLinearLayout >> position: aTrick [
	
	|allowedWidth summPercent|
	
	allowedWidth := aTrick width.
	summPercent := 100.
	
	aTrick subtricks do: [ :each |
		(self percentageWidthOf: each in: aTrick) < (each layoutParams minWidth) ifTrue: [ 
			allowedWidth := allowedWidth - each layoutParams minWidth.
			summPercent := summPercent - each layoutParams horizontalPercent.
		]
	].
	
	aTrick subtricks
		inject: 0
		into: [ :width :each |
			|left top extent|
			top := each layoutParams marginTop.
			
			width := width + each layoutParams marginLeft.
			left := width.
			
			(self percentageWidthOf: each in: aTrick) < (each layoutParams minWidth) ifTrue: [ 
				extent := (each layoutParams minWidth - each layoutParams marginLeft - each layoutParams marginRight) @ ((self extentOf: each in: aTrick) y).
			]
			ifFalse: [ 	
				extent := (((allowedWidth * each layoutParams horizontalPercent / summPercent) ceiling) - each layoutParams marginLeft - each layoutParams marginRight) @ ((self extentOf: each in: aTrick) y).
			].
					
			each bounds: ((left@top) extent: extent).
			width := width + each width + each layoutParams marginRight.
			width
		]

]
