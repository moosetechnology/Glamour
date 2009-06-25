Class {
	#name : #GLMScrollBar2,
	#superclass : #ScrollBar,
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMScrollBar2 class >> alwaysShowFlatScrollbarForAlternativeLook [
	^ false
]

{ #category : #'class initialization' }
GLMScrollBar2 class >> initialize [
	UpArrow := Form
				extent: 6 @ 3
				fromArray: #(805306368 2013265920 4227858432 )
				offset: 0 @ 0
]

{ #category : #accessing }
GLMScrollBar2 >> adoptPaneColor: t1 [ 
	super adoptPaneColor: t1.
	t1
		ifNil: [^ self].
	self sliderColor: t1
]

{ #category : #geometry }
GLMScrollBar2 >> buttonExtent [
	^ bounds isWide
		ifTrue: [11 @ self innerBounds height]
		ifFalse: [self innerBounds width @ 11]
]

{ #category : #accessing }
GLMScrollBar2 >> cachedImageAt: t1 ifAbsentPut: t2 [ 
	CachedImages
		ifNil: [CachedImages := Dictionary new].
	^ CachedImages at: t1 ifAbsentPut: t2
]

{ #category : #scrolling }
GLMScrollBar2 >> doScrollByPage [
	(self waitForDelay1: 300 delay2: 100)
		ifFalse: [^ self].
	nextPageDirection
		ifTrue: [self
				setValue: (value + pageDelta min: 1.0)]
		ifFalse: [self
				setValue: (value - pageDelta max: 0.0)]
]

{ #category : #scrolling }
GLMScrollBar2 >> doScrollDown [
	(self waitForDelay1: 200 delay2: 40)
		ifFalse: [^ self].
	self
		setValue: (value + scrollDelta + 1.0e-6 min: 1.0)
]

{ #category : #scrolling }
GLMScrollBar2 >> doScrollUp [
	(self waitForDelay1: 200 delay2: 40)
		ifFalse: [^ self].
	self
		setValue: (value - scrollDelta - 1.0e-6 max: 0.0)
]

{ #category : #geometry }
GLMScrollBar2 >> expandSlider [
	| t1 |
	t1 := self totalSliderArea.
	slider
		extent: (bounds isWide
				ifTrue: [((t1 width * interval) asInteger max: self sliderThickness)
						@ slider height]
				ifFalse: [slider width
						@ ((t1 height * interval) asInteger max: self sliderThickness)])
]

{ #category : #geometry }
GLMScrollBar2 >> extent: t1 [ 
	t1 x > t1 y
		ifTrue: [super
				extent: (t1 max: 42 @ 8)]
		ifFalse: [super
				extent: (t1 max: 8 @ 42)]
]

{ #category : #scrolling }
GLMScrollBar2 >> finishedScrolling [
	self stopStepping.
	self scrollBarAction: nil.
	self roundedScrollbarLook
		ifTrue: [upButton
				borderStyle: (BorderStyle complexRaised width: upButton borderWidth).
			downButton
				borderStyle: (BorderStyle complexRaised width: downButton borderWidth)]
		ifFalse: [downButton borderRaised.
			upButton borderRaised]
]

{ #category : #initialization }
GLMScrollBar2 >> initialize [
	super initialize.
	scrollDelta := 0.02.
	pageDelta := 0.2.
	self roundedScrollbarLook
		ifTrue: [self
				borderStyle: (BorderStyle complexFramed width: 2)]
]

{ #category : #initialize }
GLMScrollBar2 >> initializeDownButton [
	downButton := RectangleMorph
				newBounds: (self innerBounds bottomRight - self buttonExtent extent: self buttonExtent)
				color: self thumbColor.
	downButton
		on: #mouseDown
		send: #scrollDownInit
		to: self.
	downButton
		on: #mouseUp
		send: #finishedScrolling
		to: self.
	downButton
		addMorphCentered: (ImageMorph new
				image: (self
						cachedImageAt: (bounds isWide
								ifTrue: ['right']
								ifFalse: ['down'])
						ifAbsentPut: [self upArrow8Bit
								rotateBy: (bounds isWide
										ifTrue: [#right]
										ifFalse: [#pi])
								centerAt: 0 @ 0])).
	self roundedScrollbarLook
		ifTrue: [downButton color: Color veryLightGray.
			downButton
				borderStyle: (BorderStyle complexRaised width: 3)]
		ifFalse: [downButton setBorderWidth: 1 borderColor: #raised].
	self addMorph: downButton
]

{ #category : #initialize }
GLMScrollBar2 >> initializeEmbedded: t1 [ 
	self roundedScrollbarLook
		ifFalse: [^ self].
	t1
		ifTrue: [self
				borderStyle: (BorderStyle inset width: 2).
			self cornerStyle: #square]
		ifFalse: [self
				borderStyle: (BorderStyle width: 1 color: Color black).
			self cornerStyle: #rounded].
	self removeAllMorphs.
	self initializeSlider
]

{ #category : #initialize }
GLMScrollBar2 >> initializePagingArea [
	pagingArea := RectangleMorph
				newBounds: self totalSliderArea
				color: (Color
						r: 0.6
						g: 0.6
						b: 0.8).
	pagingArea borderWidth: 0.
	pagingArea
		on: #mouseDown
		send: #scrollPageInit:
		to: self.
	pagingArea
		on: #mouseUp
		send: #finishedScrolling
		to: self.
	self addMorph: pagingArea.
	self roundedScrollbarLook
		ifTrue: [pagingArea
				color: (Color gray: 0.9)]
]

{ #category : #initialize }
GLMScrollBar2 >> initializeSlider [
	self roundedScrollbarLook
		ifTrue: [self initializeUpButton; initializeDownButton; initializePagingArea]
		ifFalse: [self initializeUpButton; initializeDownButton; initializePagingArea].
	super initializeSlider.
	self roundedScrollbarLook
		ifTrue: [slider cornerStyle: #rounded.
			slider
				borderStyle: (BorderStyle complexRaised width: 3).
			sliderShadow cornerStyle: #rounded].
	self sliderColor: self sliderColor
]

{ #category : #initialize }
GLMScrollBar2 >> initializeUpButton [
	upButton := self roundedScrollbarLook
				ifTrue: [RectangleMorph
						newBounds: (self innerBounds topLeft extent: self buttonExtent)]
				ifFalse: [RectangleMorph
						newBounds: (self innerBounds topLeft extent: self buttonExtent)].
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
		addMorphCentered: (ImageMorph new
				image: (self
						cachedImageAt: (bounds isWide
								ifTrue: ['left']
								ifFalse: ['up'])
						ifAbsentPut: [bounds isWide
								ifTrue: [self upArrow8Bit rotateBy: #left centerAt: 0 @ 0]
								ifFalse: [self upArrow8Bit]])).
	self roundedScrollbarLook
		ifTrue: [upButton color: Color veryLightGray.
			upButton
				borderStyle: (BorderStyle complexRaised width: 3)]
		ifFalse: [upButton setBorderWidth: 1 borderColor: #raised].
	self addMorph: upButton
]

{ #category : #access }
GLMScrollBar2 >> interval: t1 [ 
	interval := t1 min: 1.0.
	self expandSlider.
	self computeSlider
]

{ #category : #'other events' }
GLMScrollBar2 >> menuButtonMouseDown: t1 [ 
	t1 hand showTemporaryCursor: nil.
	self
		use: menuSelector
		orMakeModelSelectorFor: 'MenuButtonPressed:'
		in: [:t2 | 
			menuSelector := t2.
			model perform: t2 with: t1]
]

{ #category : #'other events' }
GLMScrollBar2 >> mouseDownInSlider: t1 [ 
	interval = 1.0
		ifTrue: [self setValue: 0.
			self model hideOrShowScrollBar].
	super mouseDownInSlider: t1
]

{ #category : #access }
GLMScrollBar2 >> pagingArea [
	^ pagingArea
]

{ #category : #'scroll timing' }
GLMScrollBar2 >> resetTimer [
	timeOfMouseDown := Time millisecondClockValue.
	timeOfLastScroll := timeOfMouseDown - 1000 max: 0.
	nextPageDirection := nil.
	currentScrollDelay := nil
]

{ #category : #access }
GLMScrollBar2 >> roundedScrollbarLook [
	^ false
		and: [self class alwaysShowFlatScrollbarForAlternativeLook not]
]

{ #category : #scrolling }
GLMScrollBar2 >> scrollBarAction [
	^ self valueOfProperty: #scrollBarAction
]

{ #category : #scrolling }
GLMScrollBar2 >> scrollBarAction: t1 [ 
	self setProperty: #scrollBarAction toValue: t1
]

{ #category : #access }
GLMScrollBar2 >> scrollDelta [
	^ scrollDelta
]

{ #category : #access }
GLMScrollBar2 >> scrollDelta: t1 pageDelta: t2 [ 
	scrollDelta := t1.
	pageDelta := t2
]

{ #category : #scrolling }
GLMScrollBar2 >> scrollDown [
	self flag: #obsolete.
	downButton eventHandler: nil.
	downButton
		on: #mouseDown
		send: #scrollDownInit
		to: self.
	downButton
		on: #mouseUp
		send: #finishedScrolling
		to: self.
	^ self scrollDownInit
]

{ #category : #scrolling }
GLMScrollBar2 >> scrollDown: t1 [ 
	self
		setValue: (value + (scrollDelta * t1) + 1.0e-6 min: 1.0)
]

{ #category : #scrolling }
GLMScrollBar2 >> scrollDownInit [
	downButton borderInset.
	self resetTimer.
	self scrollBarAction: #doScrollDown.
	self startStepping
]

{ #category : #scrolling }
GLMScrollBar2 >> scrollPageInit: t1 [ 
	self resetTimer.
	self setNextDirectionFromEvent: t1.
	self scrollBarAction: #doScrollByPage.
	self startStepping
]

{ #category : #scrolling }
GLMScrollBar2 >> scrollUp [
	self flag: #obsolete.
	upButton eventHandler: nil.
	upButton
		on: #mouseDown
		send: #scrollUpInit
		to: self.
	upButton
		on: #mouseUp
		send: #finishedScrolling
		to: self.
	^ self scrollUpInit
]

{ #category : #scrolling }
GLMScrollBar2 >> scrollUp: t1 [ 
	self
		setValue: (value - (scrollDelta * t1) - 1.0e-6 max: 0.0)
]

{ #category : #scrolling }
GLMScrollBar2 >> scrollUpInit [
	upButton borderInset.
	self resetTimer.
	self scrollBarAction: #doScrollUp.
	self startStepping
]

{ #category : #scrolling }
GLMScrollBar2 >> setNextDirectionFromEvent: t1 [ 
	nextPageDirection := bounds isWide
				ifTrue: [t1 cursorPoint x >= slider center x]
				ifFalse: [t1 cursorPoint y >= slider center y]
]

{ #category : #'model access' }
GLMScrollBar2 >> setValue: t1 [ 
	^ super
		setValue: (t1 roundTo: scrollDelta)
]

{ #category : #access }
GLMScrollBar2 >> sliderColor: t1 [ 
	| t2 |
	super sliderColor: t1.
	t2 := self thumbColor.
	upButton color: t2.
	downButton color: t2.
	slider color: t2.
	self roundedScrollbarLook
		ifTrue: [self color: Color transparent.
			pagingArea color: t1 muchLighter.
			self borderStyle style == #simple
				ifTrue: [self borderColor: t1 darker darker]
				ifFalse: [self borderStyle baseColor: t1]]
		ifFalse: [pagingArea
				color: (t1 alphaMixed: 0.3 with: Color white).
			self borderWidth: 0]
]

{ #category : #geometry }
GLMScrollBar2 >> sliderExtent [
	^ slider extent
]

{ #category : #access }
GLMScrollBar2 >> sliderShadowColor [
	^ self roundedScrollbarLook
		ifTrue: [self sliderColor darker]
		ifFalse: [super sliderShadowColor]
]

{ #category : #geometry }
GLMScrollBar2 >> sliderThickness [
	^ self roundedScrollbarLook
		ifTrue: [15]
		ifFalse: [super sliderThickness]
]

{ #category : #'stepping and presenter' }
GLMScrollBar2 >> step [
	| t1 |
	t1 := self scrollBarAction.
	t1
		ifNotNil: [self perform: t1]
]

{ #category : #testing }
GLMScrollBar2 >> stepTime [
	^ currentScrollDelay
		ifNil: [300]
]

{ #category : #access }
GLMScrollBar2 >> thumbColor [
	^ self sliderColor
		alphaMixed: 0.7
		with: (Color gray: 0.95)
]

{ #category : #geometry }
GLMScrollBar2 >> totalSliderArea [
	| t1 |
	t1 := upButton.
	upButton bottom > t1 bottom
		ifTrue: [t1 := upButton].
	^ bounds isWide
		ifTrue: [t1 bounds topRight corner: downButton bounds bottomLeft]
		ifFalse: [t1 bounds bottomLeft corner: downButton bounds topRight]
]

{ #category : #initialize }
GLMScrollBar2 >> upArrow8Bit [
	^ UpArrow8Bit
		ifNil: [UpArrow8Bit := (ColorForm mappingWhiteToTransparentFrom: UpArrow)
						asFormOfDepth: 8]
]

{ #category : #'scroll timing' }
GLMScrollBar2 >> waitForDelay1: t1 delay2: t2 [ 
	| t3 t4 |
	timeOfLastScroll isNil
		ifTrue: [self resetTimer].
	t3 := Time millisecondClockValue.
	(t4 := currentScrollDelay) isNil
		ifTrue: [t4 := t1].
	currentScrollDelay := t4 * 9 // 10 max: t2.
	timeOfLastScroll := t3.
	^ true
]

{ #category : #testing }
GLMScrollBar2 >> wantsSteps [
	^ self scrollBarAction notNil
]
