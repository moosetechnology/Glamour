"
A GLMPagerScrollSlidingMorph is xxxxxxxxx.

Instance Variables
	pagerModel		<Object>
	isLeftResizing:		<Object>
	isResizing:		<Object>
	isRightResizing:		<Object>
	resizingZoneWidth:		<Object>
	scrollResizingIcon:		<Object>
	scrollSelectedIcon:		<Object>
	startDragX:		<Object>
	startResizingWidth:		<Object>

pagerModel
	- xxxxx

isLeftResizing
	- xxxxx

isResizing
	- xxxxx

isRightResizing
	- xxxxx

resizingZoneWidth
	- xxxxx

scrollResizingIcon
	- xxxxx

scrollSelectedIcon
	- xxxxx

startDragX
	- xxxxx

startResizingWidth
	- xxxxx

"
Class {
	#name : #GLMPagerScrollSlidingMorph,
	#superclass : #GLMButton,
	#instVars : [
		'startDragX',
		'isResizing',
		'startResizingWidth',
		'resizingZoneWidth',
		'isRightResizing',
		'isLeftResizing',
		'pagerModel'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingMorph >> computeScrollValue: aNumber [
	|newValue minLeft maxLeft value interval|
	
	newValue := aNumber.
	minLeft := owner bounds left.
	maxLeft := owner bounds right - self width.
	
	newValue < minLeft ifTrue: [ newValue := minLeft ].
	newValue > maxLeft ifTrue: [ newValue := maxLeft ].
	
	interval := owner width.
		
	value := (interval = self width)
		ifTrue: [ 0.0 ]
		ifFalse: [ (newValue - minLeft) / (interval - self width) ].
	
	^ value.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingMorph >> computeWidth [
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
GLMPagerScrollSlidingMorph >> delete [
	super delete.
	pagerModel announcer unsubscribe: self.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingMorph >> dragResizingLeft: evt [
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
GLMPagerScrollSlidingMorph >> dragResizingRight: evt [
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

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingMorph >> dragSliding: evt [
	| newLeft value|
	
	newLeft := (evt position x - startDragX).
	value := self computeScrollValue: newLeft.
	
	self scrollTo: value.
	self synchronizeScrollTo: value.
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingMorph >> handleMouseOver: anEvent [
	super handleMouseOver: anEvent.
		
	isResizing | (self isMouseEventInsideLeftResizingZone: anEvent) | (self isMouseEventInsideRightResizingZone: anEvent)
	ifTrue: [
		self setCursorToResizing: anEvent.
	]
	ifFalse: [
		self setCursorToNormal: anEvent.
	].
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingMorph >> handlesMouseOverDragging: evt [
	^ true
]

{ #category : #initialization }
GLMPagerScrollSlidingMorph >> initialize [
	super initialize.
		
	resizingZoneWidth := 7.
	isRightResizing := false.
	isLeftResizing := false.
	isResizing := false.
		
	self image state normalColor: (Color veryLightGray alpha: 0.4).
	self flag: 'Do we need a :hover effect?'.
	self image state selectedColor: (Color veryLightGray alpha: 0.55).
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingMorph >> isMouseEventInsideLeftResizingZone: evt [
	|resizingRectangle bottom right|
	
	bottom := self bounds bottom.
	right := self bounds left + resizingZoneWidth.
	
	resizingRectangle := self bounds origin corner: right@bottom.
	
	^ resizingRectangle containsPoint: evt position.
	
	
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingMorph >> isMouseEventInsideRightResizingZone: evt [
	|resizingRectangle top left|
	
	top := self bounds top.
	left := self bounds right - resizingZoneWidth.
	
	resizingRectangle := left@top corner: self bounds corner.
	
	^ resizingRectangle containsPoint: evt position.
	
	
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingMorph >> mouseDown: evt [

	startDragX := (evt position x - self left).
	startResizingWidth := self width.
	
	isRightResizing := self isMouseEventInsideRightResizingZone: evt.
	
	"only one type of resizing is possible"
	isRightResizing ifFalse: [ 
		isLeftResizing := self isMouseEventInsideLeftResizingZone: evt.
	]
	ifTrue: [ isLeftResizing := false ].

	isResizing := (isLeftResizing or: isRightResizing).
		
	super mouseDown: evt.
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingMorph >> mouseLeave: evt [

	self setCursorToNormal: evt.
	super mouseLeave: evt.
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingMorph >> mouseMove: evt [

	isRightResizing
		ifTrue: [ self dragResizingRight: evt ]
		ifFalse: [
			isLeftResizing
				ifTrue: [ self dragResizingLeft: evt ]
				ifFalse: [ self dragSliding: evt ]
		].
]

{ #category : #'event-mouse' }
GLMPagerScrollSlidingMorph >> mouseUp: evt [
	super mouseUp: evt.
	
	pagerModel recomputeState: (isResizing not).
	
	isResizing
		ifTrue: [
			self setWidthAfterResizing.
		].
	
	isResizing := false.
		
	(bounds containsPoint: evt position)
		ifFalse: [ self setCursorToNormal: evt ]
		ifTrue: [ self setCursorToResizing: evt ] 
]

{ #category : #scrolling }
GLMPagerScrollSlidingMorph >> moveLeft: left [ "Integer - pixels"

	"moves scrollbar inside parent to the specified left distance in pixels and notifies all listeners about that"
	| right |
	
	right := left + self width.
	
	self layoutFrame: (
		LayoutFrame 
			fractions: (0 @ 0 corner: 0 @ 0)
			offsets: (left @ 0 corner: right @ self height)
	).
	
	pagerModel notifyScrollerBoundsChanged: (owner left + left )@(owner left + right).
]

{ #category : #'announcement handling' }
GLMPagerScrollSlidingMorph >> onResized [

	self setWidthAfterResizing.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingMorph >> onScrollPositionChanged: announcement [
	
	self scrollToPane: pagerModel firstVisiblePageIndex smooth: announcement smooth.
]

{ #category : #accessing }
GLMPagerScrollSlidingMorph >> pagerModel: anAdapter [
	
	pagerModel := anAdapter.
			
	pagerModel announcer weak 
		on: GLMNumberOfVisiblePagesChanged send: #onResized to: self.
		
	pagerModel announcer weak 
		on: GLMPagerScrollPositionChanged send: #onScrollPositionChanged: to: self.
		
	self width: self computeWidth.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingMorph >> resizeCursor [

	^ Cursor resizeForEdge: #left
]

{ #category : #scrolling }
GLMPagerScrollSlidingMorph >> scrollTo: aFloat [ "Float - percentage/100"

	"scrolls to a specified float number which must be in interval [0.0, 1.0]"

	self moveLeft: (owner width - self width) * aFloat.
]

{ #category : #scrolling }
GLMPagerScrollSlidingMorph >> scrollTo: aValue duration: anInteger [

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

{ #category : #scrolling }
GLMPagerScrollSlidingMorph >> scrollTo: aValue smooth: aBoolean [

	aBoolean
		ifTrue: [ self scrollTo: aValue duration: 200 ]
		ifFalse: [ self scrollTo: aValue ] 
]

{ #category : #scrolling }
GLMPagerScrollSlidingMorph >> scrollToPane: anIndex smooth: isSmooth [

	self scrollTo: (pagerModel convertIndexToValue: anIndex) smooth: isSmooth.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingMorph >> setCursorToNormal: evt [
		
	evt hand showTemporaryCursor: nil
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingMorph >> setCursorToResizing: evt [
	
	evt hand showTemporaryCursor: self resizeCursor
]

{ #category : #'as yet unclassified' }
GLMPagerScrollSlidingMorph >> setWidthAfterResizing [
	| left right |
	
	left := ( pagerModel circleButtonSize + pagerModel dependencyButtonSize ) * (pagerModel firstVisiblePageIndex - 1).
	right := left + self computeWidth.
	
	self layoutFrame: (
		LayoutFrame 
			fractions: (0 @ 0 corner: 0 @ 0)
			offsets: (left @ 0 corner: right @ self height)
	).
	
	pagerModel notifyScrollerBoundsChanged: (owner left + left )@(owner left + right).
]

{ #category : #scrolling }
GLMPagerScrollSlidingMorph >> synchronizeScrollTo: aValue [

	pagerModel synchronizeScrollTo: aValue.
]
