Class {
	#name : #GLMPagerMorph,
	#superclass : #Morph,
	#instVars : [
		'firstCombination',
		'pagerBar',
		'pagerModel',
		'showScrollBarWhenNeeded'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #examples }
GLMPagerMorph class >> exampleBasic [
	|pager adapter|
	adapter := GLMPagerModel new.
	pager :=	GLMPagerMorph new.
	pager pagerModel: adapter.
	
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

{ #category : #'as yet unclassified' }
GLMPagerMorph >> buildScrollMorph [
	
	^ GLMFoundationBrick new
		brickRoot: (self newScrollMorph pagerModel: pagerModel);
		hResizing: #spaceFill;
		vResizing: #spaceFill.
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
		wrapCentering: #center;
		"for visual centering of the circle buttons"
		cellInset: EdgeGripMorph new defaultHeight
]

{ #category : #initialization }
GLMPagerMorph >> initializeShortcuts [

	self bindKeyCombination: Character arrowLeft alt command toAction: [ pagerModel selectToLeft ].
	self bindKeyCombination: Character arrowRight alt command toAction: [ pagerModel selectToRight ].
	
	self bindKeyCombination: Character arrowLeft alt shift command toAction: [
		self pressedScrollerSizeCombination: #left.
	].

	self bindKeyCombination: Character arrowRight alt shift command toAction: [
		self pressedScrollerSizeCombination: #right.
	].
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> newScrollMorph [

	^ GLMPagerScrollBrick new
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

{ #category : #accessing }
GLMPagerMorph >> pagerModel [
	^ pagerModel
]

{ #category : #accessing }
GLMPagerMorph >> pagerModel: aModel [
	pagerModel := aModel.
	
	self addMorphBack: self buildScrollMorph.
	
	pagerBar := GLMPagerBarMorph new pagerModel: pagerModel.
	
	pagerModel announcer weak
		when: GLMPagePushed send: #onPagePushed to: self.
		
	pagerModel announcer weak
		when: GLMPagePoped send: #onPagePoped to: self.
	
	self initializeShortcuts.
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> popAndReplacePane: aMorph [
	pagerModel popAndReplacePane: aMorph
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> popPane [
	pagerModel popPane: true.
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> pressedScrollerSizeCombination: aSymbol [

	firstCombination ifNil: [ firstCombination := aSymbol. ^ self].
	
	self scrollerSizeShortcutAction: firstCombination second: aSymbol.
	firstCombination := nil.
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> pushPane: aMorph [

	pagerModel pushPane: aMorph smooth: true.
	
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> scrollerSizeShortcutAction: first second: second [
	
	(first = #left & second = #left) ifTrue: [ pagerModel enlargeToLeft ].
	(first = #left & second = #right) ifTrue: [ pagerModel diminishToRight ].
	(first = #right & second = #left) ifTrue: [ pagerModel diminishToLeft ].
	(first = #right & second = #right) ifTrue: [ pagerModel enlargeToRight ]
]

{ #category : #initialization }
GLMPagerMorph >> showOrHideScrollBar [
	
	((pagerModel size > 1) & (self showScrollBarWhenNeeded))
		ifTrue: [ self addMorphBack: pagerBar ]
		ifFalse: [ self removeMorph: pagerBar ].
]

{ #category : #accessing }
GLMPagerMorph >> showScrollBarWhenNeeded [

	^ showScrollBarWhenNeeded ifNil: [ showScrollBarWhenNeeded := true ]
]

{ #category : #accessing }
GLMPagerMorph >> showScrollBarWhenNeeded: aBoolean [

	showScrollBarWhenNeeded := aBoolean
]
