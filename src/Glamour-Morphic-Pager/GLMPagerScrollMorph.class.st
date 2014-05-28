Class {
	#name : #GLMPagerScrollMorph,
	#superclass : #GLMPageScroller,
	#instVars : [
		'pane',
		'adapter',
		'currentFocus'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> adapter: anAdapter [
	
	adapter := anAdapter.
	
	adapter announcer weak
		on: GLMPagePushed send: #onPagePushed: to: self.
	
	adapter announcer weak
		on: GLMPagePoped send: #onPagePoped to: self.
						
	adapter announcer weak
		on: GLMPagerSynchronizeScrollAnnouncement send: #onSynchronizeScroll: to: self.
		
	adapter announcer weak 
		on: GLMPagerScrollPositionChanged send: #onScrollPositionChanged: to: self.
		
	adapter announcer weak 
		on: GLMNumberOfVisiblePagesChanged send: #onPagesNumberChanged to: self.
		
	adapter announcer weak 
		on: GLMSelectedPageChanged send: #onSelectedPageChanged to: self.
		
	adapter announcer weak 
		on: GLMPagerPreviewUpdate send: #onPagePreviewUpdate: to: self.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> focusChanged: anEvent [
	| pageIndex newFocus |
	
	newFocus := anEvent morph.
	
	currentFocus = newFocus ifFalse: [
		currentFocus := newFocus.
		pageIndex := self pageOf: newFocus.
	
		(pageIndex > 0) ifTrue: [
			adapter focusedMorphChanged: newFocus at: pageIndex.
		]
	]
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> initialize [
	super initialize.
	
	self color: Color transparent.
	
	Morph announcer weak 
		on: MorphGotFocus send: #focusChanged: to: self.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onPagePoped [
	self popPane.
	
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onPagePreviewUpdate: updateAnnouncement [

	GLMPagerPanePreviewMorph uniqueInstance updateFor: (self paneAt: updateAnnouncement pageIndex).
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onPagePushed: pushedAnnouncement [

	"added new page to the end of pane"
	self pushPane: pushedAnnouncement morph.
	
	
	
	

]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onPagesNumberChanged [

	self maxPanes: adapter numberOfVisiblePages.
	self basicUpdateSizing.
	self layoutPanes.
	self scrollToPane: adapter firstVisiblePageIndex smooth: false.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onScrollPositionChanged: announcement [

	self scrollToPane: adapter firstVisiblePageIndex smooth: announcement smooth.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onSelectedPageChanged [
	
	panes do: [ :each | each borderColor: Color transparent ].
	
	self theme pagerWidgetThemer selectedPaneStyleFor: (panes at: adapter selectedPageIndex)
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onSynchronizeScroll: announcement [

	"directly scrolls to value"
	self scrollTo: announcement value smooth: false.
	
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> outOfWorld: aWorld [

	Morph announcer unsubscribe: self.
	^ super outOfWorld: aWorld.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> pageOf: aSubMorph [
	"returns 0 if morph is not in pager"
	|parent page|	
	
	aSubMorph ifNil: [ ^ 0 ].
	
	parent := aSubMorph.
	
	[parent isNotNil & ((parent == transform) not) ] whileTrue: [
		page := parent.
		parent := parent owner.
	].
	
	^ parent isNil ifTrue: [ 0 ] ifFalse: [ panes indexOf: page. ].
	
]

{ #category : #scrolling }
GLMPagerScrollMorph >> scrollTo: aValue smooth: isSmooth [

 	isSmooth ifTrue: [	self glmAnimateValue: aValue duration: 200]
				ifFalse: [self scrollValue: aValue ].
]

{ #category : #scrolling }
GLMPagerScrollMorph >> scrollToPane: anIndex smooth: isSmooth [

	self scrollTo: (adapter convertIndexToValue: anIndex) smooth: isSmooth.
]
