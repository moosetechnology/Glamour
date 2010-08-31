Class {
	#name : #GLMUITheme,
	#superclass : #UIThemeWatery2,
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMUITheme class >> baseColor [
	^ Color r: 200 g: 200 b: 200 range: 255
]

{ #category : #accessing }
GLMUITheme class >> baseSelectionColor [
	^ self glamorousBlue
]

{ #category : #'as yet unclassified' }
GLMUITheme class >> beCurrent [
	"self beCurrent"
	super beCurrent.
	World color: (
		(GradientFillStyle 
			ramp: { 0.0 -> Color white darker.  1.0 -> Color veryLightGray})
			origin: 50 @ 50;
			direction: 800@0;
			normal: 0@800;
		radial: true).
	
]

{ #category : #private }
GLMUITheme class >> glamorousBlue [
	^ Color r: 0
		g: 0.4
		b: 0.808
]

{ #category : #'as yet unclassified' }
GLMUITheme class >> newDefaultSettings [
	^super newDefaultSettings
		menuColor: (Color r: 220 g: 220 b: 220 range: 255);
		menuTitleColor: (Color r: 220 g: 220 b: 220 range: 255);
		windowColor: self baseColor;
		selectionColor: (self glamorousBlue muchLighter);
		menuSelectionColor: (self glamorousBlue muchLighter);
		progressBarColor: self baseColor
		
	"Answer a new original default settings."
	"self defaultSettings: nil"
"	^super newDefaultSettings
		standardColorsOnly: true;
		autoSelectionColor: false;
		buttonColor: (Color r: 232 g: 232 b: 232 range: 255);
		windowColor: (Color r: 232 g: 232 b: 232 range: 255);
		scrollbarColor: (Color r: 62 g: 142 b: 220 range: 255) ;
		selectionColor: (TranslucentColor r: 0.0 g: 0.0 b: 0.8 alpha: 0.2) ;
		menuSelectionColor: (Color r: 51 g: 76 b: 230 range: 255) ;
		progressBarColor: (Color r: 232 g: 232 b: 232 range: 255);
		progressBarProgressColor: (Color r: 62 g: 142 b: 220 range: 255)"
]

{ #category : #accessing }
GLMUITheme class >> themeName [
	^ 'Glamorous'
]

{ #category : #private }
GLMUITheme >> buttonBaseColorFor: aButton [
	^ self class baseColor
	
	"unfortunately, it looks like paneColor does not always return the wanted color"
	"aButton paneColorOrNil ifNil: [Color r: 200 g: 200 b: 200 range: 255]"
]

{ #category : #'border-styles-buttons' }
GLMUITheme >> buttonCornerStyleIn: aThemedMorph [
	"Allow for themes to override default behaviour."
	
	^ #square
	"^aThemedMorph
		ifNil: [#rounded]
		ifNotNil: [:tm | 
			tm preferredButtonCornerStyle
				ifNil: [#rounded]
				ifNotNil: [:bcs | bcs]]"
]

{ #category : #'label-styles' }
GLMUITheme >> buttonLabelForText: aTextOrString [
	"Answer the label to use for the given text."
	^aTextOrString isString
		ifTrue: [(LabelMorph contents: aTextOrString) color: Color black]
		ifFalse: [super buttonLabelForText: aTextOrString]
]

{ #category : #defaults }
GLMUITheme >> buttonMinHeight [
	"Answer the minumum height of a button for this theme."
	
	^20
]

{ #category : #defaults }
GLMUITheme >> buttonMinWidth [
	"Answer the minumum width of a button for this theme."
	
	^20
]

{ #category : #'border-styles-buttons' }
GLMUITheme >> buttonNormalBorderStyleFor: aButton [
	"Return the normal button borderStyle for the given button."

	| outerColor innerColor |
	(aButton valueOfProperty: #noBorder ifAbsent: [false]) ifTrue: [
		^ SimpleBorder new width: 0; baseColor: Color transparent ].
	outerColor := (self buttonBaseColorFor: aButton) twiceDarker.
	^SimpleBorder new
					width: 1;
					baseColor: outerColor
]

{ #category : #'fill-styles-buttons' }
GLMUITheme >> buttonNormalFillStyleFor: aButton [
	"Return the normal button fillStyle for the given button."
	
	| toptop top bottom base |
	(aButton valueOfProperty: #noFill ifAbsent: [false]) ifTrue: [^ SolidFillStyle color: Color transparent ].
	base := self buttonBaseColorFor: aButton.
	toptop := base muchLighter.
	top := base twiceLighter.
	bottom := base.
	^(GradientFillStyle ramp: {
			0.0->toptop.
			0.05->top.
			0.8->bottom.})
		origin: aButton bounds origin;
		direction: 0 @ aButton height;
		radial: false
]

{ #category : #'border-styles-buttons' }
GLMUITheme >> buttonSelectedBorderStyleFor: aButton [
	^ self buttonNormalBorderStyleFor: aButton
]

{ #category : #'fill-styles-buttons' }
GLMUITheme >> buttonSelectedFillStyleFor: aButton [
	"Return the normal button fillStyle for the given button."
	
	| toptop top bottom base |
	base := self buttonBaseColorFor: aButton.
	toptop := base muchLighter.
	top := self glamorousBlue muchLighter.
	bottom := base.

	^(GradientFillStyle ramp: {
			0.0->toptop.
			0.05->top.
			0.8->bottom.})
		origin: aButton bounds origin;
		direction: 0 @ aButton height;
		radial: false
]

{ #category : #'border-styles' }
GLMUITheme >> configureWindowBorderFor: aWindow [
	super configureWindowBorderFor: aWindow.
	aWindow roundedCorners: #() "not even top"
]

{ #category : #private }
GLMUITheme >> glamorousBlue [ 
	^ self class glamorousBlue
]

{ #category : #'initialize-release' }
GLMUITheme >> initialize [
	"self beCurrent"

	super initialize.
	self windowActiveDropShadowStyle: #nodiffuse
]

{ #category : #'fill-styles-buttons' }
GLMUITheme >> menuItemInDockingBarSelectedFillStyleFor: aMenuItem [
	"Answer the selected fill style to use for the given menu item that is in a docking bar."
	
	| fill baseColor |
	Display depth <= 2
		ifTrue: [^ Color gray].
	baseColor := self settings derivedMenuColor.
	self preferGradientFill ifFalse: [^baseColor].
	fill := GradientFillStyle ramp: {0.0 -> baseColor twiceDarker . 1 -> baseColor twiceLighter}.
	fill
		origin: aMenuItem topLeft;
		direction: 0@aMenuItem height.
	^ fill
]

{ #category : #'morph creation' }
GLMUITheme >> newFocusIndicatorMorphFor: aMorph [
	"Answer a new focus indicator for the given morph."

	|radius|
	radius := aMorph focusIndicatorCornerRadius.
	^ BorderedMorph new
		fillStyle: Color transparent;
		borderStyle: (SimpleBorder new
			 width: 2;
			baseColor: (self glamorousBlue twiceDarker alpha: 0.2));
		bounds: aMorph focusBounds
]

{ #category : #'border-styles' }
GLMUITheme >> plainGroupPanelBorderStyleFor: aGroupPanel [
	"Answer the normal border style for a plain group panel."

	^SimpleBorder new
		width: 1;
		baseColor: (self buttonBaseColorFor: aGroupPanel) darker
]

{ #category : #'fill-styles' }
GLMUITheme >> progressBarFillStyleFor: aProgressBar [
	^ (self buttonBaseColorFor: aProgressBar) muchLighter
]

{ #category : #'fill-styles' }
GLMUITheme >> progressBarProgressFillStyleFor: aProgressBar [
	^ self class baseSelectionColor muchLighter
]

{ #category : #'fill-styles' }
GLMUITheme >> resizerGripNormalFillStyleFor: aResizer [
	"Return the normal fillStyle for the given resizer.
	For the moment, answer a transparent colour for no drawing,
	non transparent to draw as normal."
	
	^Color transparent
]

{ #category : #'fill-styles-scrollbars' }
GLMUITheme >> scrollbarNormalButtonFillStyleFor: aScrollbar [
	"Return the normal scrollbar button fillStyle for the given scrollbar."
	
	^ (self buttonNormalFillStyleFor: aScrollbar) 
		direction: (aScrollbar bounds isWide
			ifTrue: [0 @ aScrollbar height]
			ifFalse: [aScrollbar width @ 0])
]

{ #category : #'fill-styles-scrollbars' }
GLMUITheme >> scrollbarNormalFillStyleFor: aScrollbar [
	"Return the normal scrollbar fillStyle for the given scrollbar."
	
	^ (self buttonBaseColorFor: aScrollbar) muchLighter
]

{ #category : #'fill-styles-scrollbars' }
GLMUITheme >> scrollbarNormalThumbFillStyleFor: aScrollbar [
	"Return the normal scrollbar fillStyle for the given scrollbar."
	
	^ (self buttonNormalFillStyleFor: aScrollbar) 
		direction: (aScrollbar bounds isWide
			ifTrue: [0 @ aScrollbar height]
			ifFalse: [aScrollbar width @ 0])
]

{ #category : #'border-styles-scrollbars' }
GLMUITheme >> scrollbarPagingAreaCornerStyleIn: aThemedMorph [	
	^#square
]

{ #category : #'border-styles-scrollbars' }
GLMUITheme >> scrollbarThumbCornerStyleIn: aThemedMorph [	
	^#square
]

{ #category : #'fill-styles' }
GLMUITheme >> splitterNormalFillStyleFor: aSplitter [
	"Return the normal splitter fillStyle for the given splitter."
	
	^SolidFillStyle color: Color transparent
]

{ #category : #'fill-styles' }
GLMUITheme >> splitterPressedFillStyleFor: aSplitter [
	"Return the pressed splitter fillStyle for the given splitter."
	
	|aColor|
	aColor := self buttonBaseColorFor: aSplitter.
	^(GradientFillStyle ramp: {
			0.0->Color white. 0.6-> aColor.
			1.0->aColor darker})
		origin: aSplitter topLeft;
		direction: (aSplitter splitsTopAndBottom
			ifTrue: [0 @ aSplitter height]
			ifFalse: [aSplitter width @ 0]);
		radial: false
]

{ #category : #'basic-colors' }
GLMUITheme >> subgroupColorFrom: paneColor [
	"Answer the colour for a subgroup given the pane colour."

	^paneColor
]

{ #category : #'border-styles' }
GLMUITheme >> tabLabelNormalBorderStyleFor: aTabLabel [
"	^SimpleBorder new
		width: 0;
		baseColor: (self buttonBaseColorFor: aTabLabel) darker
"	^ self buttonNormalBorderStyleFor: aTabLabel
]

{ #category : #'fill-styles-buttons' }
GLMUITheme >> tabLabelNormalFillStyleFor: aTabLabel [
	^ self buttonNormalFillStyleFor: aTabLabel 
]

{ #category : #'fill-styles-buttons' }
GLMUITheme >> tabLabelSelectedFillStyleFor: aTabLabel [
	^ self buttonSelectedFillStyleFor: aTabLabel 
]

{ #category : #'basic-colors' }
GLMUITheme >> taskbarButtonLabelColorFor: aButton [
	"Answer the colour for the label of the given taskbar button."

	^aButton model
		ifNil: [super taskbarButtonLabelColorFor: aButton]
		ifNotNil: [:win |
			win isActive
				ifTrue: [self buttonBaseColorFor: aButton]
				ifFalse: [super taskbarButtonLabelColorFor: aButton]]
]

{ #category : #'fill-styles' }
GLMUITheme >> taskbarFillStyleFor: aTaskbar [
	^ self buttonNormalFillStyleFor: aTaskbar
]

{ #category : #'fill-styles' }
GLMUITheme >> windowInactiveFillStyleFor: aWindow [
	"Return the window inactive fillStyle for the given window."
	
	^ super windowInactiveFillStyleFor: aWindow
"	^self windowActiveFillStyleFor: aWindow "
]
