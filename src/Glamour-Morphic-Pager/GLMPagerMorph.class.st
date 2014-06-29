Class {
	#name : #GLMPagerMorph,
	#superclass : #Morph,
	#instVars : [
		'adapter',
		'firstCombination',
		'pagerBar'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerMorph class >> simpleExample [
	|pager adapter|
	adapter := GLMPagerModel new.
	pager :=	GLMPagerMorph new.
	pager adapter: adapter.
	
	pager pushPane: (Morph new color: Color red).
	pager pushPane: (Morph new color: Color green).
	pager pushPane: (Morph new color: Color yellow).
	pager pushPane: (Morph new color: Color blue).
	pager pushPane: (Morph new color: Color pink).
	
	pager height: 600.
	pager width: 1024.
	pager openInWindow.
	
	"pager inspect."
]

{ #category : #accessing }
GLMPagerMorph >> adapter [
	^ adapter
]

{ #category : #accessing }
GLMPagerMorph >> adapter: anObject [
	adapter := anObject.
	
	self addMorphBack: (GLMPagerScrollMorph new adapter: adapter).
	
	pagerBar := GLMPagerBarMorph new adapter: adapter.
	
	adapter announcer weak
		on: GLMPagePushed send: #onPagePushed to: self.
		
	adapter announcer weak
		on: GLMPagePoped send: #onPagePoped to: self.
	
	self initializeShortcuts.
]

{ #category : #initialization }
GLMPagerMorph >> initialColorInSystemWindow: aSystemWindow [
	"Answer the colour the receiver should be when added to a SystemWindow."

	^ Color transparent
]

{ #category : #initialization }
GLMPagerMorph >> initialize [
	super initialize.
	self changeTableLayout;
		changeListDirection: #topToBottom;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		cellPositioning: #center;
		listCentering: #center;
		wrapCentering: #center
]

{ #category : #initialization }
GLMPagerMorph >> initializeShortcuts [

	self bindKeyCombination: Character arrowLeft alt command toAction: [ adapter selectToLeft ].
	self bindKeyCombination: Character arrowRight alt command toAction: [ adapter selectToRight ].
	
	self bindKeyCombination: Character arrowLeft alt shift command toAction: [
		self pressedScrollerSizeCombination: #left.
	].

	self bindKeyCombination: Character arrowRight alt shift command toAction: [
		self pressedScrollerSizeCombination: #right.
	].
]

{ #category : #initialization }
GLMPagerMorph >> onPagePoped [

	self showOrHideScrollBar.
]

{ #category : #initialization }
GLMPagerMorph >> onPagePushed [

	self showOrHideScrollBar.
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> outOfWorld: aWorld [

	GLMPagerPanePreviewMorph remove.
	^ super outOfWorld: aWorld.
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> popAndReplacePane: aMorph [
	adapter popAndReplacePane: aMorph
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> popPane [
	adapter popPane.
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> pressedScrollerSizeCombination: aSymbol [

	firstCombination ifNil: [ firstCombination := aSymbol. ^ self].
	
	self scrollerSizeShortcutAction: firstCombination second: aSymbol.
	firstCombination := nil.
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> pushPane: aMorph [

	adapter pushPane: aMorph smooth: true.
	
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> scrollerSizeShortcutAction: first second: second [
	
	(first = #left & second = #left) ifTrue: [ adapter enlargeToLeft ].
	(first = #left & second = #right) ifTrue: [ adapter diminishToRight ].
	(first = #right & second = #left) ifTrue: [ adapter diminishToLeft ].
	(first = #right & second = #right) ifTrue: [ adapter enlargeToRight ]
]

{ #category : #initialization }
GLMPagerMorph >> showOrHideScrollBar [
	
	(adapter size > adapter numberOfVisiblePages)
		ifTrue: [ self addMorphBack: pagerBar ]
		ifFalse: [ self removeMorph: pagerBar ].
]
