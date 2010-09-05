Class {
	#name : #GLMUITheme,
	#superclass : #UIThemeWatery2,
	#category : #'Glamour-Morphic-Theme'
}

{ #category : #accessing }
GLMUITheme class >> baseColor [
	^ Color r: 190 g: 190 b: 190 range: 255
]

{ #category : #accessing }
GLMUITheme class >> baseSelectionColor [
	^ Color r: 0.38 g: 0.64 b: 0.88
]

{ #category : #private }
GLMUITheme class >> importGlamorousIcons [
	"utility method to import the icons necessary for the theme from the file system"
	"self importGlamorousIcons"
	| icons |
	icons := #(
		'glamorousMax'
		'glamorousMin'
		'glamorousClose'
		'glamorousMenu'
		'glamorousMaxInactive'
		'glamorousMinInactive'
		'glamorousCloseInactive'
		'glamorousMenuInactive'
		'glamorousMenuPin'
		'glamorousCheckboxSelected'
		'glamorousCheckboxUnselected'
		'glamorousRadioSelected'
		'glamorousRadioUnselected').
	self importIcons: icons fromFolder: 'icons' inClass: MenuIcons category: '*glamour-morphic-theme'
]

{ #category : #private }
GLMUITheme class >> importIcons: icons fromFolder: aString inClass: aClass category: aCategory [
	icons
		do: [:each |
			| method form |
			form := PNGReadWriter formFromFileNamed: aString, '/', each , '.png'.
			method := each , Character cr asString ,
				(aClass methodStart: each),		
				form storeString,
				aClass methodEnd.
			aClass class compile: method classified: aCategory ].
	aClass initialize
]

{ #category : #settings }
GLMUITheme class >> newDefaultSettings [
	^super newDefaultSettings
		menuColor: self baseColor;
		menuTitleColor: self baseColor;
		windowColor: self baseColor;
		selectionColor: self baseSelectionColor muchLighter;
		menuSelectionColor: self baseSelectionColor twiceLighter;
		progressBarColor: self baseColor;
		standardColorsOnly: true;
		autoSelectionColor: false;
		preferRoundCorner: false;
		flatMenu: true
]

{ #category : #settings }
GLMUITheme class >> setPreferredWorldBackground [
	"self setPreferredWorldBackground"
	World color: (
		(GradientFillStyle 
			ramp: { 0.0 -> Color white.  1.0 -> Color gray})
			origin: 50 @ 50;
			direction: 800@0;
			normal: 0@800;
		radial: true)
]

{ #category : #accessing }
GLMUITheme class >> themeName [
	^ 'Glamorous'
]

{ #category : #'border-styles-buttons' }
GLMUITheme >> buttonCornerStyleIn: aThemedMorph [
	"If asked, we only allow square corners"
	
	^ #square
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
	
	^25
]

{ #category : #defaults }
GLMUITheme >> buttonMinWidth [
	"Answer the minumum width of a button for this theme."
	
	^25
]

{ #category : #'border-styles-buttons' }
GLMUITheme >> buttonNormalBorderStyleFor: aButton [
	"Return the normal button borderStyle for the given button."

	| outerColor innerColor |
	(aButton valueOfProperty: #noBorder ifAbsent: [false]) ifTrue: [
		^ SimpleBorder new width: 0; baseColor: Color transparent ].
	outerColor := (self glamorousBaseColorFor: aButton) darker.
	^SimpleBorder new
					width: 1;
					baseColor: outerColor
]

{ #category : #'fill-styles-buttons' }
GLMUITheme >> buttonNormalFillStyleFor: aButton [
	"Return the normal button fillStyle for the given button."
	
	(aButton valueOfProperty: #noFill ifAbsent: [false]) ifTrue: [^ SolidFillStyle color: Color transparent ].
	^ self glamorousNormalFillStyleFor: aButton height: aButton height
]

{ #category : #'border-styles-buttons' }
GLMUITheme >> buttonSelectedBorderStyleFor: aButton [
	^ self buttonNormalBorderStyleFor: aButton
]

{ #category : #'fill-styles-buttons' }
GLMUITheme >> buttonSelectedFillStyleFor: aButton [
	"Return the normal button fillStyle for the given button."
	
	| toptop top bottom base |
	base := self glamorousBaseColorFor: aButton.
	toptop := base muchLighter.
	top := (self glamorousBaseSelectionColorFor: aButton) muchLighter.
	bottom := base.

	^(GradientFillStyle ramp: {
			0.0->toptop.
			0.1->top.
			0.7->bottom.})
		origin: aButton bounds origin;
		direction: 0 @ aButton height;
		radial: false
]

{ #category : #'fill-styles' }
GLMUITheme >> checkboxForm [
	"Answer the form to use for a normal checkbox."

	^MenuIcons glamorousCheckboxUnselected
]

{ #category : #'fill-styles' }
GLMUITheme >> checkboxSelectedForm [
	"Answer the form to use for a selected checkbox."

	^MenuIcons glamorousCheckboxSelected
]

{ #category : #'border-styles' }
GLMUITheme >> configureWindowBorderFor: aWindow [
	super configureWindowBorderFor: aWindow.
	aWindow roundedCorners: #() "not even top"
]

{ #category : #'label-styles' }
GLMUITheme >> createMenuBoxFor: aSystemWindow [
	"Answer a button for the window menu."
	
"	^aSystemWindow createBox
		labelGraphic: (self windowMenuIconFor: aSystemWindow);
		extent: aSystemWindow boxExtent;
		actWhen: #buttonDown;
		actionSelector: #offerWindowMenu;
		setBalloonText: 'window menu' translated"
	
	|form msb|
	form := self windowMenuForm.
	msb := MultistateButtonMorph new extent: form extent.
	msb activeEnabledNotOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowMenuPassiveForm.
	msb extent: form extent.
	msb activeDisabledNotOverUpFillStyle: (ImageFillStyle form: form).
	msb passiveEnabledNotOverUpFillStyle: (ImageFillStyle form: form).
	msb passiveDisabledNotOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowMenuForm.
	msb extent: form extent.
	msb
		activeEnabledOverUpFillStyle: (ImageFillStyle form: form);
		passiveEnabledOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowMenuPassiveForm.
	msb
		extent: form extent;
		activeEnabledOverDownFillStyle: (ImageFillStyle form: form);
		passiveEnabledOverDownFillStyle: (ImageFillStyle form: form);
		addUpAction: [aSystemWindow offerWindowMenu];
		setBalloonText: 'window menu' translated;
		extent: aSystemWindow boxExtent.
	^msb
]

{ #category : #'fill-styles' }
GLMUITheme >> dockingBarNormalFillStyleFor: aToolDockingBar [
	^ SolidFillStyle color: Color transparent
]

{ #category : #'border-styles' }
GLMUITheme >> dropListNormalBorderStyleFor: aDropList [
	"Return the normal borderStyle for the given drop list"

	^ self buttonNormalBorderStyleFor: aDropList
]

{ #category : #'fill-styles' }
GLMUITheme >> dropListNormalFillStyleFor: aDropList [
	"Return the normal fillStyle for the given drop list."
	
	^ SolidFillStyle color: Color white
]

{ #category : #private }
GLMUITheme >> glamorousBaseColorFor: aButton [
	^ self class baseColor
	"unfortunately, it looks like paneColor does not always return the wanted color"
	"aButton paneColorOrNil ifNil: [Color r: 200 g: 200 b: 200 range: 255]"
]

{ #category : #private }
GLMUITheme >> glamorousBaseSelectionColorFor: aButton [
	^ self class baseSelectionColor
	
	"unfortunately, it looks like paneColor does not always return the wanted color"
	"aButton paneColorOrNil ifNil: [Color r: 200 g: 200 b: 200 range: 255]"
]

{ #category : #private }
GLMUITheme >> glamorousNormalFillStyleFor: aMorph height: anInteger [
	"Return the normal button fillStyle for the given button."
	
	| toptop top bottom base |
	base := self glamorousBaseColorFor: aMorph.
	toptop := base twiceLighter lighter.
	top := base twiceLighter.
	bottom := base.
	^(GradientFillStyle ramp: {
			0.0->toptop.
			0.1->top.
			0.7->bottom.})
		origin: aMorph bounds origin;
		direction: 0 @ anInteger;
		radial: false
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

{ #category : #'label-styles' }
GLMUITheme >> menuPinForm [
	"Answer the form to use for the pin button of a menu."

	^MenuIcons glamorousMenuPin
]

{ #category : #'morph creation' }
GLMUITheme >> newFocusIndicatorMorphFor: aMorph [
	"Answer a new focus indicator for the given morph."

	|radius|
	radius := aMorph focusIndicatorCornerRadius.
	^ BorderedMorph new
		fillStyle: Color transparent;
		borderStyle: (SimpleBorder new
			 width: 1;
			baseColor: (self glamorousBaseSelectionColorFor: aMorph) lighter);
		bounds: aMorph focusBounds
]

{ #category : #'initialize-release' }
GLMUITheme >> newWindowCloseForm [
	"Answer a new form for a window close box."

	^ MenuIcons glamorousClose
]

{ #category : #'initialize-release' }
GLMUITheme >> newWindowMaximizeForm [
	"Answer a new form for a window maximize box."

	^ MenuIcons glamorousMax
]

{ #category : #'initialize-release' }
GLMUITheme >> newWindowMenuForm [
	"Answer a new form for a window menu box."

	^ MenuIcons glamorousMenu
]

{ #category : #'initialize-release' }
GLMUITheme >> newWindowMenuPassiveForm [
	"Answer a new form for a window menu box."

	^ MenuIcons glamorousMenuInactive
]

{ #category : #'initialize-release' }
GLMUITheme >> newWindowMinimizeForm [
	"Answer a new form for a window minimize box."

	^ MenuIcons glamorousMin
]

{ #category : #'border-styles' }
GLMUITheme >> plainGroupPanelBorderStyleFor: aGroupPanel [
	"Answer the normal border style for a plain group panel."

	^SimpleBorder new
		width: 1;
		baseColor: Color transparent
]

{ #category : #'fill-styles' }
GLMUITheme >> progressBarFillStyleFor: aProgressBar [
	^ (self glamorousBaseColorFor: aProgressBar) muchLighter
]

{ #category : #'fill-styles' }
GLMUITheme >> progressBarProgressFillStyleFor: aProgressBar [
	^ self class baseSelectionColor muchLighter
]

{ #category : #'fill-styles' }
GLMUITheme >> radioButtonForm [
	"Answer the form to use for a normal radio button."

	^MenuIcons glamorousRadioUnselected 
]

{ #category : #'fill-styles' }
GLMUITheme >> radioButtonSelectedForm [
	"Answer the form to use for a selected radio button."

	^MenuIcons glamorousRadioSelected 
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
	
	^ "(self glamorousBaseColorFor: aScrollbar) muchLighter"
	Color r: 245 g: 245 b: 245 range: 255
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
GLMUITheme >> separatorFillStyleFor: aSeparator [
	"Return the separator fillStyle for the given separator."
	
	^ SolidFillStyle color: (self glamorousBaseColorFor: aSeparator) darker
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
	aColor := self glamorousBaseColorFor: aSplitter.
	^(GradientFillStyle ramp: {0.0->aColor lighter. 0.9-> aColor})
		origin: aSplitter topLeft;
		direction: (aSplitter splitsTopAndBottom
			ifTrue: [0 @ aSplitter height]
			ifFalse: [aSplitter width @ 0]);
		radial: false
]

{ #category : #'basic-colors' }
GLMUITheme >> subgroupColorFrom: paneColor [
	"Answer the colour for a subgroup given the pane colour."

	^ self class baseColor "paneColor"
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

{ #category : #'border-styles' }
GLMUITheme >> tabPanelBorderStyleFor: aTabGroup [
	"Answer the normal border style for a tab panel."

	^ TabPanelBorder new
		width: 1;
		baseColor: ((self glamorousBaseColorFor: aTabGroup));
		tabSelector: aTabGroup tabSelectorMorph
]

{ #category : #'basic-colors' }
GLMUITheme >> taskbarButtonLabelColorFor: aButton [
	"Answer the colour for the label of the given taskbar button."

	^aButton model
		ifNil: [super taskbarButtonLabelColorFor: aButton]
		ifNotNil: [:win |
			win isActive
				ifTrue: [self class baseSelectionColor muchDarker]
				ifFalse: [Color black]]
]

{ #category : #'fill-styles' }
GLMUITheme >> taskbarFillStyleFor: aTaskbar [
	^ self buttonNormalFillStyleFor: aTaskbar
]

{ #category : #'border-styles' }
GLMUITheme >> taskbarThumbnailCornerStyleFor: aMorph [
	"Answer the corner style for the taskbar thumbnail/tasklist."
	
	^#square
]

{ #category : #'border-styles' }
GLMUITheme >> taskbarThumbnailNormalBorderStyleFor: aWindow [
	^ self buttonNormalBorderStyleFor: aWindow
]

{ #category : #'fill-styles' }
GLMUITheme >> tasklistFillStyleFor: aTasklist [
	"Return the tasklist fillStyle for the given tasklist."
	
	|aColor|
	aColor := aTasklist color.
	^(GradientFillStyle ramp: {
			0.0->aColor whiter whiter. 0.2->aColor lighter.
			0.8->aColor darker. 1.0->aColor blacker})
		origin: aTasklist topLeft;
		direction: 0 @ aTasklist height;
		radial: false
]

{ #category : #'border-styles' }
GLMUITheme >> textEditorNormalBorderStyleFor: aTextEditor [
	"Return the normal text editor borderStyle for the given text editor."

	^self buttonNormalBorderStyleFor: aTextEditor
]

{ #category : #scrollbars }
GLMUITheme >> verticesForSimpleArrow: aRectangle [ 
	"PRIVATE - answer a collection of vertices to draw a simple arrow"
	| vertices |
	vertices := OrderedCollection new.
	""
	vertices add: aRectangle bottomLeft.
	vertices add: aRectangle center x @ (aRectangle top + (aRectangle width / 8)).
	vertices add: aRectangle bottomRight.
	vertices add: aRectangle bottomRight + (0@0.01).
	""
	^ vertices
"	| vertices |
	vertices := OrderedCollection new.
	vertices add: (aRectangle center x - (aRectangle width / 4)) @ (aRectangle bottom - 8).
	vertices add: aRectangle center x @ (aRectangle top).
	vertices add: (aRectangle center x + (aRectangle width / 4)) @ (aRectangle bottom - 8).
	vertices add: (aRectangle center x + (aRectangle width / 4)) @ (aRectangle bottom - 8) + (0@0.01).
	^ vertices"
"	^ super verticesForSimpleArrow: aRectangle "
]

{ #category : #'fill-styles' }
GLMUITheme >> windowActiveFillStyleFor: aWindow [
	"We do not want the lighting effect when the window goes inactive"
	^SolidFillStyle color: self class baseColor
]

{ #category : #'fill-styles' }
GLMUITheme >> windowActiveTitleFillStyleFor: aWindow [
	^ self glamorousNormalFillStyleFor: aWindow height: aWindow labelHeight
]

{ #category : #'label-styles' }
GLMUITheme >> windowClosePassiveForm [
	"Answer the form to use for passive (background) window close buttons"

	^MenuIcons glamorousCloseInactive
]

{ #category : #'fill-styles' }
GLMUITheme >> windowInactiveFillStyleFor: aWindow [
	"We do not want the lighting effect when the window goes inactive"
	^self windowActiveFillStyleFor: aWindow
]

{ #category : #'fill-styles' }
GLMUITheme >> windowInactiveTitleFillStyleFor: aWindow [
	"We do not want the lighting effect when the window goes inactive"
	^self windowActiveTitleFillStyleFor: aWindow
]

{ #category : #'label-styles' }
GLMUITheme >> windowMaximizePassiveForm [
	"Answer the form to use for passive (background) window maximize/restore buttons"

	^MenuIcons glamorousMaxInactive
]

{ #category : #'label-styles' }
GLMUITheme >> windowMenuPassiveForm [
	"Answer the form to use for passive (background) window menu buttons"

	^self newWindowMenuPassiveForm
]

{ #category : #'label-styles' }
GLMUITheme >> windowMinimizePassiveForm [
	"Answer the form to use for passive (background) window minimize buttons"

	^MenuIcons glamorousMinInactive
]
