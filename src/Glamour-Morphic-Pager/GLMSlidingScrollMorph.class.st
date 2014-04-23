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
		'isLeftResizing',
		'scrollResizingIcon',
		'scrollSelectedIcon'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #accessing }
GLMSlidingScrollMorph >> adapter: anAdapter [
	
	adapter := anAdapter.
	
	adapter announcer weak
		on: GLMPagerScrolled send: #onScrolled: to: self.
		
	adapter announcer weak 
		on: GLMNumberOfVisiblePagesChanged send: #onResized to: self.
		
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
	
	self flag: 'TODO: DIRTY HACK'.
	
	value := (interval = self width)
		ifTrue: [ 1.0 ]
		ifFalse: [ (aNumber - minLeft) / (interval - self width) ].
	
	^ value.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> computeWidth [
	|width numberOfVisiblePages|

	
	width := adapter isNotNil
		ifTrue: [
			numberOfVisiblePages := adapter numberOfVisiblePages.
			numberOfVisiblePages > adapter pagesCount
				ifTrue: [ numberOfVisiblePages := adapter pagesCount ].
			(adapter circleButtonInset + adapter circleButtonSize) * numberOfVisiblePages.
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
	maxLeft := right - (adapter circleButtonInset + adapter circleButtonSize).
	
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
	minRight := left + (adapter circleButtonInset + adapter circleButtonSize).
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
	
	self notifyScrollBarValue: value.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> glmAnimateValue: aValue duration: anInteger [

	anInteger <= 0
		"if duration is zero, move to the left immediately"
		ifTrue: [ self leftTo: aValue ]
		ifFalse: [
			| startTime start currentValue |
			currentValue := self computeScrollValue: self bounds left.
			startTime := Time millisecondClockValue.
			start := currentValue.
			[	| delta |
				[ (delta := Time millisecondClockValue - startTime) < anInteger ] whileTrue: [
					self leftTo: (aValue - start) * (delta / anInteger) + start.
					Processor yield
				].
				self leftTo: aValue
			] fork
		]
]

{ #category : #'as yet unclassified' }
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
	
	self label: ''.
	
	resizingZoneWidth := 7.
	isRightResizing := false.
	isLeftResizing := false.
	isResizing := false.
		
	self image state normal: GLMUIThemeExtraIcons glamorousLargeGrayCircleEmphasized.
	scrollResizingIcon := GLMUIThemeExtraIcons glamorousLargeGrayCircleEmphasized.
	scrollSelectedIcon := GLMUIThemeExtraIcons glamorousLargeGrayCircleEmphasized.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> isMouseEventInsideLeftResizingZone: evt [
	|resizingRectangle bottom right|
	
	bottom := self bounds bottom.
	right := self bounds left + resizingZoneWidth.
	
	resizingRectangle := self bounds origin corner: right@bottom.
	
	^ resizingRectangle containsPoint: evt position.
	
	
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> isMouseEventInsideRightResizingZone: evt [
	|resizingRectangle top left|
	
	top := self bounds top.
	left := self bounds right - resizingZoneWidth.
	
	resizingRectangle := left@top corner: self bounds corner.
	
	^ resizingRectangle containsPoint: evt position.
	
	
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> leftTo: aValue [
	|left|
	
	left := (owner width - self width) * aValue.
		
	self layoutFrame: (
		LayoutFrame 
			fractions: (0 @ 0 corner: 0 @ 0)
			offsets: (left @ 0 corner: (left + self width)@ self height)
	).
	
	adapter notifyScrollerBoundsChanged: (owner left + left)@(owner left + left + self width).
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
	
	"during resizing we can use other image"
	isResizing ifTrue: [ self image state selected: scrollResizingIcon ].
	
	super mouseDown: evt.
]

{ #category : #'as yet unclassified' }
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
	
	isResizing
		ifTrue: [
			adapter numberOfVisiblePagesChanged ifFalse: [ self onResized ].
		]
		ifFalse: [
			"smooth scrolling to fisrt visible page"
			adapter switchPageTo: adapter firstVisiblePageIndex updateFocus: false updateSelection: false.
		].	
	
	isResizing := false.
	
	"setting selected image to default after resizie is complete"
	self image state selected: scrollResizingIcon.
	
	(bounds containsPoint: evt position)
		ifFalse: [ self setCursorToNormal: evt ] 
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> notifyBoundsChanged [

	adapter notifyScrollerBoundsChanged: (self left )@(self right).
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> notifyScrollBarValue: aFloat [

	adapter scrollTo: aFloat smooth: false.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> onResized [
	self setWidthAfterResizing.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> onScrolled: scrolledAnnouncement [

	"directly scrolls to value"
	self scrollTo: scrolledAnnouncement value smooth: scrolledAnnouncement smooth.
]

{ #category : #'as yet unclassified' }
GLMSlidingScrollMorph >> resizeCursor [

	^ Cursor resizeForEdge: #left
]

{ #category : #drawing }
GLMSlidingScrollMorph >> resizeImage: anImage scale: aScale [

	^ GLMForm scalePatchForm: anImage size: (aScale * anImage extent)
]

{ #category : #scrolling }
GLMSlidingScrollMorph >> scrollTo: aValue smooth: aBoolean [

	aBoolean
		ifTrue: [ self glmAnimateValue: aValue duration: 200 ]
		ifFalse: [ self leftTo: aValue ] 
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
	
	left := (adapter circleButtonInset + adapter circleButtonSize) * (adapter firstVisiblePageIndex - 1).
	right := left + self computeWidth.
	
	self layoutFrame: (
		LayoutFrame 
			fractions: (0 @ 0 corner: 0 @ 0)
			offsets: (left @ 0 corner: right @ self height)
	).
	
	adapter notifyScrollerBoundsChanged: (owner left + left )@(owner left + right).
]
