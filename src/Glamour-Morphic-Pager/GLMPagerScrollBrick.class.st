Class {
	#name : #GLMPagerScrollBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'band',
		'currentFocus',
		'pagerModel',
		'maxPanes',
		'focus',
		'currentScrollDelta'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #accessing }
GLMPagerScrollBrick >> band [

	^ band
]

{ #category : #accessing }
GLMPagerScrollBrick >> band: aBrick [

	band := aBrick.
	band layoutPolicy: GLMPagerBandLayout new.
	band width: [ :bandBrick | (self width / (self maxPanes min: self band subbricksCount) + self paneMargin) * self band subbricksCount ].
	
	self addBrickBack: band.
]

{ #category : #scrolling }
GLMPagerScrollBrick >> convertScrollValue: aFloat [
		
	^ (self width - ((self width / self pagerModel actualNumberOfVisiblePages + self paneMargin) * self band subbricksCount)) * aFloat
]

{ #category : #accessing }
GLMPagerScrollBrick >> doLayout [
	
	currentScrollDelta := self convertScrollValue: (self pagerModel convertIndexToValue: self pagerModel firstVisiblePageIndex).
	super doLayout
]

{ #category : #'event-handling' }
GLMPagerScrollBrick >> focusChanged: anEvent [
	| pageIndex newFocus |
	
	newFocus := anEvent morph.
	
	currentFocus = newFocus ifFalse: [
		currentFocus := newFocus.
		pageIndex := self pageOf: newFocus.
	
		(pageIndex > 0) ifTrue: [
			pagerModel focusedMorphChanged: newFocus at: pageIndex.
		]
	]
]

{ #category : #scrolling }
GLMPagerScrollBrick >> glmAnimateValue: aValue duration: anInteger [

	self glmAnimateValue: aValue duration: anInteger callback: nil.
]

{ #category : #scrolling }
GLMPagerScrollBrick >> glmAnimateValue: aValue duration: anInteger callback: aBlock [

	anInteger <= 0
		"if duration is zero, move to the left immediately"
		ifTrue: [ self leftTo: aValue ]
		ifFalse: [
			| startTime start finish currentValue |
			currentValue := self scrollValue.
			startTime := Time millisecondClockValue.
			start := currentValue.
			finish := self convertScrollValue: aValue.
			[ | delta |
				[ (delta := Time millisecondClockValue - startTime) < anInteger ] whileTrue: [
					self scrollValue: (finish - start) * (delta / anInteger) + start.
					Processor yield.
				].
				self scrollValue: finish.
				Processor yield.
				aBlock ifNotNil: [ aBlock value ].
			] fork
		]
]

{ #category : #initialization }
GLMPagerScrollBrick >> initialize [
	super initialize.
	
	focus := Dictionary new.
	currentScrollDelta := 0.
	maxPanes := 2.
	
	self layoutPolicy: (GLMPagerLayout new).
	
	self band: self newBand.
	
	Morph announcer weak 
		when: MorphGotFocus send: #focusChanged: to: self.
]

{ #category : #accessing }
GLMPagerScrollBrick >> lastPane [

	self subbricksCount = 0 ifTrue: [ ^ nil ].
	^ self panes last.
]

{ #category : #accessing }
GLMPagerScrollBrick >> maxPanes [
	^ maxPanes
]

{ #category : #accessing }
GLMPagerScrollBrick >> maxPanes: anInteger [
	maxPanes := anInteger
]

{ #category : #'instance creation' }
GLMPagerScrollBrick >> newBand [

	^ GLMBrick new
]

{ #category : #'event-handling' }
GLMPagerScrollBrick >> onPagePoped: popedAnnouncement [
	self popPane: popedAnnouncement smooth.
]

{ #category : #'event-handling' }
GLMPagerScrollBrick >> onPagePreviewUpdate: updateAnnouncement [

	GLMPagerPanePreviewMorph uniqueInstance updateFor: (self paneAt: updateAnnouncement pageIndex).
]

{ #category : #'event-handling' }
GLMPagerScrollBrick >> onPagePushed: pushedAnnouncement [

	"added new page to the end of pane"
	self pushPane: pushedAnnouncement morph.
	
	
	
	

]

{ #category : #'event-handling' }
GLMPagerScrollBrick >> onPagesNumberChanged [

	self maxPanes: pagerModel numberOfVisiblePages.
	self doLayout.
	self changed.
	self scrollToPane: pagerModel firstVisiblePageIndex smooth: false.
	
]

{ #category : #'event-handling' }
GLMPagerScrollBrick >> onScrollPositionChanged: announcement [

	self scrollToPane: pagerModel firstVisiblePageIndex smooth: announcement smooth callback: announcement callback
]

{ #category : #'event-handling' }
GLMPagerScrollBrick >> onSelectedPageChanged [
	
	self panes do: [ :each | each borderColor: Color transparent ].
	
	self theme pagerWidgetThemer selectedPaneStyleFor: (self panes at: pagerModel selectedPageIndex)
]

{ #category : #'event-handling' }
GLMPagerScrollBrick >> onSynchronizeScroll: announcement [

	"directly scrolls to value"
	self scrollTo: announcement value smooth: false
]

{ #category : #initialize }
GLMPagerScrollBrick >> outOfWorld: aWorld [

	Morph announcer unsubscribe: self.
	^ super outOfWorld: aWorld.
]

{ #category : #accessing }
GLMPagerScrollBrick >> pageOf: aSubMorph [
	"returns 0 if morph is not in pager"
	|parent page|	
	
	aSubMorph ifNil: [ ^ 0 ].
	
	parent := aSubMorph.
	
	[parent isNotNil & ((parent == self band) not) ] whileTrue: [
		page := parent.
		parent := parent owner.
	].
	
	^ parent isNil ifTrue: [ 0 ] ifFalse: [ self panes indexOf: page. ].
	
]

{ #category : #accessing }
GLMPagerScrollBrick >> pagerModel [

	^ pagerModel
]

{ #category : #accessing }
GLMPagerScrollBrick >> pagerModel: aModel [
	
	pagerModel := aModel.
	maxPanes := aModel numberOfVisiblePages.
	
	pagerModel announcer weak
		when: GLMPagePushed send: #onPagePushed: to: self.
	
	pagerModel announcer weak
		when: GLMPagePoped send: #onPagePoped: to: self.
						
	pagerModel announcer weak
		when: GLMPagerSynchronizeScrollAnnouncement send: #onSynchronizeScroll: to: self.
		
	pagerModel announcer weak 
		when: GLMPagerScrollPositionChanged send: #onScrollPositionChanged: to: self.
		
	pagerModel announcer weak 
		when: GLMNumberOfVisiblePagesChanged send: #onPagesNumberChanged to: self.
		
	pagerModel announcer weak 
		when: GLMSelectedPageChanged send: #onSelectedPageChanged to: self.
		
	pagerModel announcer weak 
		when: GLMPagerPreviewUpdate send: #onPagePreviewUpdate: to: self.
]

{ #category : #accessing }
GLMPagerScrollBrick >> paneAt: anIndex [
	^ self panes at: anIndex.
]

{ #category : #accessing }
GLMPagerScrollBrick >> paneMargin [

	^ 1
]

{ #category : #accessing }
GLMPagerScrollBrick >> panes [

	^ self band submorphs
]

{ #category : #api }
GLMPagerScrollBrick >> popPane [
	
	self band removeBrick: (self band lastSubbrick).
	self updatePanes.
]

{ #category : #api }
GLMPagerScrollBrick >> popPane: isSmooth [

	(isSmooth not or: [self lastPane isNil]) ifTrue: [ ^ self popPane ].
	
	self band removeBrick: (self band lastSubbrick).
	self scrollTo: (pagerModel convertIndexToValue: pagerModel firstVisiblePageIndex with: self band subbricksCount) smooth: true callback: [ self updatePanes ]
]

{ #category : #api }
GLMPagerScrollBrick >> pushPane: aMorph [	
	|brick|
	
	brick := aMorph.
	brick layoutProperties: (GLMBrickLayoutProperties new).
	brick layoutProperties marginLeft: self paneMargin.
	brick layoutProperties marginRight: self paneMargin.
	
	self band addBrickBack: brick.
	self updatePanes
]

{ #category : #scrolling }
GLMPagerScrollBrick >> scrollTo: aValue smooth: isSmooth [

 	self scrollTo: aValue smooth: isSmooth callback: nil 
]

{ #category : #scrolling }
GLMPagerScrollBrick >> scrollTo: aValue smooth: isSmooth callback: aBlock [
	
 	isSmooth ifTrue: [ self glmAnimateValue: aValue duration: 300 callback: aBlock ]
				ifFalse: [ self scrollValue: (self convertScrollValue: aValue). aBlock value ].
]

{ #category : #scrolling }
GLMPagerScrollBrick >> scrollToPane: anIndex smooth: isSmooth [

	self scrollToPane: anIndex smooth: isSmooth callback: nil
]

{ #category : #scrolling }
GLMPagerScrollBrick >> scrollToPane: anIndex smooth: isSmooth callback: aBlock [

	self scrollTo: (pagerModel convertIndexToValue: anIndex) smooth: isSmooth callback: aBlock.
]

{ #category : #accessing }
GLMPagerScrollBrick >> scrollValue [

	^ currentScrollDelta
]

{ #category : #scrolling }
GLMPagerScrollBrick >> scrollValue: value [
	
	currentScrollDelta := value.
	
	self updatePanes
]

{ #category : #scrolling }
GLMPagerScrollBrick >> updatePanes [

	self layoutPolicy layout: self in: nil.
	self band layoutPolicy layout: self band in: nil.
	
	self changed
]
