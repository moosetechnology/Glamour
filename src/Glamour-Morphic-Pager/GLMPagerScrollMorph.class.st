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
		on: GLMPageSwitched send: #onPageSwitched: to: self.
				
	adapter announcer weak
		on: GLMPagerScrolled send: #onScrolled: to: self.
		
	adapter announcer weak 
		on: GLMNumberOfVisiblePagesChanged send: #onPagesNumberChanged to: self.
		
	adapter announcer weak 
		on: GLMSelectedPageChanged send: #onSelectedPageChanged to: self.
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
GLMPagerScrollMorph >> onPagePushed: pushedAnnouncement [

	"added new page to the end of pane"
	self pushPane: pushedAnnouncement morph.
	
	
	
	

]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onPageSwitched: switchedAnnouncement [

	adapter scrollTo: (self computeScrollValueToPaneByIndex: adapter firstVisiblePageIndex) smooth: switchedAnnouncement smooth.
	
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onPagesNumberChanged [

	self maxPanes: adapter numberOfVisiblePages.
	self basicUpdateSizing.
	self layoutPanes.
	self scrollToPaneByIndex: adapter firstVisiblePageIndex smooth: false.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onScrolled: scrolledAnnouncement [

	"directly scrolls to value"
	self scrollTo: scrolledAnnouncement value smooth: scrolledAnnouncement smooth.
	
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onSelectedPageChanged [
	
	panes do: [ :each | each color: Color white ].
	
	self theme pagerWidgetThemer selectedPaneStyleFor: (panes at: adapter selectedPageIndex)
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
