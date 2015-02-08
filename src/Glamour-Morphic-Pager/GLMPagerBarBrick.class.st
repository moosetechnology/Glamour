Class {
	#name : #GLMPagerBarBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'buttonsBrick',
		'pagerModel',
		'sliderBrick'
	],
	#category : #'Glamour-Morphic-Pager-Brick'
}

{ #category : #'bar-accessing' }
GLMPagerBarBrick >> buttonsBrick [

	^ buttonsBrick
]

{ #category : #'bar-accessing' }
GLMPagerBarBrick >> buttonsBrick: aBrick [

	buttonsBrick := aBrick.
	
	self buttonsBrick pagerModel: pagerModel.
	
	self buttonsBrick
		hShrinkWrap;
		vShrinkWrap.
	
	self addBrickBack: self buttonsBrick
]

{ #category : #initialization }
GLMPagerBarBrick >> initialize [
	super initialize.
	
	self color: Color lightRed
]

{ #category : #'bar-instance creation' }
GLMPagerBarBrick >> newButtonsBrick [

	^ GLMPagerButtonsPaneBrick new
]

{ #category : #'bar-instance creation' }
GLMPagerBarBrick >> newSliderBrick [

	^ GLMPagerScrollSlidingBrick new
]

{ #category : #'bar-event-handling' }
GLMPagerBarBrick >> onPagePoped [

	buttonsBrick onPagePoped.
	self recomputeScrollBar.
]

{ #category : #'bar-event-handling' }
GLMPagerBarBrick >> onPagePushed: addedAnnouncement [

	self buttonsBrick onPagePushed: addedAnnouncement.
	self recomputeScrollBar.
]

{ #category : #'bar-accessing' }
GLMPagerBarBrick >> pagerModel [

	^ pagerModel
]

{ #category : #'bar-accessing' }
GLMPagerBarBrick >> pagerModel: aModel [
	
	pagerModel := aModel.
	
	self pagerModel announcer weak subscribe: GLMPagePushed send: #onPagePushed: to: self.
	self pagerModel announcer weak subscribe: GLMPagePoped send: #onPagePoped to: self.
	
	self buttonsBrick: self newButtonsBrick.
	"self sliderBrick: self newSliderBrick."
]

{ #category : #initialization }
GLMPagerBarBrick >> recomputeScrollBar [
	
	sliderBrick ifNotNil: [
		"sliderBrick width: sliderBrick computeWidth."
		"sliderBrick setWidthAfterResizing."
	]
]

{ #category : #'bar-accessing' }
GLMPagerBarBrick >> sliderBrick [
	^ sliderBrick
]

{ #category : #'bar-accessing' }
GLMPagerBarBrick >> sliderBrick: aBrick [

	sliderBrick := aBrick.
	
	self sliderBrick pagerModel: self pagerModel.
	self sliderBrick height: self pagerModel circleButtonSize.
	self addBrickBack: self sliderBrick
]