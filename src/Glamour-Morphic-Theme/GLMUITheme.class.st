"
self defaultSettings: nil.
self beCurrent. 
"
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
GLMUITheme class >> basePassiveBackgroundColor [
	^ Color r: 245 g: 245 b: 245 range: 255
]

{ #category : #accessing }
GLMUITheme class >> baseSelectionColor [
	^ Color r: 97 g: 163 b: 225 range: 255
]

{ #category : #accessing }
GLMUITheme class >> darkBaseColor [
	^ Color r: 180 g: 180 b: 180 range: 255
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
	self importIcons: icons fromFolder: 'icons' inClass: GLMUIThemeIcons category: '*glamour-morphic-theme'
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

{ #category : #accessing }
GLMUITheme class >> lightBaseColor [
	^ Color r: 200 g: 200 b: 200 range: 255
]

{ #category : #accessing }
GLMUITheme class >> lightSelectionColor [
	^ Color r: 175 g: 213 b: 250 range: 255
]

{ #category : #settings }
GLMUITheme class >> newDefaultSettings [
	BalloonMorph setBalloonColorTo: self lightSelectionColor.
	^super newDefaultSettings
		menuColor: self baseColor;
		menuTitleColor: self baseColor;
		windowColor: self baseColor;
		selectionColor: self lightSelectionColor;
		menuSelectionColor: self baseSelectionColor;
		progressBarColor: self baseColor;
		standardColorsOnly: true;
		autoSelectionColor: false;
		preferRoundCorner: false;
		flatMenu: true
]

{ #category : #settings }
GLMUITheme class >> setPreferredWorldBackground [
	"self setPreferredWorldBackground"
	"World color: (
		(GradientFillStyle 
			ramp: { 0.0 -> Color white.  1.0 -> Color gray})
			origin: 50 @ 50;
			direction: 800@0;
			normal: 0@800;
		radial: true)"
	World color: Color white
]

{ #category : #accessing }
GLMUITheme class >> themeName [
	^ 'Glamorous'
]

{ #category : #accessing }
GLMUITheme class >> veryLightSelectionColor [
	^ Color r: 218 g: 234 b: 250 range: 255
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
	
	^24
]

{ #category : #defaults }
GLMUITheme >> buttonMinWidth [
	"Answer the minumum width of a button for this theme."
	
	^24
]

{ #category : #'border-styles-buttons' }
GLMUITheme >> buttonNormalBorderStyleFor: aButton [
	"Return the normal button borderStyle for the given button."

	| outerColor innerColor |
	(aButton valueOfProperty: #noBorder ifAbsent: [false]) ifTrue: [
		^ SimpleBorder new width: 0; baseColor: Color transparent ].
	outerColor := self glamorousDarkBaseColorFor: aButton.
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
	
	| top bottom |
	top := self glamorousLightSelectionColorFor: aButton.
	bottom := self glamorousLightColorFor: aButton.

	^(GradientFillStyle ramp: {
			0.0->top.
			0.7->bottom.})
		origin: aButton bounds origin;
		direction: 0 @ aButton height;
		radial: false
]

{ #category : #forms }
GLMUITheme >> checkboxForm [
	"Answer the form to use for a normal checkbox."

	^self  checkboxUnselectedForm
]

{ #category : #forms }
GLMUITheme >> checkboxSelectedForm [
	"Answer the form to use for a selected checkbox."

	^GLMUIThemeIcons checkboxSelectedForm
]

{ #category : #forms }
GLMUITheme >> checkboxUnselectedForm [
	"Answer the form to use for a selected checkbox."

	^ GLMUIThemeIcons checkboxUnselectedForm
]

{ #category : #'border-styles' }
GLMUITheme >> configureWindowBorderFor: aWindow [
"	super configureWindowBorderFor: aWindow.
	aWindow roundedCorners: #()"
		| aStyle |
	
	
	aStyle := 
		SimpleBorder new 
			color: (Color black alpha: 0.5);
			width: 1.
			
	aWindow borderStyle: aStyle.
]

{ #category : #'border-styles' }
GLMUITheme >> configureWindowDropShadowFor: aWindow [

	aWindow hasDropShadow: false
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

{ #category : #'fill-styles' }
GLMUITheme >> dropListDisabledFillStyleFor: aDropList [
	"Return the disabled fillStyle for the given drop list."
	
	^ self textEditorDisabledFillStyleFor: aDropList
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

{ #category : #'fill-styles' }
GLMUITheme >> expanderTitleNormalFillStyleFor: anExpanderTitle [
	"Return the normal expander title fillStyle for the given expander title."
	
	^ self buttonNormalFillStyleFor: anExpanderTitle
]

{ #category : #private }
GLMUITheme >> glamorousBaseColorFor: aButton [
	^ self class baseColor
	"unfortunately, it looks like paneColor does not always return the wanted color"
	"aButton paneColorOrNil ifNil: [Color r: 200 g: 200 b: 200 range: 255]"
]

{ #category : #private }
GLMUITheme >> glamorousBasePassiveBackgroundColorFor: aButton [
	^ self class basePassiveBackgroundColor
]

{ #category : #private }
GLMUITheme >> glamorousBaseSelectionColorFor: aButton [
	^ self class baseSelectionColor
]

{ #category : #private }
GLMUITheme >> glamorousDarkBaseColorFor: aButton [
	^ self class darkBaseColor
]

{ #category : #private }
GLMUITheme >> glamorousLightColorFor: aButton [
	^ self class lightBaseColor
]

{ #category : #private }
GLMUITheme >> glamorousLightSelectionColorFor: aMorph [
	^ self class lightSelectionColor
]

{ #category : #private }
GLMUITheme >> glamorousNormalFillStyleFor: aMorph height: anInteger [
	"Return the normal button fillStyle for the given button."
	
	| baseColor |
	baseColor := self glamorousBaseColorFor: aMorph.
	^ self glamorousNormalFillStyleWithBaseColor: baseColor for: aMorph height: anInteger

]

{ #category : #private }
GLMUITheme >> glamorousNormalFillStyleWithBaseColor: aColor for: aMorph height: anInteger [
	
	| top bottom |
	top := aColor twiceLighter.
	bottom := aColor.
	^(GradientFillStyle ramp: {
			0.0->top.
			0.7->bottom.})
		origin: aMorph bounds origin;
		direction: 0 @ anInteger;
		radial: false
]

{ #category : #'border-styles' }
GLMUITheme >> groupPanelBorderStyleFor: aGroupPanel [
	"Answer the normal border style for a group panel."

	^ SimpleBorder new
		width: 1;
		baseColor: ((self glamorousBaseColorFor: aGroupPanel))
]

{ #category : #'initialize-release' }
GLMUITheme >> initialize [
	"self beCurrent"

	super initialize.
	self windowActiveDropShadowStyle: #nodiffuse
]

{ #category : #'fill-styles' }
GLMUITheme >> listDisabledFillStyleFor: aList [
	"Return the disabled fillStyle for the given list."
	
	^ self textEditorDisabledFillStyleFor: aList
]

{ #category : #'fill-styles-buttons' }
GLMUITheme >> menuItemInDockingBarSelectedFillStyleFor: aMenuItem [
	"Answer the selected fill style to use for the given menu item that is in a docking bar."
	^ self buttonSelectedFillStyleFor: aMenuItem
]

{ #category : #forms }
GLMUITheme >> menuPinForm [
	"Answer the form to use for the pin button of a menu."

	^ GLMUIThemeIcons menuPinForm
]

{ #category : #forms }
GLMUITheme >> newCheckboxMarkerForm [
	"Answer a new checkbox marker form."

	^GLMUIThemeIcons checkboxMarkerForm
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
			baseColor: (self glamorousBaseSelectionColorFor: aMorph));
		bounds: aMorph focusBounds
]

{ #category : #forms }
GLMUITheme >> newRadioButtonMarkerForm [
	"Answer a new radio button marker form. We make it empty because we already have the selected radio button take care of the state."

	^GLMUIThemeIcons radioButtonMarkerForm  
]

{ #category : #'initialize-release' }
GLMUITheme >> newRadioMarkerForm [
	"Answer a new checkbox marker form."

	^Form extent: 12@12 depth: 32
]

{ #category : #forms }
GLMUITheme >> newWindowCloseForm [
	"Answer a new form for a window close box."

	^ GLMUIThemeIcons windowCloseForm 
]

{ #category : #forms }
GLMUITheme >> newWindowCloseOverForm [
	"Answer a new form for a window menu box."

	^ self newWindowCloseForm
]

{ #category : #forms }
GLMUITheme >> newWindowMaximizeForm [
	"Answer a new form for a window maximize box."

	^ GLMUIThemeIcons windowMaximizeForm
]

{ #category : #forms }
GLMUITheme >> newWindowMaximizeOverForm [
	"Answer a new form for a window menu box."

	^ self newWindowMaximizeForm
]

{ #category : #forms }
GLMUITheme >> newWindowMenuForm [
	"Answer a new form for a window menu box."

	^ GLMUIThemeIcons windowMenuForm
]

{ #category : #forms }
GLMUITheme >> newWindowMenuPassiveForm [
	"Answer a new form for a window menu box."

	^ GLMUIThemeIcons windowMenuInactiveForm
]

{ #category : #forms }
GLMUITheme >> newWindowMinimizeForm [
	"Answer a new form for a window minimize box."

	^ GLMUIThemeIcons windowMinimizeForm
]

{ #category : #forms }
GLMUITheme >> newWindowMinimizeOverForm [
	"Answer a new form for a window menu box."

	^ self newWindowMinimizeForm
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
	^ self glamorousBasePassiveBackgroundColorFor: aProgressBar
]

{ #category : #'fill-styles' }
GLMUITheme >> progressBarProgressFillStyleFor: aProgressBar [
	^ (self glamorousLightSelectionColorFor: aProgressBar)
]

{ #category : #forms }
GLMUITheme >> radioButtonForm [
	"Answer the form to use for a normal radio button."

	^ GLMUIThemeIcons radioButtonUnselectedForm
]

{ #category : #forms }
GLMUITheme >> radioButtonSelectedForm [
	"Answer the form to use for a selected radio button."

	^ GLMUIThemeIcons radioButtonSelectedForm 
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
	
	^ self scrollbarNormalThumbFillStyleFor: aScrollbar
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
	
	^ (self glamorousNormalFillStyleWithBaseColor: aScrollbar paneColor for:  aScrollbar height: aScrollbar height)
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
GLMUITheme >> sliderDisabledFillStyleFor: aSlider [
	"Return the disabled fillStyle for the given slider."
	
	^ self textEditorDisabledFillStyleFor: aSlider
]

{ #category : #'fill-styles' }
GLMUITheme >> splitterNormalFillStyleFor: aSplitter [
	"Return the normal splitter fillStyle for the given splitter."
	
	^ SolidFillStyle color: Color transparent
]

{ #category : #'fill-styles' }
GLMUITheme >> splitterPressedFillStyleFor: aSplitter [
	"Return the pressed splitter fillStyle for the given splitter."
	
	|aColor|
	aColor := self glamorousBaseColorFor: aSplitter.
	^ (GradientFillStyle ramp: {0.0->aColor lighter. 0.9-> aColor})
		origin: aSplitter topLeft;
		direction: (aSplitter splitsTopAndBottom
			ifTrue: [0 @ aSplitter height]
			ifFalse: [aSplitter width @ 0]);
		radial: false
]

{ #category : #'basic-colors' }
GLMUITheme >> subgroupColorFrom: paneColor [
	"Answer the colour for a subgroup given the pane colour."

	^ self glamorousLightColorFor: paneColor" self class baseColor"
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
	^ GLMTabPanelBorder new 
		width: 1;
		baseColor: ((self glamorousDarkBaseColorFor: aTabGroup));
		tabSelector: aTabGroup tabSelectorMorph
]

{ #category : #'basic-colors' }
GLMUITheme >> taskbarButtonLabelColorFor: aButton [
	"Answer the colour for the label of the given taskbar button."

	^aButton model
		ifNil: [super taskbarButtonLabelColorFor: aButton]
		ifNotNil: [:win |
			win isActive
				ifTrue: [Color black]
				ifFalse: [Color gray darker]]
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
GLMUITheme >> textEditorDisabledFillStyleFor: aTextEditor [
	"Return the disabled fillStyle for the given text editor."
	
	^self glamorousBasePassiveBackgroundColorFor: aTextEditor
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

{ #category : #forms }
GLMUITheme >> windowClosePassiveForm [
	"Answer the form to use for passive (background) window close buttons"

	^GLMUIThemeIcons windowCloseInactiveForm
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

{ #category : #forms }
GLMUITheme >> windowMaximizePassiveForm [
	"Answer the form to use for passive (background) window maximize/restore buttons"

	^GLMUIThemeIcons windowMaximizeInactiveForm
]

{ #category : #'label-styles' }
GLMUITheme >> windowMenuPassiveForm [
	"Answer the form to use for passive (background) window menu buttons"

	^self newWindowMenuPassiveForm
]

{ #category : #forms }
GLMUITheme >> windowMinimizePassiveForm [
	"Answer the form to use for passive (background) window minimize buttons"

	^GLMUIThemeIcons windowMinimizeInactiveForm
]
