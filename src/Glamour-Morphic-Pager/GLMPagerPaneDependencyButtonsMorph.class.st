Class {
	#name : #GLMPagerPaneDependencyButtonsMorph,
	#superclass : #GLMPagerPaneButtonsMorph,
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerPaneDependencyButtonsMorph >> addScrollButton: aMorph [
	|arrowScaleMultiplier|
	arrowScaleMultiplier := 2.
	
	pagerModel size > 1 ifTrue: [
		self addMorphBack: (ImageMorph withForm: (GLMForm increaseFormExtentCentered: (GLMForm scaleForm: GLMUIThemeExtraIcons glamorousPlay to: (pagerModel dependencyButtonSize @ pagerModel dependencyButtonSize) / arrowScaleMultiplier ) to: (pagerModel dependencyButtonSize @ pagerModel dependencyButtonSize)))
	].
	
	super addScrollButton: aMorph.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneDependencyButtonsMorph >> buttonCenterByIndex: aNumber isLeft: isLeft [
	|button|
	button := indicatorButtons at: aNumber.
	^ isLeft ifTrue: [ button right ]
				ifFalse: [ button left ]
]

{ #category : #'as yet unclassified' }
GLMPagerPaneDependencyButtonsMorph >> isScrollMustBeChecked: anIndex withLeft: leftBound andRight: rightBound [

	^ (leftBound <= (self buttonCenterByIndex: anIndex isLeft: true) ) & (rightBound > (self buttonCenterByIndex: anIndex isLeft: false))
]

{ #category : #'as yet unclassified' }
GLMPagerPaneDependencyButtonsMorph >> removeScrollButton: aButton [

	self removeMorph: aButton.
	
	pagerModel size > 0 ifTrue: [ 
		self removeMorph: (self submorphs last).
	]
]

{ #category : #'as yet unclassified' }
GLMPagerPaneDependencyButtonsMorph >> width [
	|width|
	width := pagerModel isNotNil
		ifTrue: [ ((indicatorButtons size * (pagerModel circleButtonSize )) + ((indicatorButtons size - 1) * pagerModel dependencyButtonSize)) ]
		ifFalse: [ 0 ].
	^ width
]
