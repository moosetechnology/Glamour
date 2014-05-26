Class {
	#name : #GLMPageScroller,
	#superclass : #BorderedMorph,
	#instVars : [
		'sizing',
		'transform',
		'scrollBar',
		'paneCount',
		'maxPanes',
		'panes',
		'currentScrollValue',
		'focus'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #layout }
GLMPageScroller >> adjustPaneHeight [
	"This gets called after the scrollbar has been shown or hidden, to move the bottom
	of the panes to the right place."
	
	transform bounds: self innerBounds.
	transform submorphsDo: [:m | m bounds: (m bounds withHeight: self paneHeight)]
]

{ #category : #scrolling }
GLMPageScroller >> adoptPaneColor: aColor [
	super adoptPaneColor: aColor.
	scrollBar adoptPaneColor: aColor
]

{ #category : #private }
GLMPageScroller >> basicUpdateSizing [
	sizing := (self paneCount min: self maxPanes) max: 1
]

{ #category : #layout }
GLMPageScroller >> bounds: aRectangle [
	super bounds: aRectangle.
	self layoutWidgets.
	self layoutPanes.
	self setScrollDeltas.

]

{ #category : #layout }
GLMPageScroller >> computeMorphWidths [
	| paneWidths widths |
	paneWidths := self paneWidthsToFit: self totalPaneWidth.
	widths := OrderedCollection new.
	paneWidths do: [:w | widths add: w] separatedBy: [widths add: self separatorWidth].
	^ widths asArray

]

{ #category : #scrolling }
GLMPageScroller >> computeScrollValueToPaneByIndex: aNumber [
	|value|
	"self halt."
	self totalScrollRange.
	self innerBounds width.
	value := (self leftoverScrollRange = 0)
		ifFalse: [(((panes at: aNumber) position x) / self leftoverScrollRange) "asFloat"]
		ifTrue: [ 0 ].
	^ value.
]

{ #category : #accessing }
GLMPageScroller >> currentScrollValue [
	^ currentScrollValue
]

{ #category : #scrolling }
GLMPageScroller >> glmAnimateValue: aValue duration: anInteger [

	anInteger <= 0
		"if duration is zero, move to the left immediately"
		ifTrue: [ self leftTo: aValue ]
		ifFalse: [
			| startTime start currentValue |
			currentValue := self currentScrollValue.
			startTime := Time millisecondClockValue.
			start := currentValue.
			[	| delta |
				[ (delta := Time millisecondClockValue - startTime) < anInteger ] whileTrue: [
					self scrollValue: (aValue - start) * (delta / anInteger) + start.
					Processor yield
				].
				self scrollValue: aValue
			] fork
		]
]

{ #category : #initialization }
GLMPageScroller >> initialize [
	super initialize.
	self 
		color: Color transparent;
		borderWidth: 0;
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	self 
		initializeTransform;
		initializeScrollbar.
	
	currentScrollValue := 0.
	paneCount := 0.
	maxPanes := 2.
	panes := OrderedCollection new.
	focus := Dictionary new.
]

{ #category : #initialization }
GLMPageScroller >> initializeScrollbar [
	scrollBar := ScrollBar new 
		model: self;
		setValueSelector: #scrollValue:;
		yourself.
	scrollBar 
		borderWidth: 0;
		borderColor: #inset.

]

{ #category : #initialization }
GLMPageScroller >> initializeTransform [
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
GLMPageScroller >> layoutPanes [
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
GLMPageScroller >> layoutWidgets [

	transform bounds: self innerBounds.
]

{ #category : #scrolling }
GLMPageScroller >> leftoverScrollRange [
	^ (self totalScrollRange - self innerBounds width) max: 0

]

{ #category : #configuration }
GLMPageScroller >> maxPanes [
	^ maxPanes
]

{ #category : #configuration }
GLMPageScroller >> maxPanes: anInteger [
	maxPanes := anInteger
]

{ #category : #accessing }
GLMPageScroller >> paneAt: anIndex [
	^ self panes at: anIndex.
]

{ #category : #layout }
GLMPageScroller >> paneCount [
	^ paneCount
]

{ #category : #layout }
GLMPageScroller >> paneHeight [
	^ transform bounds height
]

{ #category : #layout }
GLMPageScroller >> paneWidthsToFit: limit [
	| padded |
	padded := Array new: self paneCount.
	padded atAllPut: (limit / self sizing) floor.
	(1 to: limit - padded sum) do: [:i | padded at: i put: (padded at: i) + 1].
	^ padded
	
	
]

{ #category : #accessing }
GLMPageScroller >> panes [

	^ panes
]

{ #category : #panes }
GLMPageScroller >> popAndReplacePane: aMorph [	
	transform removeMorph: transform lastSubmorph. "one for the separator"
	transform submorphs isEmpty
		ifFalse: [ transform removeMorph: transform lastSubmorph ].
	"remove from collection"
	panes removeLast.
	paneCount := paneCount - 1.	
	
	aMorph 
		borderWidth: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		layoutInset: 0.
	transform hasSubmorphs 
		ifTrue: [ transform addMorphBack: self separator ].
	transform addMorphBack: (aMorph adoptPaneColor: self paneColor).
	"adding morph to collection"
	panes addLast: aMorph.
	paneCount := paneCount + 1.
	self updatePanes
]

{ #category : #panes }
GLMPageScroller >> popPane [
	transform removeMorph: transform lastSubmorph. "one for the separator"
	transform submorphs isEmpty
		ifFalse: [ transform removeMorph: transform lastSubmorph ].
	"remove from collection"
	panes removeLast.
	paneCount := paneCount - 1.
	self updatePanes.
]

{ #category : #panes }
GLMPageScroller >> pushPane: aMorph [	
	aMorph 
		borderWidth: 1;
		borderColor: Color transparent;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		layoutInset: 0.
	transform hasSubmorphs 
		ifTrue: [ transform addMorphBack: self separator ].
	transform addMorphBack: (aMorph adoptPaneColor: self paneColor).
	"adding morph to collection"
	panes addLast: aMorph.
	paneCount := paneCount + 1.
	self updatePanes
]

{ #category : #scrolling }
GLMPageScroller >> scrollTo: aValue smooth: aBoolean [
 	aBoolean ifTrue: [	self glmAnimateValue: aValue duration: 200]
				ifFalse: [self scrollValue: aValue ].
]

{ #category : #'as yet unclassified' }
GLMPageScroller >> scrollToPaneByIndex: aNumber smooth: aBoolean [

	self scrollTo: (self computeScrollValueToPaneByIndex: aNumber) smooth: aBoolean.
]

{ #category : #scrolling }
GLMPageScroller >> scrollValue: value [
	transform hasSubmorphs ifFalse: [^ self].
	transform offset: (self leftoverScrollRange * value) rounded @ 0.
	currentScrollValue := value.
]

{ #category : #panes }
GLMPageScroller >> separator [
	^ "BorderedSubpaneDividerMorph new 
		vertical;
		adoptPaneColor: self paneColor;
		yourself"
		
	GLMMorphic emptyMorph
]

{ #category : #layout }
GLMPageScroller >> separatorWidth [
	^ 10
]

{ #category : #scrolling }
GLMPageScroller >> setScrollDeltas [
	self scrollTo: self currentScrollValue smooth: false.
]

{ #category : #updating }
GLMPageScroller >> setScrollDeltasSmooth [
	| range interval value |
	transform hasSubmorphs ifFalse: [scrollBar interval: 1.0. ^ self].
	range := self leftoverScrollRange.
	range = 0 ifTrue: [^ scrollBar interval: 1.0; setValue: 0].
	interval := ((self innerBounds width) / self totalScrollRange) asFloat.
	value := (transform offset x / range min: 1.0) asFloat.
	scrollBar interval: interval.
	scrollBar setValue: value.
]

{ #category : #accessing }
GLMPageScroller >> sizing [
	^ sizing ifNil: [self updateSizing]
]

{ #category : #layout }
GLMPageScroller >> totalPaneWidth [
	^ self innerBounds width - ((self sizing - 1) * self separatorWidth)
]

{ #category : #scrolling }
GLMPageScroller >> totalScrollRange [
	| submorphBounds |
	submorphBounds := transform localSubmorphBounds ifNil: [^ 0].
	^ submorphBounds width

]

{ #category : #updating }
GLMPageScroller >> updatePanes [
	self basicUpdateSizing.
	self layoutPanes.
	self setScrollDeltasSmooth.
]

{ #category : #updating }
GLMPageScroller >> updateSizing [
	| old |
	old := sizing.
	self basicUpdateSizing.
	sizing = old ifFalse: [self layoutPanes].
	^sizing
]
