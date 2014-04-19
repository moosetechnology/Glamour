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

{ #category : #'as yet unclassified' }
GLMPagerModel >> circleButtonInset [
	^ 6
]

{ #category : #'as yet unclassified' }
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

{ #category : #accessing }
GLMPagerModel >> firstVisiblePageIndex [
	^ firstVisiblePageIndex
]

{ #category : #accessing }
GLMPagerModel >> firstVisiblePageIndex: aNumber [
	aNumber < 1 ifTrue: [ 
		firstVisiblePageIndex := 1.
		^ self ].
	aNumber > self pagesCount ifTrue: [ 
		firstVisiblePageIndex := self pagesCount.
		^ self].
	firstVisiblePageIndex := aNumber.
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> focusedPageIndex [
	^ focusedPageIndex
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> focusedPageIndex: anIndex [

	(self focusedPageIndex = anIndex) not ifTrue:[
		focusedPageIndex := anIndex.
		self notifyFocusedPageChanged.
	].
	
]

{ #category : #initialization }
GLMPagerModel >> initialize [
	super initialize.

	pagesCount := 0.
	focusedPageIndex := 1.
	self numberOfVisiblePages: self defaultNumberOfVisiblePages.
	
	firstVisiblePageIndex:= self defaultFirstVisiblePageIndex.
	lastVisiblePageIndex:= firstVisiblePageIndex.
]

{ #category : #accessing }
GLMPagerModel >> lastVisiblePageIndex [
	| lastIndex |
	
	lastIndex := self firstVisiblePageIndex + self numberOfVisiblePages - 1.
	^ lastIndex > self pagesCount
		ifTrue: [ self pagesCount ]
		ifFalse: [ lastIndex ]
]

{ #category : #accessing }
GLMPagerModel >> lastVisiblePageIndex: aNumber [
	aNumber < 1 ifTrue: [ aNumber := 1 ].
	aNumber > self pagesCount ifTrue: [ aNumber := self pagesCount ].
	lastVisiblePageIndex := aNumber.
	
	lastVisiblePageIndex < firstVisiblePageIndex ifTrue: [
		lastVisiblePageIndex := firstVisiblePageIndex ]
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

{ #category : #accessing }
GLMPagerModel >> numberOfVisiblePages: aNumber [
	numberOfVisiblePages := aNumber.
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> numberOfVisiblePagesChanged [
	|currentNumberOfVisiblePages|
	
	currentNumberOfVisiblePages := lastVisiblePageIndex - self firstVisiblePageIndex + 1.
	
	self numberOfVisiblePages = currentNumberOfVisiblePages ifFalse: [
		self numberOfVisiblePages: 	currentNumberOfVisiblePages.
		self notifyNumberOfVisiblePagesChanged.
	]
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

{ #category : #panes }
GLMPagerModel >> pushPane: aMorph smooth: aBoolean [

	pagesCount := pagesCount + 1.	
	self notifyPagePushed: aMorph scrollTo: true smooth: aBoolean.
]

{ #category : #scrolling }
GLMPagerModel >> scrollTo: aFloat smooth: aBoolean [
	self announcer announce: (GLMPagerScrolled new value: aFloat; smooth: aBoolean).
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> scrollToRight: isSmooth [
	self scrollTo: 1.0 smooth: isSmooth
]

{ #category : #panes }
GLMPagerModel >> switchPageTo: aNumber [

	aNumber + self numberOfVisiblePages - 1 > self pagesCount
		ifTrue: [ aNumber :=  self pagesCount - self numberOfVisiblePages + 1].
		
	self firstVisiblePageIndex: aNumber.
	self notifyPageSwitched: true.
]
