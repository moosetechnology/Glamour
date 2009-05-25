Class {
	#name : #GLMPaneScroller,
	#superclass : #RectangleMorph,
	#instVars : [
		'model',
		'sizing',
		'panes',
		'transform',
		'scrollBar',
		'renderer'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'instance creation' }
GLMPaneScroller class >> withModel: aModel [
	^ self new model: aModel
]

{ #category : #layout }
GLMPaneScroller >> adjustPaneHeight [
	"This gets called after the scrollbar has been shown or hidden, to move the bottom
	of the panes to the right place."
	
	transform bounds: self innerBounds.
	transform submorphsDo: [:m | m bounds: (m bounds withHeight: self paneHeight)]
]

{ #category : #private }
GLMPaneScroller >> basicUpdatePanes [
	self flag: 'It looks like all morphs are removed and then added again. Furthermore, the commented code below tries to reset the selection based on mathing the models behind the morphs. Of course, this breaks everytime we want to do something clever in the rendering. The whole logic must be changed to not remove the panes, but to reuse them'.
	panes := model 
		ifNil: [#()]
		ifNotNil: [model panes collect: [:ea | ea renderGlamorouslyOn: renderer]].	
	self clearPanes.
	
	panes do: [:ea | self pushPane: ea].
	
"	oldPanes doWithIndex: [:each :index |
		m := self modelForContainerMorph: each.
		pageIndex := self pageIndexForContainerMorph: each.
		newPane := panes at: index ifAbsent: [nil].
		newPane ifNotNil: [
			pageIndex ifNotNil: [newPane submorphs first selectedPageIndex: pageIndex].
			(self modelForContainerMorph: newPane) selectSilently: m selection]].
"	
	self adoptPaneColor: model defaultBackgroundColor

]

{ #category : #private }
GLMPaneScroller >> basicUpdateSizing [
	sizing := (self panes size min: self maxPanes) max: 1
]

{ #category : #layout }
GLMPaneScroller >> bounds: aRectangle [
	super bounds: aRectangle.
	self layoutWidgets.
	self layoutPanes.
	self setScrollDeltas.

]

{ #category : #panes }
GLMPaneScroller >> clearPanes [
	transform removeAllMorphs.
]

{ #category : #layout }
GLMPaneScroller >> computeMorphWidths [
	| paneWidths widths |
	paneWidths := self paneWidthsToFit: self totalPaneWidth.
	widths := OrderedCollection new.
	paneWidths do: [:w | widths add: w] separatedBy: [widths add: self separatorWidth].
	^ widths asArray

]

{ #category : #scrolling }
GLMPaneScroller >> hideOrShowScrollBar [
	self isScrollable ifTrue: [self showScrollBar] ifFalse: [self hideScrollBar]
]

{ #category : #scrolling }
GLMPaneScroller >> hideScrollBar [
	self removeMorph: scrollBar.
	self adjustPaneHeight.
]

{ #category : #initialization }
GLMPaneScroller >> initialize [
	super initialize.
	self 
		color: Color white;
		borderWidth: 0;
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	self 
		initializeTransform;
		initializeScrollbar.
]

{ #category : #initialization }
GLMPaneScroller >> initializeScrollbar [
	scrollBar := GLMScrollBar new model: self slotName: 'scrollBar'.
	scrollBar 
		borderWidth: 0;
		borderColor: #inset;
		height: self scrollBarHeight.
	self resizeScrollBar.

]

{ #category : #initialization }
GLMPaneScroller >> initializeTransform [
	transform := TransformMorph new.
	transform
		color: Color transparent;
		borderWidth: 0;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		disableTableLayout;
		bounds: super innerBounds.
	self addMorphBack: transform.

]

{ #category : #layout }
GLMPaneScroller >> innerBounds [
	| rect |
	rect := super innerBounds.
	^ self scrollBarIsVisible
		ifTrue: [rect withHeight: rect height - self scrollBarHeight - 1]
		ifFalse: [rect]
]

{ #category : #scrolling }
GLMPaneScroller >> isScrollable [
	^ self leftoverScrollRange > 0
]

{ #category : #layout }
GLMPaneScroller >> layoutPanes [
	| widths rect |
	widths := self computeMorphWidths.
	rect := 0@0 extent: (0 @ self paneHeight).
	transform submorphs 
					with: widths 
					do: [:m :w | 
						rect := rect withWidth: w.
						m bounds: rect.
						rect := rect translateBy: (w@0)]
						

]

{ #category : #layout }
GLMPaneScroller >> layoutWidgets [
	| inner outer |
	outer := super innerBounds.
	inner := self innerBounds.
	transform bounds: inner.
	scrollBar bounds: ((inner left @ inner bottom + 1)
						corner: outer bottomRight)
]

{ #category : #scrolling }
GLMPaneScroller >> leftoverScrollRange [
	^ (self totalScrollRange - self innerBounds width roundTo: self scrollDeltaWidth) max: 0

]

{ #category : #configuration }
GLMPaneScroller >> maxPanes [
	^2
]

{ #category : #accessing }
GLMPaneScroller >> model: aBrowser [
	model := aBrowser
]

{ #category : #private }
GLMPaneScroller >> modelForContainerMorph: aMorph [
	| subMorph |
	self flag: 'this method should eventually not be needed anymore'.
	subMorph := aMorph submorphs first.
	^ (subMorph isKindOf: TabGroupMorph) 
		ifTrue: [subMorph submorphs first submorphs first model] 
		ifFalse: [subMorph model]

]

{ #category : #private }
GLMPaneScroller >> pageIndexForContainerMorph: aMorph [
	"really ugly..."
	| subMorph |
	subMorph := aMorph submorphs first.
	^ (subMorph isKindOf: TabGroupMorph) 
		ifTrue: [subMorph selectedPageIndex] 
		ifFalse: [nil]

]

{ #category : #layout }
GLMPaneScroller >> paneCount [
	^ self panes size
]

{ #category : #layout }
GLMPaneScroller >> paneHeight [
	^ transform bounds height
]

{ #category : #layout }
GLMPaneScroller >> paneWidthsToFit: limit [
	| padded |
	padded := Array new: self paneCount.
	padded atAllPut: (limit / self sizing) floor.
	(1 to: limit - padded sum) do: [:i | padded at: i put: (padded at: i) + 1].
	^ padded
	
	
]

{ #category : #accessing }
GLMPaneScroller >> panes [
	^ panes ifNil: [self updatePanes. panes]
]

{ #category : #panes }
GLMPaneScroller >> popPanes: count [
	count * 2 timesRepeat: [transform removeMorph: transform lastSubmorph].
	panes removeLast: count
]

{ #category : #panes }
GLMPaneScroller >> pushPane: aMorph [	
	aMorph 
		borderWidth: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		layoutInset: 0.
	transform hasSubmorphs ifTrue: [transform addMorphBack: self separator].
	transform addMorphBack: aMorph.
]

{ #category : #layout }
GLMPaneScroller >> resizeScrollBar [
	| inner outer |
	outer := super innerBounds.
	inner := outer withHeight: outer height - self scrollBarHeight - 1.
	scrollBar bounds: ((inner left @ inner bottom + 1)
						corner: outer bottomRight)
]

{ #category : #layout }
GLMPaneScroller >> scrollBarHeight [
	^ 12
]

{ #category : #scrolling }
GLMPaneScroller >> scrollBarIsVisible [
	^ submorphs includes: scrollBar
]

{ #category : #updating }
GLMPaneScroller >> scrollBarValue: value [
	transform hasSubmorphs ifFalse: [^ self].
	transform offset: (self leftoverScrollRange * value) rounded @ 0.
]

{ #category : #scrolling }
GLMPaneScroller >> scrollDeltaWidth [
	^ 1
]

{ #category : #scrolling }
GLMPaneScroller >> scrollToRight [
	^ scrollBar setValue: 1.
]

{ #category : #panes }
GLMPaneScroller >> separator [
	^ BorderedSubpaneDividerMorph vertical
		color: model defaultBackgroundColor duller;
		yourself
]

{ #category : #layout }
GLMPaneScroller >> separatorWidth [
	^3
]

{ #category : #accessing }
GLMPaneScroller >> setRenderer: aRenderer [
	renderer := aRenderer
]

{ #category : #scrolling }
GLMPaneScroller >> setScrollDeltas [
	| range interval value |
	transform hasSubmorphs ifFalse: [scrollBar interval: 1.0. ^ self].
	range := self leftoverScrollRange.
	range = 0 ifTrue: [^ scrollBar interval: 1.0; setValue: 0].
	interval := ((self innerBounds width) / self totalScrollRange) asFloat.
	value := (transform offset x / range min: 1.0) asFloat.
	scrollBar interval: interval.
	scrollBar setValue: value.
]

{ #category : #scrolling }
GLMPaneScroller >> showScrollBar [
	self scrollBarIsVisible ifTrue: [^ self].
	self resizeScrollBar.
	self addMorphFront: scrollBar.
	self adjustPaneHeight.
	
]

{ #category : #accessing }
GLMPaneScroller >> sizing [
	^ sizing ifNil: [self updateSizing]
]

{ #category : #layout }
GLMPaneScroller >> totalPaneWidth [
	^ self innerBounds width - ((self sizing - 1) * self separatorWidth)
]

{ #category : #scrolling }
GLMPaneScroller >> totalScrollRange [
	| submorphBounds |
	submorphBounds := transform localSubmorphBounds ifNil: [^ 0].
	^ submorphBounds width

]

{ #category : #updating }
GLMPaneScroller >> update: aSymbol [
	aSymbol = #sizing ifTrue: [^ self updateSizing].
	aSymbol = #columns ifTrue: [^ self updatePanes].
]

{ #category : #updating }
GLMPaneScroller >> updatePanes [
	| count |
	count := panes ifNotNil: [panes size] ifNil: [0].
	self basicUpdatePanes.
	self basicUpdateSizing.	
	self layoutPanes.
	panes size = count ifFalse: [
		self hideOrShowScrollBar.
		self setScrollDeltas ].
	panes size > count ifTrue: [self scrollToRight].
	^ panes
]

{ #category : #updating }
GLMPaneScroller >> updateSizing [
	| old |
	old := sizing.
	self basicUpdateSizing.
	sizing = old ifFalse: [self layoutPanes].
	^sizing
]
