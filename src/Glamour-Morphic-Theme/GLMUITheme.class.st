"
The theme is developed in the context of the Glamour project, and its goal is to create a look that:
- does not look like a specific operating system. In particular, the icons should be operating system agnostic, because, for example, people in Windows are confused by the red, yellow, green buttons of apple.
- uses a limited amount of colors and effects.
- is fast.

self defaultSettings: nil.
self beCurrent. 
self setPreferredShoutColors
"
Class {
	#name : #GLMUITheme,
	#superclass : #UIThemeWatery,
	#category : #'Glamour-Morphic-Theme'
}

{ #category : #accessing }
GLMUITheme class >> baseColor [
	^ Color r: 210 g: 210 b: 210 range: 255
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
	^ Color r: 200 g: 200 b: 200 range: 255
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

{ #category : #testing }
GLMUITheme class >> isAbstract [
	"Answer whether the receiver is considered to be abstract."

	^false
]

{ #category : #accessing }
GLMUITheme class >> lightBaseColor [
	^ Color r: 230 g: 230 b: 230 range: 255
]

{ #category : #accessing }
GLMUITheme class >> lightSelectionColor [
	^ Color r: 175 g: 213 b: 250 range: 255
]

{ #category : #settings }
GLMUITheme class >> newDefaultSettings [
	self setPreferredPreferences.
	
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
		fadedBackgroundWindows: false;
		secondarySelectionColor: self veryLightSelectionColor;
		flatMenu: true
]

{ #category : #settings }
GLMUITheme class >> setPreferredPreferences [
	NECPreferences 
		expandPrefixes: true;
		popupShowWithShortcut: Character tab asShortcut.
]

{ #category : #settings }
GLMUITheme class >> setPreferredShoutColors [
	"self setPreferredShoutColors"
	SHTextStylerST80 styleTable: 
		#(
			"(symbol color [emphasisSymbolOrArray [textStyleName [pixelHeight]]])" 
			(default 								black)
			(invalid 									red)
			(excessCode 							red)
			(comment 								(gray darker))
			(unfinishedComment 					(red muchDarker))
			(#'$' 									(red muchDarker))
			(character 								(red muchDarker))
			(integer 								(red muchDarker))
			(number 								(red muchDarker)) 
			(#- 										(red muchDarker))
			(symbol 								(magenta muchDarker)) 
			(stringSymbol 							(magenta muchDarker)) 
			(literalArray 							(magenta muchDarker))
			(string 									(magenta muchDarker) normal)
			(unfinishedString 						red normal)
			(assignment 								nil)
			(ansiAssignment 						nil)
			(literal 									nil italic)
			(keyword 									(black))
			(binary 									(black)) 
			(unary 									(black))
			(incompleteIdentifier 				(gray muchDarker))
			(incompleteKeyword 					(gray muchDarker))
			(incompleteBinary 						(gray muchDarker)) 
			(incompleteUnary 						(gray muchDarker))
			(undefinedIdentifier 					red)
			(undefinedKeyword 						red)
			(undefinedBinary 						red) 
			(undefinedUnary 						red) 
			(patternKeyword 						nil bold)
			(patternBinary 							nil bold)
			(patternUnary 							nil bold) 
			(#self 									(cyan muchDarker ))
			(#super 								(cyan muchDarker ))
			(#true 									(red muchDarker))
			(#false 									(red muchDarker))
			(#nil 									(red muchDarker))
			(#thisContext 							(cyan muchDarker ))
			(#return 								(cyan muchDarker ) bold)
			(patternArg 							(blue muchDarker)) 
			(methodArg 							(blue muchDarker))
			(blockPatternArg 						(blue muchDarker))
			(blockArg 								(blue muchDarker))
			(argument 								(blue muchDarker))
			(blockArgColon 						black)
			(leftParenthesis 						black)
			(rightParenthesis 						black)
			(leftParenthesis1 						(green muchDarker))
			(rightParenthesis1 						(green muchDarker))
			(leftParenthesis2 						(magenta muchDarker))
			(rightParenthesis2 						(magenta muchDarker))
			(leftParenthesis3 						(red muchDarker))
			(rightParenthesis3 						(red muchDarker))
			(leftParenthesis4 						(green darker))
			(rightParenthesis4 						(green darker))
			(leftParenthesis5 						(orange darker))
			(rightParenthesis5 						(orange darker))
			(leftParenthesis6 						(magenta darker))
			(rightParenthesis6 						(magenta darker))
			(leftParenthesis7 						blue)
			(rightParenthesis7 						blue)
			(blockStart 								black)
			(blockEnd 								black)
			(blockStart1 							(green muchDarker))
			(blockEnd1 								(green muchDarker))
			(blockStart2 							(magenta muchDarker))
			(blockEnd2 								(magenta muchDarker))
			(blockStart3 							(red muchDarker))
			(blockEnd3 								(red muchDarker))
			(blockStart4 							(green darker))
			(blockEnd4 								(green darker))
			(blockStart5 							(orange darker))
			(blockEnd5 								(orange darker))
			(blockStart6 							(magenta darker))
			(blockEnd6 								(magenta darker))
			(blockStart7 							blue)
			(blockEnd7 								blue) 
			(arrayStart 								black)
			(arrayEnd 								black)
			(arrayStart1 							black)
			(arrayEnd1 								black)
			(leftBrace 								black)
			(rightBrace 								black)
			(cascadeSeparator 					black)
			(statementSeparator 					black)
			(externalCallType 						black)
			(externalCallTypePointerIndicator 		black)
			(primitiveOrExternalCallStart 			black bold)
			(primitiveOrExternalCallEnd 			black bold)
			(methodTempBar 						(black))
			(blockTempBar 						(black))
			(blockArgsBar 							(black))
			(primitive 								(green muchDarker))
			(pragmaKeyword 						(green muchDarker))
			(pragmaUnary 							(green muchDarker))
			(pragmaBinary 							(green muchDarker)) 
			(externalFunctionCallingConvention 	(green muchDarker) bold)
			(module 								(green muchDarker) bold)
			(blockTempVar 						(blue muchDarker))
			(blockPatternTempVar 					(blue muchDarker))
			(instVar 								(blue muchDarker))
			(workspaceVar 							(blue muchDarker))
			(tempVar 								(blue muchDarker))
			(patternTempVar 						(blue muchDarker))
			(poolConstant 							(blue muchDarker))
			(classVar 								(blue muchDarker))
			(globalVar 								(blue muchDarker)))

]

{ #category : #settings }
GLMUITheme class >> setPreferredWorldBackground [
	"self setPreferredWorldBackground"
	World color: Color white
]

{ #category : #accessing }
GLMUITheme class >> themeName [
	^ 'Glamorous'
]

{ #category : #accessing }
GLMUITheme class >> veryLightSelectionColor [
	^ self lightSelectionColor muchLighter
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

{ #category : #'watcher window' }
GLMUITheme >> configureWatcherWindowLabelAreaFor: aWindow [
	"Configure the label area for the given Watcher window."

	|padding|
	padding := 0.
	aWindow labelArea
		addMorphBack: (Morph new extent: aWindow class borderWidth @ 0).
	aWindow hasCloseBox ifTrue: [aWindow addCloseBox. padding := padding + 1].
"	aWindow hasCollapseBox ifTrue: [aWindow addCollapseBox. padding := padding + 1].
	aWindow hasExpandBox ifTrue: [aWindow addExpandBox. padding := padding + 1].
	aWindow hasMenuBox ifTrue: [padding := padding - 1].
"	aWindow labelArea
		addMorphBack: (Morph new extent: aWindow class borderWidth @ 0; hResizing: #spaceFill).
	aWindow basicLabel ifNotNil: [:label | aWindow labelArea addMorphBack: label; hResizing: #shrinkWrap].
	aWindow labelArea
		addMorphBack: (Morph new extent: aWindow class borderWidth @ 0; hResizing: #spaceFill).
	padding > 0 ifTrue: [
		aWindow labelArea
			addMorphBack: (Morph new extent: (aWindow boxExtent x * padding) @ 0)].
"	aWindow hasMenuBox ifTrue: [aWindow addMenuControl]."
	aWindow labelArea
		addMorphBack: (Morph new extent: aWindow class borderWidth @ 0)
]

{ #category : #'border-styles' }
GLMUITheme >> configureWindowBorderFor: aWindow [
"	super configureWindowBorderFor: aWindow.
	aWindow roundedCorners: #()"
	| aStyle |
	
	aStyle := 
		SimpleBorder new 
			color: (Color lightGray);
			width: 1.
			
	aWindow borderStyle: aStyle.
]

{ #category : #'border-styles' }
GLMUITheme >> configureWindowDropShadowFor: aWindow [

	aWindow hasDropShadow: false
]

{ #category : #'label-styles' }
GLMUITheme >> configureWindowLabelAreaFor: aWindow [
	"Configure the label area for the given window."

	|padding|
	padding := 0.
	aWindow labelArea
		addMorphBack: (Morph new extent: aWindow class borderWidth @ 0).
	aWindow hasCloseBox ifTrue: [aWindow addCloseBox. padding := padding + 1].
	aWindow hasCollapseBox ifTrue: [aWindow addCollapseBox. padding := padding + 1].
	aWindow hasExpandBox ifTrue: [aWindow addExpandBox. padding := padding + 1].
	aWindow hasMenuBox ifTrue: [padding := padding - 1].
	aWindow labelArea
		addMorphBack: (Morph new extent: aWindow class borderWidth @ 0; hResizing: #spaceFill).
	aWindow basicLabel ifNotNil: [:label | aWindow labelArea addMorphBack: label; hResizing: #shrinkWrap].
	aWindow labelArea
		addMorphBack: (Morph new extent: aWindow class borderWidth @ 0; hResizing: #spaceFill).
	padding > 0 ifTrue: [
		aWindow labelArea
			addMorphBack: (Morph new extent: (aWindow boxExtent x * padding) @ 0)].
	aWindow hasMenuBox ifTrue: [aWindow addMenuControl].
	aWindow labelArea
		addMorphBack: (Morph new extent: aWindow class borderWidth @ 0)
]

{ #category : #'label-styles' }
GLMUITheme >> createCollapseBoxFor: aSystemWindow [
	"Answer a button for minimising the window."
	
	|form msb|
	form := self windowMinimizeForm.
	msb := MultistateButtonMorph new extent: form extent.
	msb activeEnabledNotOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowMinimizePassiveForm.
	msb extent: form extent.
	msb passiveEnabledNotOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowMinimizeOverForm.
	msb extent: form extent.
	msb
		activeEnabledOverUpFillStyle: (ImageFillStyle form: form);
		passiveEnabledOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowMinimizePassiveForm.
	msb
		extent: form extent;
		activeEnabledOverDownFillStyle: (ImageFillStyle form: form);
		passiveEnabledOverDownFillStyle: (ImageFillStyle form: form);
		addUpAction: [aSystemWindow collapseBoxHit];
		setBalloonText: 'Collapse this window' translated;
		extent: aSystemWindow boxExtent.
	^msb
]

{ #category : #'label-styles' }
GLMUITheme >> createExpandBoxFor: aSystemWindow [
	"Answer a button for maximising/restoring the window."
	
	|form msb|
	form := self windowMaximizeForm.
	msb := MultistateButtonMorph new extent: form extent.
	msb activeEnabledNotOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowMaximizePassiveForm.
	msb extent: form extent.
	msb passiveEnabledNotOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowMaximizeOverForm.
	msb extent: form extent.
	msb
		activeEnabledOverUpFillStyle: (ImageFillStyle form: form);
		passiveEnabledOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowMaximizePassiveForm.
	msb
		extent: form extent;
		activeEnabledOverDownFillStyle: (ImageFillStyle form: form);
		passiveEnabledOverDownFillStyle: (ImageFillStyle form: form);
		addUpAction: [aSystemWindow expandBoxHit];
		setBalloonText: 'Expand to full screen' translated;
		extent: aSystemWindow boxExtent.
	^msb
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

{ #category : #defaults }
GLMUITheme >> dialogWindowPreferredCornerStyleFor: aDialogWindow [
	"Answer the preferred corner style for the given dialog."

	^#square
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
	
"	| baseColor |
	baseColor := self glamorousBaseColorFor: aMorph.
	^ self glamorousNormalFillStyleWithBaseColor: baseColor for: aMorph height: anInteger
"

	^ SolidFillStyle color: (self glamorousLightColorFor: aMorph)
]

{ #category : #private }
GLMUITheme >> glamorousNormalFillStyleWithBaseColor: aColor for: aMorph height: anInteger [	
	| top bottom |
	top := aColor darker.
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

{ #category : #'growl - specific' }
GLMUITheme >> growlBorderColorFor: aGrowlMorph [
	^ Color white alpha: 0.5
]

{ #category : #'growl - specific' }
GLMUITheme >> growlContentsColorFor: aGrowlMorph [
	^ Color white
]

{ #category : #'growl - specific' }
GLMUITheme >> growlDismissHandleFor: aGrowlMorph [
	| form image |
	form := self windowCloseForm.
	image := ImageMorph new.
	image image: form.
	image color: Color yellow.
	^ image
]

{ #category : #'growl - specific' }
GLMUITheme >> growlFillColorFor: aGrowlMorph [
	^ Color darkGray alpha: 0.5
]

{ #category : #'growl - specific' }
GLMUITheme >> growlLabelColorFor: aGrowlMorph [
	^ Color white twiceDarker
]

{ #category : #'initialize-release' }
GLMUITheme >> initialize [
	"self beCurrent"

	super initialize.
	self windowActiveDropShadowStyle: #diffuse
]

{ #category : #'initialize-release' }
GLMUITheme >> initializeForms [
	"Initialize the receiver's image forms."

	|inactiveForm|
	super initializeForms.
	inactiveForm := self newWindowInactiveControlForm.
	self forms
		at: #windowCloseOver put: self newWindowCloseOverForm;
		at: #windowMinimizeOver put: self newWindowMinimizeOverForm;
		at: #windowMaximizeOver put: self newWindowMaximizeOverForm;
		at: #windowClosePassive put: inactiveForm;
		at: #windowMinimizePassive put: inactiveForm;
		at: #windowMaximizePassive put: inactiveForm
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

{ #category : #'fill-styles' }
GLMUITheme >> morphTreeSplitterNormalFillStyleFor: aSplitter [	
	^ self splitterNormalFillStyleFor: aSplitter
]

{ #category : #'fill-styles' }
GLMUITheme >> morphTreeSplitterPressedFillStyleFor: aSplitter [	
	^ self splitterPressedFillStyleFor: aSplitter
]

{ #category : #forms }
GLMUITheme >> newCheckboxMarkerForm [
	"Answer a new checkbox marker form."

	^GLMUIThemeIcons checkboxMarkerForm
]

{ #category : #'morph creation' }
GLMUITheme >> newCloseControlIn: aThemedMorph for: aModel action: aValuable help: helpText [
	"Answer a button for closing things."
	
	|form msb|
	form := self windowCloseForm.
	msb := MultistateButtonMorph new extent: form extent.
	msb activeEnabledNotOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowClosePassiveForm.
	msb extent: form extent.
	msb activeDisabledNotOverUpFillStyle: (ImageFillStyle form: form).
	msb passiveEnabledNotOverUpFillStyle: (ImageFillStyle form: form).
	msb passiveDisabledNotOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowCloseOverForm.
	msb extent: form extent.
	msb
		activeEnabledOverUpFillStyle: (ImageFillStyle form: form);
		passiveEnabledOverUpFillStyle: (ImageFillStyle form: form).
	form := self windowClosePassiveForm.
	msb
		extent: form extent;
		activeEnabledOverDownFillStyle: (ImageFillStyle form: form);
		passiveEnabledOverDownFillStyle: (ImageFillStyle form: form);
		addUpAction: aValuable;
		setBalloonText: helpText.
	^msb
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

{ #category : #'initialize-release' }
GLMUITheme >> newTreeExpandedForm [
	"Answer a new form for an expanded tree item."

	^(Form
	extent: 9@9
	depth: 32
	fromArray: #( 1049135240 2290649224 2290649224 2290649224 2290649224 2290649224 2290649224 2290649224 1200130184 478709896 4169697416 4287137928 4287137928 4287137928 4287137928 4287137928 4236806280 646482056 16777215 2508753032 4287137928 4287137928 4287137928 4287137928 4287137928 2726856840 16777215 16777215 495487112 4186474632 4287137928 4287137928 4287137928 4236806280 612927624 16777215 16777215 16777215 2542307464 4287137928 4287137928 4287137928 2676525192 16777215 16777215 16777215 16777215 478709896 4169697416 4287137928 4220029064 579373192 16777215 16777215 16777215 16777215 16777215 2424866952 4287137928 2626193544 16777215 16777215 16777215 16777215 16777215 16777215 394823816 4018702472 529041544 16777215 16777215 16777215 16777215 16777215 16777215 16777215 864585864 16777215 16777215 16777215 16777215)
	offset: 0@0)
]

{ #category : #'initialize-release' }
GLMUITheme >> newTreeUnexpandedForm [
	"Answer a new form for an unexpanded tree item."

	^(Form
	extent: 9@9
	depth: 32
	fromArray: #( 1049135240 461932680 16777215 16777215 16777215 16777215 16777215 16777215 16777215 2324203656 4152920200 2458421384 428378248 16777215 16777215 16777215 16777215 16777215 2357758088 4287137928 4287137928 4152920200 2408089736 394823816 16777215 16777215 16777215 2391312520 4287137928 4287137928 4287137928 4287137928 4119365768 2324203656 344492168 16777215 2408089736 4287137928 4287137928 4287137928 4287137928 4287137928 4287137928 3968370824 780699784 2391312520 4287137928 4287137928 4287137928 4287137928 4236806280 2659747976 529041544 16777215 2357758088 4287137928 4287137928 4253583496 2810742920 646482056 16777215 16777215 16777215 2324203656 4253583496 2777188488 696813704 16777215 16777215 16777215 16777215 16777215 1200130184 663259272 16777215 16777215 16777215 16777215 16777215 16777215 16777215)
	offset: 0@0)
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

{ #category : #'initialize-release' }
GLMUITheme >> newWindowInactiveControlForm [
	"Answer a new form for an inactive window control box."

	^(Form
	extent: 16@16
	depth: 32
	fromArray: #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4291677645 4288585374 4286085240 4284243036 4284243036 4286085240 4288585374 4291677645 0 0 0 0 0 0 0 4289572269 4285756275 4286479998 4288716960 4289835441 4289835441 4288716960 4286479998 4285756275 4289572269 0 0 0 0 0 4289506476 4284835173 4287335307 4290559164 4292598747 4293322470 4293322470 4292598747 4290559164 4287335307 4284703587 4289506476 0 0 0 4291546059 4285493103 4286414205 4288980132 4291217094 4292335575 4292598747 4292598747 4292335575 4291282887 4288980132 4286282619 4285493103 4291546059 0 0 4288980132 4285361517 4287466893 4288782753 4289835441 4290295992 4290295992 4290427578 4290164406 4289835441 4288782753 4287466893 4285361517 4288980132 0 0 4286282619 4286611584 4288059030 4288716960 4289177511 4289572269 4289835441 4289835441 4289703855 4289374890 4288782753 4288059030 4286611584 4286282619 0 0 4285164138 4287664272 4288782753 4289374890 4289835441 4290427578 4290624957 4290624957 4290559164 4290032820 4289374890 4288914339 4287664272 4285164138 0 0 4285361517 4288322202 4289703855 4290295992 4290822336 4291414473 4291677645 4291677645 4291414473 4291085508 4290427578 4289703855 4288453788 4285624689 0 0 4287072135 4288716960 4290427578 4291217094 4291677645 4292203989 4292598747 4292598747 4292335575 4291809231 4291217094 4290427578 4288716960 4287203721 0 0 4288980132 4288256409 4290624957 4291677645 4292335575 4292927712 4293256677 4293256677 4293059298 4292598747 4291809231 4290822336 4288256409 4289177511 0 0 4291677645 4287664272 4290295992 4292006610 4293059298 4293454056 4293585642 4293585642 4293454056 4293125091 4292203989 4290427578 4287730065 4291677645 0 0 4293256677 4290032820 4288124823 4291217094 4292796126 4293322470 4293717228 4293717228 4293454056 4292927712 4291677645 4288256409 4290032820 4293256677 0 0 0 4293454056 4290032820 4288322202 4289967027 4291546059 4292598747 4292664540 4291677645 4290295992 4288716960 4290032820 4293454056 0 0 0 0 0 4293322470 4292203989 4289835441 4288782753 4288322202 4288453788 4288980132 4289835441 4292335575 4293322470 0 0 0 0 0 0 0 4293059298 4293585642 4293717228 4293585642 4293585642 4293585642 4293585642 4293059298 0 0 0 0)
	offset: 0@0)
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

{ #category : #'fill-styles' }
GLMUITheme >> progressFillStyleFor: aProgress [
	"Return the progress fillStyle for the given progress morph."
	^ self windowActiveFillStyleFor: aProgress  
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

{ #category : #scrollbars }
GLMUITheme >> scrollBarButtonArrowVertices: aRectangle [ 
	^ self verticesForSimpleArrow: aRectangle
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

{ #category : #'border-styles-scrollbars' }
GLMUITheme >> scrollbarNormalThumbBorderStyleFor: aScrollbar [
	"Return the normal thumb borderStyle for the given scrollbar."

	^ BorderStyle simple
		width: 0;
		baseColor: Color transparent
]

{ #category : #'fill-styles-scrollbars' }
GLMUITheme >> scrollbarNormalThumbFillStyleFor: aScrollbar [
	"Return the normal scrollbar fillStyle for the given scrollbar."
	
	"^ (self glamorousNormalFillStyleWithBaseColor: aScrollbar paneColor for:  aScrollbar height: aScrollbar height)
		direction: (aScrollbar bounds isWide
			ifTrue: [0 @ aScrollbar height]
			ifFalse: [aScrollbar width @ 0])"
	^ self glamorousNormalFillStyleFor: aScrollbar height: aScrollbar height
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
	^ "self buttonNormalFillStyleFor: aTaskbar"
	SolidFillStyle color: Color transparent 
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

{ #category : #'basic-colors' }
GLMUITheme >> treeLineWidth [
	"Answer the width of the tree lines."

	^0
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

{ #category : #'watcher window' }
GLMUITheme >> watcherWindowActiveFillStyleFor: aWindow [

	^ SolidFillStyle color: (Color veryVeryLightGray alpha: 0.6)
]

{ #category : #'watcher window' }
GLMUITheme >> watcherWindowInactiveFillStyleFor: aWindow [

	^ SolidFillStyle color: (Color veryVeryLightGray alpha: 0.6)
]

{ #category : #accessing }
GLMUITheme >> windowActiveDropShadowStyle: anObject [
	"Set the value of windowActiveDropShadowStyle"
	windowActiveDropShadowStyle := anObject
]

{ #category : #'fill-styles' }
GLMUITheme >> windowActiveFillStyleFor: aWindow [
	"We do not want the lighting effect when the window goes inactive"
	^SolidFillStyle color: self class baseColor
]

{ #category : #'fill-styles' }
GLMUITheme >> windowActiveTitleFillStyleFor: aWindow [
	^ "self glamorousNormalFillStyleFor: aWindow height: aWindow labelHeight"
	SolidFillStyle color: Color transparent
]

{ #category : #'label-styles' }
GLMUITheme >> windowCloseOverForm [
	"Answer the form to use for mouse over window close buttons"

	^self forms at: #windowCloseOver ifAbsent: [Form extent: 16@16 depth: Display depth]
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
	^ SolidFillStyle color: Color transparent
]

{ #category : #'label-styles' }
GLMUITheme >> windowMaximizeOverForm [
	"Answer the form to use for mouse over window maximize buttons"

	^self forms at: #windowMaximizeOver ifAbsent: [Form extent: 16@16 depth: Display depth]
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

{ #category : #'label-styles' }
GLMUITheme >> windowMinimizeOverForm [
	"Answer the form to use for mouse over window minimize buttons"

	^self forms at: #windowMinimizeOver ifAbsent: [Form extent: 16@16 depth: Display depth]
]

{ #category : #forms }
GLMUITheme >> windowMinimizePassiveForm [
	"Answer the form to use for passive (background) window minimize buttons"

	^GLMUIThemeIcons windowMinimizeInactiveForm
]

{ #category : #defaults }
GLMUITheme >> windowShadowColor [
	"Answer the window shadow color to use."

	^ Color gray
]
