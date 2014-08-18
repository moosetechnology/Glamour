"
A GLMPagerScrollSlidingMorph is xxxxxxxxx.

Instance Variables
	adapter:		<Object>
	isLeftResizing:		<Object>
	isResizing:		<Object>
	isRightResizing:		<Object>
	resizingZoneWidth:		<Object>
	scrollResizingIcon:		<Object>
	scrollSelectedIcon:		<Object>
	startDragX:		<Object>
	startResizingWidth:		<Object>

adapter
	- xxxxx

drawCache
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
	#name : #GLMSlidingScrollMorph,
	#superclass : #GLMButton,
	#instVars : [
		'startDragX',
		'isResizing',
		'startResizingWidth',
		'adapter',
		'resizingZoneWidth',
		'isRightResizing',
		'isLeftResizing'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #accessing }
GLMSlidingScrollMorph >> adapter: anAdapter [
	
	adapter := anAdapter.
			
	adapter announcer weak 
		on: GLMNumberOfVisiblePagesChanged send: #onResized to: self.
		
	adapter announcer weak 
		on: GLMPagerScrollPositionChanged send: #onScrollPositionChanged: to: self.
		
	self width: self computeWidth.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> computeScrollValue: aNumber [
	|minLeft maxLeft value interval|
	
	minLeft := owner bounds left.
	maxLeft := owner bounds right - self width.
	
	aNumber < minLeft ifTrue: [ aNumber := minLeft ].
	aNumber > maxLeft ifTrue: [ aNumber := maxLeft ].
	
	interval := owner width.
		
	value := (interval = self width)
		ifTrue: [ 0.0 ]
		ifFalse: [ (aNumber - minLeft) / (interval - self width) ].
	
	^ value.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> computeWidth [
	|width numberOfVisiblePages|

	width := adapter isNotNil
		ifTrue: [
			numberOfVisiblePages := adapter numberOfVisiblePages.
			numberOfVisiblePages > adapter size
				ifTrue: [ numberOfVisiblePages := adapter size ].
			(adapter circleButtonSize) * numberOfVisiblePages + ((numberOfVisiblePages - 1) * adapter dependencyButtonSize).
		]
		ifFalse: [ 0 ].
		
	^ width.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> delete [
	super delete.
	adapter announcer unsubscribe: self.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> dragResizingLeft: evt [
	| leftDelta left right maxLeft|
	
	leftDelta:= (self bounds right - startResizingWidth - evt position x - startDragX).
	
	right := self layoutFrame rightOffset.
	left := right - startResizingWidth - leftDelta.
	maxLeft := right - adapter circleButtonSize.
	
	left := (left max: 0) min: maxLeft.
	
	self layoutFrame: (
		LayoutFrame 
			fractions: (0 @ 0 corner: 0 @ 0)
			offsets: (left @ 0 corner: right @ self height)
	).
	
	adapter notifyScrollerBoundsChanged: (owner left + left)@(owner left + right).
	
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> dragResizingRight: evt [
	| rightDelta left right minRight maxRight|
	
	rightDelta:= (evt position x - self left - startDragX).
	
	left := self layoutFrame leftOffset.
	right := left + startResizingWidth + rightDelta.
	minRight := left + adapter circleButtonSize.
	maxRight := owner width.
	
	right := (right max: minRight) min: maxRight.
	
	self layoutFrame: (
		LayoutFrame 
			fractions: (0 @ 0 corner: 0 @ 0)
			offsets: (left @ 0 corner: right @ self height)
	).
	
	adapter notifyScrollerBoundsChanged: (owner left + left)@(owner left + right).
	
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> dragSliding: evt [
	| newLeft value|
	
	newLeft := (evt position x - startDragX).
	value := self computeScrollValue: newLeft.
	
	self scrollTo: value.
	self synchronizeScrollTo: value.
]

{ #category : #'event-mouse' }
GLMSlidingScrollMorph >> handleMouseOver: anEvent [
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
GLMSlidingScrollMorph >> handlesMouseOverDragging: evt [
	^ true
]

{ #category : #initialization }
GLMSlidingScrollMorph >> initialize [
	super initialize.
		
	resizingZoneWidth := 7.
	isRightResizing := false.
	isLeftResizing := false.
	isResizing := false.
	
	self image state normalColor: (Color veryLightGray alpha: 0.15).
	self flag: 'Do we need a :hover effect?'.
	self image state selectedColor: (Color veryLightGray alpha: 0.25).
]

{ #category : #'event-mouse' }
GLMSlidingScrollMorph >> isMouseEventInsideLeftResizingZone: evt [
	|resizingRectangle bottom right|
	
	bottom := self bounds bottom.
	right := self bounds left + resizingZoneWidth.
	
	resizingRectangle := self bounds origin corner: right@bottom.
	
	^ resizingRectangle containsPoint: evt position.
	
	
]

{ #category : #'event-mouse' }
GLMSlidingScrollMorph >> isMouseEventInsideRightResizingZone: evt [
	|resizingRectangle top left|
	
	top := self bounds top.
	left := self bounds right - resizingZoneWidth.
	
	resizingRectangle := left@top corner: self bounds corner.
	
	^ resizingRectangle containsPoint: evt position.
	
	
]

{ #category : #'event-mouse' }
GLMSlidingScrollMorph >> mouseDown: evt [

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
GLMSlidingScrollMorph >> mouseLeave: evt [

	self setCursorToNormal: evt.
	super mouseLeave: evt.
]

{ #category : #'event-mouse' }
GLMSlidingScrollMorph >> mouseMove: evt [

	isRightResizing
		ifTrue: [ self dragResizingRight: evt ]
		ifFalse: [
			isLeftResizing
				ifTrue: [ self dragResizingLeft: evt ]
				ifFalse: [ self dragSliding: evt ]
		].
]

{ #category : #'event-mouse' }
GLMSlidingScrollMorph >> mouseUp: evt [
	super mouseUp: evt.
	
	adapter recomputeState.
	
	isResizing
		ifTrue: [
			"adapter numberOfVisiblePagesChanged ifFalse: [ self onResized ]."
		]
		ifFalse: [
			"smooth scrolling to fisrt visible page"
			"adapter switchPageTo: adapter firstVisiblePageIndex updateFocus: false updateSelection: false."
		].	
	
	isResizing := false.
		
	(bounds containsPoint: evt position)
		ifFalse: [ self setCursorToNormal: evt ]
		ifTrue: [ self setCursorToResizing: evt ] 
]

{ #category : #scrolling }
GLMSlidingScrollMorph >> moveLeft: left [ "Integer - pixels"

	"moves scrollbar inside parent to the specified left distance in pixels and notifies all listeners about that"
	| right |
	
	right := left + self computeWidth.
	
	self layoutFrame: (
		LayoutFrame 
			fractions: (0 @ 0 corner: 0 @ 0)
			offsets: (left @ 0 corner: right @ self height)
	).
	
	adapter notifyScrollerBoundsChanged: (owner left + left )@(owner left + right).
]

{ #category : #'announcement handling' }
GLMSlidingScrollMorph >> onResized [
	self setWidthAfterResizing.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> onScrollPositionChanged: announcement [

	self scrollToPane: adapter firstVisiblePageIndex smooth: announcement smooth.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> resizeCursor [

	^ Cursor resizeForEdge: #left
]

{ #category : #scrolling }
GLMSlidingScrollMorph >> scrollTo: aFloat [ "Float - percentage/100"

	"scrolls to a specified float number which must be in interval [0.0, 1.0]"

	self moveLeft: (owner width - self width) * aFloat.
]

{ #category : #scrolling }
GLMSlidingScrollMorph >> scrollTo: aValue duration: anInteger [

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
GLMSlidingScrollMorph >> scrollTo: aValue smooth: aBoolean [

	aBoolean
		ifTrue: [ self scrollTo: aValue duration: 200 ]
		ifFalse: [ self scrollTo: aValue ] 
]

{ #category : #scrolling }
GLMSlidingScrollMorph >> scrollToPane: anIndex smooth: isSmooth [

	self scrollTo: (adapter convertIndexToValue: anIndex) smooth: isSmooth.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> setCursorToNormal: evt [
		
	evt hand showTemporaryCursor: nil
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> setCursorToResizing: evt [
	
	evt hand showTemporaryCursor: self resizeCursor
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> setWidthAfterResizing [
	| left right |
	
	left := ( adapter circleButtonSize + adapter dependencyButtonSize ) * (adapter firstVisiblePageIndex - 1).
	right := left + self computeWidth.
	
	self layoutFrame: (
		LayoutFrame 
			fractions: (0 @ 0 corner: 0 @ 0)
			offsets: (left @ 0 corner: right @ self height)
	).
	
	adapter notifyScrollerBoundsChanged: (owner left + left )@(owner left + right).
]

{ #category : #scrolling }
GLMSlidingScrollMorph >> synchronizeScrollTo: aValue [

	adapter synchronizeScrollTo: aValue.
]
