Class {
	#name : #GLMScrollBar,
	#superclass : #Slider,
	#instVars : [
		'upButton',
		'downButton',
		'pagingArea',
		'scrollDelta',
		'pageDelta',
		'interval',
		'menuSelector',
		'timeOfMouseDown',
		'timeOfLastScroll',
		'nextPageDirection',
		'currentScrollDelay'
	],
	#classVars : [
		'CachedImages',
		'UpArrow',
		'UpArrow8Bit'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMScrollBar class >> alwaysShowFlatScrollbarForAlternativeLook [
	"Set this value to true, if you want to see the flat scrollbar look in flop-out mode as well as inboard.  Otherwise the flop-out scrollbar will be rounded and inboard will be flat."
	^ false
]

{ #category : #'class initialization' }
GLMScrollBar class >> initialize [ "GLMScrollBar initialize"

	UpArrow := Form
		extent: 6@3
		fromArray: #(2r11e28 2r1111e27 2r111111e26)
		offset: 0@0.
]

{ #category : #accessing }
GLMScrollBar >> adoptPaneColor: aColor [
	"Adopt the given pane color"
	super adoptPaneColor: aColor.
	aColor ifNil:[^self].
	self sliderColor: aColor.
]

{ #category : #geometry }
GLMScrollBar >> buttonExtent [
	^ bounds isWide
		ifTrue: [11 @ self innerBounds height]
		ifFalse: [self innerBounds width @ 11]
]

{ #category : #accessing }
GLMScrollBar >> cachedImageAt: aKey ifAbsentPut: aBlock [

	CachedImages ifNil: [CachedImages := Dictionary new].
	^CachedImages at: aKey ifAbsentPut: aBlock
]

{ #category : #scrolling }
GLMScrollBar >> doScrollByPage [
	"Scroll automatically while mouse is down"
	(self waitForDelay1: 300 delay2: 100) ifFalse: [^ self].
	nextPageDirection
		ifTrue: [self setValue: (value + pageDelta min: 1.0)]
		ifFalse: [self setValue: (value - pageDelta max: 0.0)]

]

{ #category : #scrolling }
GLMScrollBar >> doScrollDown [
	"Scroll automatically while mouse is down"
	(self waitForDelay1: 200 delay2: 40) ifFalse: [^ self].
	self setValue: (value + scrollDelta + 0.000001 min: 1.0)
]

{ #category : #scrolling }
GLMScrollBar >> doScrollUp [
	"Scroll automatically while mouse is down"
	(self waitForDelay1: 200 delay2: 40) ifFalse: [^ self].
	self setValue: (value - scrollDelta - 0.000001 max: 0.0)
]

{ #category : #geometry }
GLMScrollBar >> expandSlider [
	"Compute the new size of the slider (use the old sliderThickness as a minimum)."
	| r |
	r := self totalSliderArea.
	slider extent: (bounds isWide
		ifTrue: [((r width * interval) asInteger max: self sliderThickness) @ slider height]
		ifFalse: [slider width @ ((r height * interval) asInteger max: self sliderThickness)])
]

{ #category : #geometry }
GLMScrollBar >> extent: p [
        p x > p y
                ifTrue: [super extent: (p max: 42@8)]
                ifFalse: [super extent: (p max: 8@42)]
]

{ #category : #scrolling }
GLMScrollBar >> finishedScrolling [
	self stopStepping.
	self scrollBarAction: nil.
	self roundedScrollbarLook ifTrue:[
		upButton borderStyle: (BorderStyle complexRaised width: upButton borderWidth).
		downButton borderStyle: (BorderStyle complexRaised width: downButton borderWidth).
	] ifFalse:[
		downButton borderRaised.
		upButton borderRaised.
	].


]

{ #category : #initialization }
GLMScrollBar >> initialize [
	super initialize.
	scrollDelta := 0.02.
	pageDelta := 0.2.
	self roundedScrollbarLook ifTrue:[
		self borderStyle: ((BorderStyle complexFramed width: 2) "baseColor: Color gray")].
]

{ #category : #initialize }
GLMScrollBar >> initializeDownButton [
	downButton := RectangleMorph
		newBounds: (self innerBounds bottomRight - self buttonExtent extent: self buttonExtent)
		color: self thumbColor.
	downButton on: #mouseDown send: #scrollDownInit to: self.
	downButton on: #mouseUp send: #finishedScrolling to: self.
	downButton addMorphCentered: (ImageMorph new image: 
		(self 
			cachedImageAt: (bounds isWide ifTrue: ['right'] ifFalse: ['down']) 
			ifAbsentPut: [
				self upArrow8Bit
					rotateBy: (bounds isWide ifTrue: [#right] ifFalse: [#pi])
					centerAt: 0@0
			]
		)
	).
	self roundedScrollbarLook ifTrue:[
		downButton color: Color veryLightGray.
		downButton borderStyle: (BorderStyle complexRaised width: 3).
	] ifFalse:[
		downButton setBorderWidth: 1 borderColor: #raised.
	].
	self addMorph: downButton.

]

{ #category : #initialize }
GLMScrollBar >> initializeEmbedded: aBool [
	"aBool == true => inboard scrollbar
	aBool == false => flop-out scrollbar"
	self roundedScrollbarLook ifFalse:[^self].
	aBool ifTrue:[
		self borderStyle: (BorderStyle inset width: 2).
		self cornerStyle: #square.
	] ifFalse:[
		self borderStyle: (BorderStyle width: 1 color: Color black).
		self cornerStyle: #rounded.
	].
	self removeAllMorphs.
	self initializeSlider.
]

{ #category : #initialize }
GLMScrollBar >> initializePagingArea [
	pagingArea := RectangleMorph newBounds: self totalSliderArea
								color: (Color r: 0.6 g: 0.6 b: 0.8).
	pagingArea borderWidth: 0.
	pagingArea on: #mouseDown send: #scrollPageInit: to: self.
	pagingArea on: #mouseUp send: #finishedScrolling to: self.
	self addMorph: pagingArea.
	self roundedScrollbarLook 
		ifTrue:[pagingArea color: (Color gray: 0.9)].
]

{ #category : #initialize }
GLMScrollBar >> initializeSlider [
	self roundedScrollbarLook ifTrue:[
		self 
			initializeUpButton;
			initializeDownButton;
			initializePagingArea.
	] ifFalse:[
		self initializeUpButton; 
			initializeDownButton; 
			initializePagingArea.
	].
	super initializeSlider.
	self roundedScrollbarLook ifTrue:[
		slider cornerStyle: #rounded.
		slider borderStyle: (BorderStyle complexRaised width: 3).
		sliderShadow cornerStyle: #rounded.
	].
	self sliderColor: self sliderColor.
]

{ #category : #initialize }
GLMScrollBar >> initializeUpButton [
	upButton := self roundedScrollbarLook 
				ifTrue:  
					[RectangleMorph 
						newBounds: (self innerBounds topLeft extent: self buttonExtent)]
				ifFalse: 
					[RectangleMorph 
						newBounds: ((self innerBounds topLeft) extent: self buttonExtent)].
	upButton color: self thumbColor.
	upButton 
		on: #mouseDown
		send: #scrollUpInit
		to: self.
	upButton 
		on: #mouseUp
		send: #finishedScrolling
		to: self.
	upButton 
		addMorphCentered: (ImageMorph new image: (self 
						cachedImageAt: (bounds isWide ifTrue: ['left'] ifFalse: ['up'])
						ifAbsentPut: 
							[bounds isWide 
								ifTrue: [self upArrow8Bit rotateBy: #left centerAt: 0 @ 0]
								ifFalse: [self upArrow8Bit]])).
	self roundedScrollbarLook 
		ifTrue: 
			[upButton color: Color veryLightGray.
			upButton borderStyle: (BorderStyle complexRaised width: 3)]
		ifFalse: [upButton setBorderWidth: 1 borderColor: #raised].
	self addMorph: upButton
]

{ #category : #access }
GLMScrollBar >> interval: d [
	"Supply an optional floating fraction so slider can expand to indicate range"
	interval := d min: 1.0.
	self expandSlider.
	self computeSlider.
]

{ #category : #'other events' }
GLMScrollBar >> menuButtonMouseDown: event [
	event hand showTemporaryCursor: nil.
	self use: menuSelector orMakeModelSelectorFor: 'MenuButtonPressed:'
		in: [:sel | menuSelector := sel.  model perform: sel with: event]
]

{ #category : #'other events' }
GLMScrollBar >> mouseDownInSlider: event [
	interval = 1.0 ifTrue:
		["make the entire scrollable area visible if a full scrollbar is clicked on"
		self setValue: 0.
		self model hideOrShowScrollBar].
	super mouseDownInSlider: event
]

{ #category : #access }
GLMScrollBar >> pagingArea [
	^pagingArea
]

{ #category : #'scroll timing' }
GLMScrollBar >> resetTimer [
	timeOfMouseDown := Time millisecondClockValue.
	timeOfLastScroll := timeOfMouseDown - 1000 max: 0.
	nextPageDirection := nil.
	currentScrollDelay := nil
]

{ #category : #access }
GLMScrollBar >> roundedScrollbarLook [
	"Rounded look currently only shows up in flop-out mode"
	^false and: [self class alwaysShowFlatScrollbarForAlternativeLook not]

]

{ #category : #scrolling }
GLMScrollBar >> scrollBarAction [
	^self valueOfProperty: #scrollBarAction
]

{ #category : #scrolling }
GLMScrollBar >> scrollBarAction: aSymbol [
	self setProperty: #scrollBarAction toValue: aSymbol
]

{ #category : #access }
GLMScrollBar >> scrollDelta [
	^ scrollDelta
]

{ #category : #access }
GLMScrollBar >> scrollDelta: d1 pageDelta: d2 [
	"Supply optional increments for better scrolling of, eg, text"
	scrollDelta := d1.
	pageDelta := d2.
]

{ #category : #scrolling }
GLMScrollBar >> scrollDown [
	self flag: #obsolete.
	downButton eventHandler: nil.
	downButton on: #mouseDown send: #scrollDownInit to: self.
	downButton on: #mouseUp send: #finishedScrolling to: self.
	^self scrollDownInit
]

{ #category : #scrolling }
GLMScrollBar >> scrollDown: count [
	self setValue: (value + (scrollDelta * count) + 0.000001 min: 1.0)
]

{ #category : #scrolling }
GLMScrollBar >> scrollDownInit [
	downButton borderInset.
	self resetTimer.
	self scrollBarAction: #doScrollDown.
	self startStepping.
]

{ #category : #scrolling }
GLMScrollBar >> scrollPageInit: evt [
	self resetTimer.
	self setNextDirectionFromEvent: evt.
	self scrollBarAction: #doScrollByPage.
	self startStepping.
]

{ #category : #scrolling }
GLMScrollBar >> scrollUp [
	self flag: #obsolete.
	upButton eventHandler: nil.
	upButton on: #mouseDown send: #scrollUpInit to: self.
	upButton on: #mouseUp send: #finishedScrolling to: self.
	^self scrollUpInit
]

{ #category : #scrolling }
GLMScrollBar >> scrollUp: count [
	self setValue: (value - (scrollDelta * count) - 0.000001 max: 0.0)
]

{ #category : #scrolling }
GLMScrollBar >> scrollUpInit [
	upButton borderInset.
	self resetTimer.
	self scrollBarAction: #doScrollUp.
	self startStepping.
]

{ #category : #scrolling }
GLMScrollBar >> setNextDirectionFromEvent: event [

	nextPageDirection := bounds isWide ifTrue: [
		event cursorPoint x >= slider center x
	]
	ifFalse: [
		event cursorPoint y >= slider center y
	]


]

{ #category : #'model access' }
GLMScrollBar >> setValue: newValue [
	"Using roundTo: instead of truncateTo: ensures that scrollUp will scroll the same distance as scrollDown."
	^ super setValue: (newValue roundTo: scrollDelta)
]

{ #category : #access }
GLMScrollBar >> sliderColor: aColor [
	"Change the color of the scrollbar to go with aColor."
	| buttonColor |
	super sliderColor: aColor.
	buttonColor := self thumbColor.
	upButton color: buttonColor.
	downButton color: buttonColor.
	slider color: buttonColor.
	self roundedScrollbarLook
			ifTrue:
				[self color: Color transparent.
				pagingArea color: aColor muchLighter.
				self borderStyle style == #simple 
					ifTrue:[self borderColor: aColor darker darker]
					ifFalse:[self borderStyle baseColor: aColor]]
			ifFalse:
				[pagingArea color: (aColor alphaMixed: 0.3 with: Color white).
				self borderWidth: 0]

]

{ #category : #geometry }
GLMScrollBar >> sliderExtent [
	"The sliderExtent is now stored in the slider itself, not hardcoded as it is in the superclass."
	^slider extent
]

{ #category : #access }
GLMScrollBar >> sliderShadowColor [
	^ self roundedScrollbarLook
		ifTrue: [self sliderColor darker]
		ifFalse: [super sliderShadowColor]

]

{ #category : #geometry }
GLMScrollBar >> sliderThickness [
	^ self roundedScrollbarLook ifTrue:[15] ifFalse:[super sliderThickness]
]

{ #category : #'stepping and presenter' }
GLMScrollBar >> step [
	| action |
	action := self scrollBarAction.
	action ifNotNil:[self perform: action].
]

{ #category : #testing }
GLMScrollBar >> stepTime [
	^ currentScrollDelay ifNil: [300]
]

{ #category : #access }
GLMScrollBar >> thumbColor [
	"Problem: Part of the ScrollBar/Slider code uses 'slider' to mean the entire scrollbar/slider widget, and part of it uses 'slider' to mean only the draggable 'thumb'.  This should be cleaned up so that 'thumb' is used instead of 'slider' where appropriate.  For now, the meaning of thumbColor is clear, at least."

	^self sliderColor alphaMixed: 0.7 with: (Color gray: 0.95).
]

{ #category : #geometry }
GLMScrollBar >> totalSliderArea [
	| upperBoundsButton |
	upperBoundsButton := upButton.
	upButton bottom > upperBoundsButton bottom
		ifTrue: [upperBoundsButton := upButton].
	^ bounds isWide
		ifTrue: [upperBoundsButton bounds topRight corner: downButton bounds bottomLeft]
		ifFalse: [upperBoundsButton bounds bottomLeft corner: downButton bounds topRight].

]

{ #category : #initialize }
GLMScrollBar >> upArrow8Bit [

	"convert to 8-bit and convert white to transparent to avoid gratuitous conversion every time we put one in an ImageMorph"

	^UpArrow8Bit ifNil: [
		UpArrow8Bit := (ColorForm mappingWhiteToTransparentFrom: UpArrow) asFormOfDepth: 8
	]
]

{ #category : #'scroll timing' }
GLMScrollBar >> waitForDelay1: delay1 delay2: delay2 [ 
	"Return true if an appropriate delay has passed since the last scroll operation.
	The delay decreases exponentially from delay1 to delay2."

	| now scrollDelay |
	timeOfLastScroll isNil ifTrue: [self resetTimer].	"Only needed for old instances"
	now := Time millisecondClockValue.
	(scrollDelay := currentScrollDelay) isNil 
		ifTrue: [scrollDelay := delay1	"initial delay"].
	currentScrollDelay := scrollDelay * 9 // 10 max: delay2.	"decrease the delay"
	timeOfLastScroll := now.
	^true
]

{ #category : #testing }
GLMScrollBar >> wantsSteps [
	^self scrollBarAction notNil
]
