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
GLMPagerScrollMorph >> addFocusHandlerTo: aMorph [

	aMorph ifNotNil: [	
		aMorph announcer weak
			on: MorphGotFocus send: #focusChanged: to: self.
		
		aMorph submorphs do: [ :each |
			self addFocusHandlerTo: each.
		].
	].
	
	
]

{ #category : #'as yet unclassified' }
GLMPagerScrollMorph >> focusChanged: anEvent [

	adapter focusedPageIndex: (self pageOf: anEvent morph).
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
	|morph |
	
	morph := pushedAnnouncement morph.
	
	"added new page to the end of pane"
	self pushPane: morph.
	
	self addFocusHandlerTo: morph.
	
	
	
	

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
GLMPagerScrollMorph >> pageOf: aSubMorph [
	|parent|
	
	parent := aSubMorph.
	
	[parent isNotNil & (panes includes: parent) not ] whileTrue: [
		parent := parent owner.
	].

	^ panes indexOf: parent.
]
