Class {
	#name : #GLMPagerModel,
	#superclass : #Object,
	#instVars : [
		'numberOfVisiblePages',
		'announcer',
		'firstVisiblePageIndex',
		'pagesCount',
		'lastVisiblePageIndex',
		'focusedPageIndex'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #accessing }
GLMPagerModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GLMPagerModel >> circleButtonInset [
	^ 6
]

{ #category : #accessing }
GLMPagerModel >> circleButtonSize [
	^ 16
]

{ #category : #accessing }
GLMPagerModel >> defaultFirstVisiblePageIndex [
	^ 1
]

{ #category : #accessing }
GLMPagerModel >> defaultNumberOfVisiblePages [
	^ 2
]

{ #category : #panes }
GLMPagerModel >> diminishToLeft [
	self privateLastVisiblePageIndex: (self lastVisiblePageIndex - 1).
	self numberOfVisiblePagesChanged.
]

{ #category : #panes }
GLMPagerModel >> diminishToRight [
	self privateFirstVisiblePageIndex: (self firstVisiblePageIndex + 1).
	self numberOfVisiblePagesChanged.
]

{ #category : #panes }
GLMPagerModel >> enlargeToLeft [
	self privateFirstVisiblePageIndex: (self firstVisiblePageIndex - 1).
	self numberOfVisiblePagesChanged.
]

{ #category : #panes }
GLMPagerModel >> enlargeToRight [
	self privateLastVisiblePageIndex: (self lastVisiblePageIndex + 1).
	self numberOfVisiblePagesChanged.
]

{ #category : #accessing }
GLMPagerModel >> firstVisiblePageIndex [
	^ firstVisiblePageIndex
]

{ #category : #panes }
GLMPagerModel >> focusToLeft [
	"moves focus to left"
	self focusedPageIndex: (self focusedPageIndex - 1).
]

{ #category : #panes }
GLMPagerModel >> focusToRight [
	"moves focus to right"
	self focusedPageIndex: (self focusedPageIndex + 1).
]

{ #category : #accessing }
GLMPagerModel >> focusedPageIndex [
	^ focusedPageIndex
]

{ #category : #accessing }
GLMPagerModel >> focusedPageIndex: anIndex [
	
	anIndex < 1 ifTrue: [ anIndex := 1 ].
	anIndex > self pagesCount ifTrue: [ anIndex := self pagesCount ].
	
	(self focusedPageIndex = anIndex) not ifTrue:[
		focusedPageIndex := anIndex.
		
		(self isPaneVisible: focusedPageIndex) ifFalse: [ 
			"we need to scroll if new focused page is invisible"
			focusedPageIndex < self firstVisiblePageIndex
				ifTrue: [ self switchPageTo: focusedPageIndex ]
				ifFalse: [ self switchPageTo: (focusedPageIndex - self numberOfVisiblePages + 1) ]
		].
		
		self notifyFocusedPageChanged.
	].
	
]

{ #category : #initialization }
GLMPagerModel >> initialize [
	super initialize.

	pagesCount := 0.
	focusedPageIndex := 1.
	numberOfVisiblePages := self defaultNumberOfVisiblePages.
	
	firstVisiblePageIndex:= self defaultFirstVisiblePageIndex.
	lastVisiblePageIndex:= firstVisiblePageIndex.
]

{ #category : #panes }
GLMPagerModel >> isPaneVisible: aNumber [
	^ (aNumber >= self firstVisiblePageIndex) & (aNumber <= self lastVisiblePageIndex)
]

{ #category : #accessing }
GLMPagerModel >> lastVisiblePageIndex [
	| lastIndex |
	
	lastIndex := self firstVisiblePageIndex + self numberOfVisiblePages - 1.
	^ lastIndex > self pagesCount
		ifTrue: [ self pagesCount ]
		ifFalse: [ lastIndex ]
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> notifyFocusedPageChanged [

	self announcer announce: GLMFocusedPageChanged new.
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> notifyNumberOfVisiblePagesChanged [

	self announcer announce: GLMNumberOfVisiblePagesChanged new.
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> notifyPagePoped [

	self announcer announce: GLMPagePoped new.
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> notifyPagePushed: aMorph scrollTo: aBoolean smooth: isSmooth [
	
	self announcer announce: (GLMPagePushed new morph: aMorph).
	
	aBoolean ifTrue: [self scrollToRight: isSmooth ]
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> notifyPageSwitched: isSmooth [
	self announcer announce: (GLMPageSwitched new smooth: isSmooth).
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> notifyScrollerBoundsChanged: aBounds [
	self announcer announce: (GLMPagerBoundsChanged new bounds: aBounds).
]

{ #category : #accessing }
GLMPagerModel >> numberOfVisiblePages [
	^ numberOfVisiblePages
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> numberOfVisiblePagesChanged [
	"recalculates numberOfVisiblePages based on last and first visible index
		and notifies observers if number was changed
		returns true if changed, otherwise false
		"
	|currentNumberOfVisiblePages|
	
	currentNumberOfVisiblePages := lastVisiblePageIndex - self firstVisiblePageIndex + 1.
	
	self numberOfVisiblePages = currentNumberOfVisiblePages
	ifFalse: [
		numberOfVisiblePages := currentNumberOfVisiblePages.
		self notifyNumberOfVisiblePagesChanged.
		^ true
	]
	ifTrue: [ ^ false ].
	
	
]

{ #category : #accessing }
GLMPagerModel >> pagesCount [
	^ pagesCount
]

{ #category : #panes }
GLMPagerModel >> popAndReplacePane: aMorph [
	
	self popPane.
	self pushPane: aMorph smooth: false.
	self notifyPageSwitched: false.
]

{ #category : #panes }
GLMPagerModel >> popPane [

	pagesCount >= 1 ifTrue: [
		|scrollTo|
		pagesCount := pagesCount - 1.
		scrollTo := ((pagesCount = self firstVisiblePageIndex) & (pagesCount > self numberOfVisiblePages)).
		self notifyPagePoped.
		false ifTrue: [ self scrollToRight: true ].
	]
]

{ #category : #private }
GLMPagerModel >> privateFirstVisiblePageIndex: aNumber [
	"private, don't use it as public api, because model will be in illegal state"
	
	aNumber > lastVisiblePageIndex ifTrue: [ aNumber := lastVisiblePageIndex ].
	aNumber < 1 ifTrue: [ aNumber := 1 ].
	aNumber > self pagesCount ifTrue: [ aNumber := self pagesCount ].
	
	firstVisiblePageIndex := aNumber.
]

{ #category : #private }
GLMPagerModel >> privateLastVisiblePageIndex: aNumber [
	"private, don't use it as public api, because model will be in illegal state"
	
	aNumber < self firstVisiblePageIndex ifTrue: [ aNumber := self firstVisiblePageIndex ].
	aNumber < 1 ifTrue: [ aNumber := 1 ].
	aNumber > self pagesCount ifTrue: [ aNumber := self pagesCount ].
	
	lastVisiblePageIndex := aNumber.
	
	lastVisiblePageIndex < firstVisiblePageIndex ifTrue: [
		lastVisiblePageIndex := firstVisiblePageIndex ]
]

{ #category : #panes }
GLMPagerModel >> pushPane: aMorph smooth: aBoolean [

	pagesCount := pagesCount + 1.	
	self notifyPagePushed: aMorph scrollTo: true smooth: aBoolean.
]

{ #category : #scrolling }
GLMPagerModel >> scrollTo: aFloat smooth: aBoolean [
	self announcer announce: (GLMPagerScrolled new value: aFloat; smooth: aBoolean).
]

{ #category : #panes }
GLMPagerModel >> scrollToRight: isSmooth [
	"scrolls to the most right"

	self scrollTo: 1.0 smooth: isSmooth
]

{ #category : #panes }
GLMPagerModel >> switchPageTo: aNumber [
	"accepts any garbage number, but can't scroll away from real bounds"
	
	aNumber + self numberOfVisiblePages - 1 > self pagesCount
		ifTrue: [ aNumber :=  self pagesCount - self numberOfVisiblePages + 1].
	
	lastVisiblePageIndex := aNumber + self numberOfVisiblePages.
	self privateFirstVisiblePageIndex: aNumber.
	"true means scrolling is smooth"
	self notifyPageSwitched: true.
]
