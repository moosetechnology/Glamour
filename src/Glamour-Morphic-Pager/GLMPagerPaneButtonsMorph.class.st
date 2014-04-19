Class {
	#name : #GLMPagerPaneButtonsMorph,
	#superclass : #Morph,
	#instVars : [
		'adapter',
		'indicatorButtons'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> adapter: anAdapter [
	
	adapter := anAdapter.
		
	adapter announcer weak
		on: GLMPageSwitched send: #onPageSwitched to: self.
				
	adapter announcer weak
		on: GLMPagerBoundsChanged send: #onScrollBoundsChanged: to: self.
		
	adapter announcer weak
		on: GLMFocusedPageChanged send: #onFocusedPageChanged to: self.
		
	self updateIndicatorButtons.
	self cellInset: adapter circleButtonInset.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> buttonCenterByIndex: aNumber [
	|left width|
	width := adapter circleButtonSize.
	left := self bounds left.
	^ left + (adapter circleButtonInset / 2) + ( ( aNumber - 1 ) * (adapter circleButtonInset + width)) + (width / 2).
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> circleButtonClicked: clickedAnnouncement [

	"notify adapter that we need to switch page"
	adapter switchPageTo: clickedAnnouncement buttonModel pageIndex
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> initialize [
	super initialize.
		
	self changeTableLayout;
		changeListDirection: #leftToRight;
		cellPositioning: #center;
		listCentering: #center;
		wrapCentering: #center;
		color: Color transparent.
		
	self hResizing: #shrinkWrap.
	
	
	indicatorButtons := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> markButtonsInside: aBounds [
	|index boundsLeft boundsRight firstFound lastFound |	
	
	firstFound := false.
	lastFound := false.
	index := 0.
	
	(adapter pagesCount = 0) ifTrue: [ ^ self ].
	boundsLeft := aBounds x.
	boundsRight := aBounds y.
	
	indicatorButtons do: [ :indicator |
		|buttonCenter|
		index := index + 1.
		buttonCenter := self buttonCenterByIndex: index.
		(buttonCenter > boundsLeft) & (buttonCenter < boundsRight)
			ifTrue: [
				indicator buttonModel check.
				firstFound ifFalse: [
					adapter firstVisiblePageIndex: index.
					firstFound := true.
				]
			]
			ifFalse: [
				"uncheck only if not focused"
				indicator isFocused ifFalse: [ indicator buttonModel uncheck ].
				(firstFound & (lastFound = false)) ifTrue: [
					adapter lastVisiblePageIndex: index - 1.
					lastFound := true.
				]
			].
	].
	lastFound ifFalse: [
		adapter lastVisiblePageIndex: index.
		lastFound := true.
	]
	
		

]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onFocusedPageChanged [

	self updateIndicatorButtonsFocus.
	self updateIndicatorButtons.

]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onPagePoped [
	|button|
	
	button := indicatorButtons last.
	indicatorButtons removeLast.
	button announcer unsubscribe: self.
	
	self removeMorph: button.
	self updateIndicatorButtons.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onPagePushed: addedAnnouncement [
	|button|
	
	button := GLMPagerCircleButtonMorph new.
	indicatorButtons addLast: button.
	
	button buttonModel: (GLMPagerCircleButtonModel new pageIndex: indicatorButtons size).
	button buttonModel on: GLMPagerButtonClicked send: #circleButtonClicked: to: self.
	button height: adapter circleButtonSize.
	button width: adapter circleButtonSize.
	
	self addMorphBack: button.
	
	(indicatorButtons size = 1) ifTrue: [ self updateIndicatorButtonsFocus ].
		
	self updateIndicatorButtons.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onPageSwitched [

	self updateIndicatorButtons.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onScrollBoundsChanged: boundsChangedAnnouncement [

	self markButtonsInside: boundsChangedAnnouncement bounds.
	
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> updateIndicatorButtons [

	"first we uncheck all buttons"
	indicatorButtons do: [ :indicator |
		"uncheck only if not focused"
		indicator isFocused ifFalse: [ indicator buttonModel uncheck ].
	].

	"then check only necessary"
	indicatorButtons from: adapter firstVisiblePageIndex to: adapter lastVisiblePageIndex do: [ :indicator |
		indicator buttonModel check.
	]
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> updateIndicatorButtonsFocus [

	"unfocus all"
	indicatorButtons do: [ :each |
		 each setNotFocused.
	].

	(indicatorButtons at: adapter focusedPageIndex) setFocused.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> width [
	|width|
	width := adapter isNotNil
		ifTrue: [ (indicatorButtons size * (adapter circleButtonSize + adapter circleButtonInset )) ]
		ifFalse: [ 0 ].
	^ width
]
