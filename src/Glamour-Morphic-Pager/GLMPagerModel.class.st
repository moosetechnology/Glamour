Class {
	#name : #GLMPagerModel,
	#superclass : #Object,
	#instVars : [
		'numberOfVisiblePages',
		'announcer',
		'firstVisiblePageIndex',
		'pagesCount',
		'lastVisiblePageIndex',
		'selectedPageIndex',
		'focusedMorphs',
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

{ #category : #focus }
GLMPagerModel >> focusedMorph: aMorph at: paneIndex [

	focusedMorphs at: paneIndex put: aMorph.
]

{ #category : #focus }
GLMPagerModel >> focusedMorphAt: pageIndex [
	
	^ focusedMorphs at: pageIndex ifAbsent: [ nil ]
]

{ #category : #focus }
GLMPagerModel >> focusedMorphChanged: aMorph at: pageIndex [
	
	focusedPageIndex := pageIndex.
	self focusedMorph: aMorph at: pageIndex.
	
	self selectedPageIndex: pageIndex.
	self notifyFocusedPageChanged.
]

{ #category : #accessing }
GLMPagerModel >> focusedPageIndex [
	^ focusedPageIndex
]

{ #category : #initialization }
GLMPagerModel >> initialize [
	super initialize.

	pagesCount := 0.
	selectedPageIndex := 0.
	focusedMorphs := Dictionary new.
	
	numberOfVisiblePages := self defaultNumberOfVisiblePages.
	
	firstVisiblePageIndex:= self defaultFirstVisiblePageIndex.
	lastVisiblePageIndex:= firstVisiblePageIndex.
]

{ #category : #focus }
GLMPagerModel >> isFocusedMorphVisibleAt: paneIndex [
	|morph|
	
	morph := self focusedMorphAt: paneIndex.
	morph ifNil: [ ^ false ].
	^ morph isInWorld.
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
GLMPagerModel >> notifyPageSwitched: pageIndex smooth: isSmooth [
	self announcer announce: (GLMPageSwitched new smooth: isSmooth; pageIndex: pageIndex; yourself).
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> notifyScrollerBoundsChanged: aBounds [
	self announcer announce: (GLMPagerBoundsChanged new bounds: aBounds).
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> notifySelectedPageChanged [

	self announcer announce: GLMSelectedPageChanged new.
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
	self notifyPageSwitched: (self pagesCount - 1) smooth: false.
]

{ #category : #panes }
GLMPagerModel >> popPane [

	pagesCount >= 1 ifTrue: [
		|scrollTo|
		
		focusedMorphs removeKey: pagesCount  ifAbsent: [ true ].
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
GLMPagerModel >> selectToLeft [
	"moves focus to left"
	self selectedPageIndex: (self selectedPageIndex - 1).
]

{ #category : #panes }
GLMPagerModel >> selectToRight [
	"moves focus to right"
	self selectedPageIndex: (self selectedPageIndex + 1).
]

{ #category : #accessing }
GLMPagerModel >> selectedPageIndex [
	^ selectedPageIndex
]

{ #category : #accessing }
GLMPagerModel >> selectedPageIndex: anIndex [
	
	anIndex < 1 ifTrue: [ anIndex := 1 ].
	anIndex > self pagesCount ifTrue: [ anIndex := self pagesCount ].
	
	(self selectedPageIndex = anIndex) not ifTrue: [
		
		(self isPaneVisible: anIndex) ifFalse: [
			"we need to scroll if new focused page is invisible"
			anIndex < self firstVisiblePageIndex
				ifTrue: [
					self switchPageTo: anIndex updateFocus: true updateSelection: true
				]
				ifFalse: [
					self switchPageTo: (anIndex - self numberOfVisiblePages + 1) updateFocus: false updateSelection: false.
					self updateFocus: anIndex.
				].
			^ self.
		].
	
		selectedPageIndex  := anIndex.
		self updateFocus: anIndex.	
		self notifySelectedPageChanged.
	].
	
]

{ #category : #'as yet unclassified' }
GLMPagerModel >> switchPageTo: aNumber updateFocus: isUpdateFocus updateSelection: isUpdateSelection [
	"accepts any garbage number, but can't scroll away from real bounds"
	|pageIndex|
	pageIndex := aNumber.
	
	aNumber + self numberOfVisiblePages - 1 > self pagesCount
		ifTrue: [ aNumber :=  self pagesCount - self numberOfVisiblePages + 1].
	
	lastVisiblePageIndex := aNumber + self numberOfVisiblePages.
	self privateFirstVisiblePageIndex: aNumber.
	
	"true means scrolling is smooth"
	self notifyPageSwitched: pageIndex smooth: true.
	
	"update focus if true"
	isUpdateFocus ifTrue: [ self updateFocus: pageIndex ].
	
	"update selected pane if true"
	isUpdateSelection ifTrue: [
		selectedPageIndex := pageIndex.
		self notifySelectedPageChanged
	].
]

{ #category : #focus }
GLMPagerModel >> updateFocus: pageIndex [
	
	( self isFocusedMorphVisibleAt: pageIndex ) ifTrue: [
		focusedPageIndex := pageIndex.
		(self focusedMorphAt: pageIndex) activeHand newKeyboardFocus: (self focusedMorphAt: pageIndex).
		self notifyFocusedPageChanged.
	].
]
