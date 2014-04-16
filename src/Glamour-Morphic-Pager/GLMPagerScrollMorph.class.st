Class {
	#name : #GLMPagerScrollMorph,
	#superclass : #GLMPageScroller,
	#instVars : [
		'pane',
		'adapter'
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
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> initialize [
	super initialize.
	
	self color: Color transparent.
	

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
	self setScrollDeltas.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> onScrolled: scrolledAnnouncement [

	"directly scrolls to value"
	self scrollTo: scrolledAnnouncement value smooth: scrolledAnnouncement smooth.
	
]
