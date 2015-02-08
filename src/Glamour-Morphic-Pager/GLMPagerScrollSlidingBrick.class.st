Class {
	#name : #GLMPagerScrollSlidingBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'startDragX',
		'isResizing',
		'startResizingWidth',
		'resizingZoneWidth',
		'isRightResizing',
		'isLeftResizing',
		'pagerModel'
	],
	#category : #'Glamour-Morphic-Pager-Brick'
}

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingBrick >> computeScrollValue: aNumber [
	|newValue minLeft maxLeft value interval|
	
	newValue := aNumber.
	minLeft := 0.
	maxLeft := self owner width - self width.
	
	newValue < minLeft ifTrue: [ newValue := minLeft ].
	newValue > maxLeft ifTrue: [ newValue := maxLeft ].
	
	interval := self owner width.
		
	value := (interval = self width)
		ifTrue: [ 0 ]
		ifFalse: [ (newValue - minLeft) / (interval - self width) ].
	
	^ value.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingBrick >> computeWidth [
	|width numberOfVisiblePages|

	width := pagerModel isNotNil
		ifTrue: [
			numberOfVisiblePages := pagerModel numberOfVisiblePages.
			numberOfVisiblePages > pagerModel size
				ifTrue: [ numberOfVisiblePages := pagerModel size ].
			(pagerModel circleButtonSize) * numberOfVisiblePages + ((numberOfVisiblePages - 1) * pagerModel dependencyButtonSize).
		]
		ifFalse: [ 0 ].
		
	^ width.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingBrick >> delete [
	super delete.
	pagerModel announcer unsubscribe: self.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingBrick >> dragResizingLeft: evt [
	| leftDelta left right maxLeft|
	
	leftDelta:= (self bounds right - startResizingWidth - evt position x - startDragX).
	
	right := self layoutFrame rightOffset.
	left := right - startResizingWidth - leftDelta.
	maxLeft := right - pagerModel circleButtonSize.
	
	left := (left max: 0) min: maxLeft.
	
	self layoutFrame: (
		LayoutFrame 
			fractions: (0 @ 0 corner: 0 @ 0)
			offsets: (left @ 0 corner: right @ self height)
	).
	
	pagerModel notifyScrollerBoundsChanged: (owner left + left)@(owner left + right).
	
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingBrick >> dragResizingRight: evt [
	| rightDelta left right minRight maxRight|
	
	rightDelta:= (evt position x - self left - startDragX).
	
	left := self layoutFrame leftOffset.
	right := left + startResizingWidth + rightDelta.
	minRight := left + pagerModel circleButtonSize.
	maxRight := owner width.
	
	right := (right max: minRight) min: maxRight.
	
	self layoutFrame: (
		LayoutFrame 
			fractions: (0 @ 0 corner: 0 @ 0)
			offsets: (left @ 0 corner: right @ self height)
	).
	
	pagerModel notifyScrollerBoundsChanged: (owner left + left)@(owner left + right).
	
]

{ #category : #'slider-draging' }
GLMPagerScrollSlidingBrick >> dragSliding: evt [
	| newLeft value|
	
	newLeft := (evt position x - self owner globalBounds left - startDragX).
	value := self computeScrollValue: newLeft.
	
	self scrollTo: value.
	self synchronizeScrollTo: value.
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingBrick >> handleMouseOver: anEvent [
	super handleMouseOver: anEvent.
		
	isResizing | (self isMouseEventInsideLeftResizingZone: anEvent) | (self isMouseEventInsideRightResizingZone: anEvent)
		ifTrue: [ self setCursorToResizing: anEvent ]
		ifFalse: [ self setCursorToNormal: anEvent ].
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingBrick >> handlesMouseOverDragging: evt [
	^ true
]

{ #category : #initialization }
GLMPagerScrollSlidingBrick >> initialize [
	super initialize.
		
	resizingZoneWidth := 7.
	isRightResizing := false.
	isLeftResizing := false.
	isResizing := false.
		
	self normalColor: (Color veryLightGray alpha: 0.4).
	self flag: 'Do we need a :hover effect?'.
	self selectedColor: (Color veryLightGray alpha: 0.55).
	self enable.
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingBrick >> isMouseEventInsideLeftResizingZone: evt [
	|resizingRectangle bottom right globalBounds|
	globalBounds := self globalBounds.
	
	bottom := globalBounds bottom.
	right := globalBounds left + resizingZoneWidth.
	
	resizingRectangle := globalBounds origin corner: right@bottom.
	
	^ resizingRectangle containsPoint: evt position.
	
	
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingBrick >> isMouseEventInsideRightResizingZone: evt [
	|resizingRectangle top left globalBounds|
	globalBounds := self globalBounds.
	
	top := globalBounds top.
	left := globalBounds right - resizingZoneWidth.
	
	resizingRectangle := left@top corner: globalBounds corner.
	
	^ resizingRectangle containsPoint: evt position.
	
	
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingBrick >> mouseDown: evt [

	startDragX := (evt position x - self globalBounds left).
	startResizingWidth := self width.
	
	isRightResizing := self isMouseEventInsideRightResizingZone: evt.
	
	"only one type of resizing is possible"
	isRightResizing
		ifFalse: [ isLeftResizing := self isMouseEventInsideLeftResizingZone: evt ]
		ifTrue: [ isLeftResizing := false ].

	isResizing := (isLeftResizing or: isRightResizing).
		
	super mouseDown: evt.
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingBrick >> mouseLeave: evt [

	self setCursorToNormal: evt.
	super mouseLeave: evt.
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingBrick >> mouseMove: evt [

	isRightResizing
		ifTrue: [ self dragResizingRight: evt ]
		ifFalse: [
			isLeftResizing
				ifTrue: [ self dragResizingLeft: evt ]
				ifFalse: [ self dragSliding: evt ] ].
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingBrick >> mouseUp: evt [
	super mouseUp: evt.
	
	pagerModel recomputeState: (isResizing not).
	
	isResizing ifTrue: [ self setWidthAfterResizing ].
	
	isResizing := false.
		
	(self globalBounds containsPoint: evt position)
		ifFalse: [ self setCursorToNormal: evt ]
		ifTrue: [ self setCursorToResizing: evt ] 
]

{ #category : #'slider-scrolling' }
GLMPagerScrollSlidingBrick >> moveLeft: left [ "Integer - pixels"

	"moves scrollbar inside parent to the specified left distance in pixels and notifies all listeners about that"
	| right |
	right := left + self width.
	self marginLeft: left.
	self doLayoutForce.
	self owner changed.
	
	"pagerModel notifyScrollerBoundsChanged: (owner left + left )@(owner left + right)."
]

{ #category : #'announcement handling' }
GLMPagerScrollSlidingBrick >> onResized [

	self setWidthAfterResizing.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingBrick >> onScrollPositionChanged: announcement [
	
	self scrollToPane: pagerModel firstVisiblePageIndex smooth: announcement smooth
]

{ #category : #accessing }
GLMPagerScrollSlidingBrick >> pagerModel: anAdapter [
	
	pagerModel := anAdapter.
			
	pagerModel announcer weak 
		when: GLMNumberOfVisiblePagesChanged send: #onResized to: self.
		
	pagerModel announcer weak 
		when: GLMPagerScrollPositionChanged send: #onScrollPositionChanged: to: self.
		
	self width: self computeWidth.
]

{ #category : #'slider-cursor' }
GLMPagerScrollSlidingBrick >> resizeCursor [

	^ Cursor resizeForEdge: #left
]

{ #category : #'slider-scrolling' }
GLMPagerScrollSlidingBrick >> scrollTo: aFloat [ "Float - percentage/100"

	"scrolls to a specified float number which must be in interval [0.0, 1.0]"

	self moveLeft: (owner width - self width) * aFloat.
]

{ #category : #'slider-scrolling' }
GLMPagerScrollSlidingBrick >> scrollTo: aValue duration: anInteger [

	anInteger <= 0
		"if duration is zero, move to the left immediately"
		ifTrue: [ self scrollTo: aValue ]
		ifFalse: [
			| startTime start currentValue |
			currentValue := self computeScrollValue: self bounds left.
			startTime := Time millisecondClockValue.
			start := currentValue.
			[	| delta |
				[ (delta := Time millisecondClockValue - startTime) < anInteger ] whileTrue: [
					self scrollTo: ((aValue - start) * (delta / anInteger) + start).
					Processor yield
				].
				self scrollTo: aValue.
			] fork
		]
]

{ #category : #'slider-scrolling' }
GLMPagerScrollSlidingBrick >> scrollTo: aValue smooth: aBoolean [

	aBoolean
		ifTrue: [ self scrollTo: aValue "duration: 200" ]
		ifFalse: [ self scrollTo: aValue ]
]

{ #category : #'slider-scrolling' }
GLMPagerScrollSlidingBrick >> scrollToPane: anIndex smooth: isSmooth [

	self scrollTo: (pagerModel convertIndexToValue: anIndex) smooth: isSmooth.
]

{ #category : #'slider-cursor' }
GLMPagerScrollSlidingBrick >> setCursorToNormal: evt [
		
	evt hand showTemporaryCursor: nil
]

{ #category : #'slider-cursor' }
GLMPagerScrollSlidingBrick >> setCursorToResizing: evt [
	
	evt hand showTemporaryCursor: self resizeCursor
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingBrick >> setWidthAfterResizing [
	| left right |
	
	left := ( pagerModel circleButtonSize + pagerModel dependencyButtonSize ) * (pagerModel firstVisiblePageIndex - 1).
	right := left + self computeWidth.
	
	self width: (right - left).
	
	pagerModel notifyScrollerBoundsChanged: (owner left + left )@(owner left + right).
]

{ #category : #'slider-scrolling' }
GLMPagerScrollSlidingBrick >> synchronizeScrollTo: aValue [

	pagerModel synchronizeScrollTo: aValue.
]
