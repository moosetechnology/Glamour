Class {
	#name : #GLMPagerPageModel,
	#superclass : #Object,
	#instVars : [
		'numberOfVisiblePages',
		'announcer',
		'firstVisiblePageIndex',
		'pagesCount',
		'lastVisiblePageIndex'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #accessing }
GLMPagerPageModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'as yet unclassified' }
GLMPagerPageModel >> circleButtonInset [
	^ 6
]

{ #category : #'as yet unclassified' }
GLMPagerPageModel >> circleButtonSize [
	^ 16
]

{ #category : #accessing }
GLMPagerPageModel >> defaultFirstVisiblePageIndex [
	^ 1
]

{ #category : #accessing }
GLMPagerPageModel >> defaultNumberOfVisiblePages [
	^ 2
]

{ #category : #accessing }
GLMPagerPageModel >> firstVisiblePageIndex [
	^ firstVisiblePageIndex
]

{ #category : #accessing }
GLMPagerPageModel >> firstVisiblePageIndex: aNumber [
	aNumber < 1 ifTrue: [ 
		firstVisiblePageIndex := 1.
		^ self ].
	aNumber > self pagesCount ifTrue: [ 
		firstVisiblePageIndex := self pagesCount.
		^ self].
	firstVisiblePageIndex := aNumber.
]

{ #category : #initialization }
GLMPagerPageModel >> initialize [
	super initialize.

	pagesCount := 0.
	self numberOfVisiblePages: self defaultNumberOfVisiblePages.
	
	firstVisiblePageIndex:= self defaultFirstVisiblePageIndex.
	lastVisiblePageIndex:= firstVisiblePageIndex.
]

{ #category : #accessing }
GLMPagerPageModel >> lastVisiblePageIndex [
	| lastIndex |
	
	lastIndex := self firstVisiblePageIndex + self numberOfVisiblePages - 1.
	^ lastIndex > self pagesCount
		ifTrue: [ self pagesCount ]
		ifFalse: [ lastIndex ]
]

{ #category : #accessing }
GLMPagerPageModel >> lastVisiblePageIndex: aNumber [
	aNumber < 1 ifTrue: [ aNumber := 1 ].
	aNumber > self pagesCount ifTrue: [ aNumber := self pagesCount ].
	lastVisiblePageIndex := aNumber.
	
	lastVisiblePageIndex < firstVisiblePageIndex ifTrue: [
		lastVisiblePageIndex := firstVisiblePageIndex ]
]

{ #category : #'as yet unclassified' }
GLMPagerPageModel >> notifyNumberOfVisiblePagesChanged [

	self announcer announce: GLMNumberOfVisiblePagesChanged new.
]

{ #category : #'as yet unclassified' }
GLMPagerPageModel >> notifyPagePoped [

	self announcer announce: GLMPagePoped new.
]

{ #category : #'as yet unclassified' }
GLMPagerPageModel >> notifyPagePushed: aMorph scrollTo: aBoolean smooth: isSmooth [
	
	self announcer announce: (GLMPagePushed new morph: aMorph).
	
	aBoolean ifTrue: [self scrollToRight: isSmooth ]
]

{ #category : #'as yet unclassified' }
GLMPagerPageModel >> notifyPageSwitched: isSmooth [
	self announcer announce: (GLMPageSwitched new smooth: isSmooth).
]

{ #category : #'as yet unclassified' }
GLMPagerPageModel >> notifyScrollerBoundsChanged: aBounds [
	self announcer announce: (GLMPagerBoundsChanged new bounds: aBounds).
]

{ #category : #accessing }
GLMPagerPageModel >> numberOfVisiblePages [
	^ numberOfVisiblePages
]

{ #category : #accessing }
GLMPagerPageModel >> numberOfVisiblePages: aNumber [
	numberOfVisiblePages := aNumber.
]

{ #category : #'as yet unclassified' }
GLMPagerPageModel >> numberOfVisiblePagesChanged [
	|currentNumberOfVisiblePages|
	
	currentNumberOfVisiblePages := lastVisiblePageIndex - self firstVisiblePageIndex + 1.
	
	self numberOfVisiblePages = currentNumberOfVisiblePages ifFalse: [
		self numberOfVisiblePages: 	currentNumberOfVisiblePages.
		self notifyNumberOfVisiblePagesChanged.
	]
]

{ #category : #accessing }
GLMPagerPageModel >> pagesCount [
	^ pagesCount
]

{ #category : #panes }
GLMPagerPageModel >> popAndReplacePane: aMorph [
	self popPane.
	self pushPane: aMorph smooth: false.
	self notifyPageSwitched: false.
]

{ #category : #panes }
GLMPagerPageModel >> popPane [
	pagesCount >= 1 ifTrue: [
		|scrollTo|
		pagesCount := pagesCount - 1.
		scrollTo := ((pagesCount = self firstVisiblePageIndex) & (pagesCount > self numberOfVisiblePages)).
		self notifyPagePoped.
		false ifTrue: [ self scrollToRight: true ].
	]
]

{ #category : #panes }
GLMPagerPageModel >> pushPane: aMorph smooth: aBoolean [

	pagesCount := pagesCount + 1.	
	self notifyPagePushed: aMorph scrollTo: true smooth: aBoolean.
]

{ #category : #scrolling }
GLMPagerPageModel >> scrollTo: aFloat smooth: aBoolean [
	self announcer announce: (GLMPagerScrolled new value: aFloat; smooth: aBoolean).
]

{ #category : #'as yet unclassified' }
GLMPagerPageModel >> scrollToRight: isSmooth [
	self scrollTo: 1.0 smooth: isSmooth
]

{ #category : #panes }
GLMPagerPageModel >> switchPageTo: aNumber [

	aNumber + self numberOfVisiblePages - 1 > self pagesCount
		ifTrue: [ aNumber :=  self pagesCount - self numberOfVisiblePages + 1].
		
	self firstVisiblePageIndex: aNumber.
	self notifyPageSwitched: true.
]
