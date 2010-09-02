Class {
	#name : #GLMUITheme,
	#superclass : #UIThemeWatery2,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #accessing }
GLMUITheme class >> baseColor [
	^ Color r: 180 g: 180 b: 180 range: 255
]

{ #category : #accessing }
GLMUITheme class >> baseSelectionColor [
	^ self glamorousBlue
]

{ #category : #settings }
GLMUITheme class >> beCurrent [
	"self beCurrent"
	super beCurrent.
	World color: (
		(GradientFillStyle 
			ramp: { 0.0 -> Color white.  1.0 -> Color lightGray})
			origin: 50 @ 50;
			direction: 800@0;
			normal: 0@800;
		radial: true)
]

{ #category : #private }
GLMUITheme class >> glamorousBlue [
	^ Color 
		r: 0.38
		g: 0.64
		b: 0.88
	"Color r: 0
		g: 0.4
		b: 0.808"
]

{ #category : #settings }
GLMUITheme class >> newDefaultSettings [
	^super newDefaultSettings
		menuColor: self baseColor;
		menuTitleColor: self baseColor;
		windowColor: self baseColor;
		selectionColor: self baseSelectionColor muchLighter;
		menuSelectionColor: self baseSelectionColor twiceLighter;
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

{ #category : #private }
GLMUITheme >> buttonBaseSelectionColorFor: aButton [
	^ self class baseSelectionColor
	
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
	outerColor := (self buttonBaseColorFor: aButton) darker.
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
	top := (self buttonBaseSelectionColorFor: aButton) muchLighter.
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

{ #category : #'fill-styles' }
GLMUITheme >> dockingBarNormalFillStyleFor: aToolDockingBar [
	^ SolidFillStyle color: (self buttonBaseColorFor: aToolDockingBar)
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
			 width: 1;
			baseColor: (self buttonBaseSelectionColorFor: aMorph) lighter);
		bounds: aMorph focusBounds
]

{ #category : #'initialize-release' }
GLMUITheme >> newWindowCloseForm [
	"Answer a new form for a window close box."

	^(Form
	extent: 16@16
	depth: 32
	fromArray: #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4290361785 4285822068 4282071867 4279440147 4279440147 4282071867 4285822068 4290361785 0 0 0 0 0 0 0 4287335307 4281808438 4283254086 4286543478 4288254096 4288188560 4286543478 4283254086 4281808438 4287335307 0 0 0 0 0 4287138185 4280425243 4285027670 4289633180 4292135884 4293254878 4293320928 4292267469 4289567644 4285093206 4280490779 4287203978 0 0 0 4290164406 4282134834 4284233271 4288637549 4291401881 4292653234 4292850869 4292785333 4292653234 4291467161 4288637549 4284364600 4282266163 4290230199 0 0 4286545534 4283178015 4287182138 4289281086 4290597711 4290995037 4291126110 4291126109 4290929244 4290662991 4289281086 4287182394 4283309344 4286611327 0 0 4283383359 4285867306 4288685092 4289799715 4290590512 4290856252 4290988611 4291054147 4290922044 4290590256 4289930531 4288619300 4285867562 4283711040 0 0 4282782229 4287833644 4289996837 4290787376 4291381825 4291909968 4292173910 4292239446 4292106833 4291578692 4290984239 4290193702 4287833644 4283044630 0 0 4284026900 4289014315 4291051835 4291973448 4292633434 4293226345 4293556336 4293622129 4293358699 4292896092 4292236105 4291445307 4289014058 4284092436 0 0 4285414719 4289343786 4291712331 4293027933 4293949038 4294280317 4294479236 4294479236 4294346110 4294015086 4293224799 4291974475 4289343785 4285545791 0 0 4287264888 4288555300 4292239449 4293818479 4294542716 4294546314 4294614419 4294614676 4294546828 4294543230 4293884271 4292501850 4288751652 4287330424 0 0 4290558650 4286658615 4291253841 4293951868 4294481292 4294615447 4294617247 4294618017 4294616217 4294481550 4294214781 4291779154 4286789430 4290493114 0 0 4292664540 4288385426 4287573545 4292374633 4293892240 4294289824 4294555050 4294555308 4294356387 4293958547 4292835183 4287836460 4288385426 4292664540 0 0 0 4292993505 4288320403 4286993487 4289421400 4291463295 4292845463 4293043354 4291660419 4289684573 4287256400 4288254867 4292993505 0 0 0 0 0 4292927712 4291282630 4287858566 4286996058 4286533190 4286598726 4287324509 4287858309 4291348680 4292927712 0 0 0 0 0 0 0 4292401368 4293125091 4293454056 4293190884 4293190884 4293190884 4293125091 4292401368 0 0 0 0)
	offset: 0@0)
]

{ #category : #'initialize-release' }
GLMUITheme >> newWindowMaximizeForm [
	"Answer a new form for a window maximize box."

	^(Form
	extent: 16@16
	depth: 32
	fromArray: #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4290295992 4285822068 4282071867 4279440147 4279440147 4282071867 4285822068 4290295992 0 0 0 0 0 0 0 4287269514 4281611316 4282795590 4285953654 4287664528 4287730320 4285953654 4282861383 4281611316 4287269514 0 0 0 0 0 4287137928 4280360481 4283914839 4288455580 4291547084 4292731360 4292796894 4291547341 4288390044 4283980376 4280294689 4287203721 0 0 0 4290164406 4281348144 4282010170 4285369453 4288527772 4290565299 4291025080 4291025080 4290630835 4288593820 4285303917 4282009913 4281348144 4290164406 0 0 4286479998 4280431648 4282282296 4283995198 4286033222 4286821198 4286952786 4287018578 4286755662 4285967429 4284060735 4282216504 4280497696 4286545791 0 0 4282402111 4281097769 4282549797 4283800345 4284982554 4285771048 4285903149 4285837356 4285771304 4285114397 4283866393 4282484773 4281097769 4282402111 0 0 4279972116 4282219307 4283997212 4285114906 4285969451 4286824254 4287152961 4287218498 4286890301 4286167084 4285246490 4284260124 4282219308 4280037908 0 0 4279975186 4283600171 4285640744 4286561842 4287547718 4288336981 4288731227 4288731228 4288402775 4287614279 4286627889 4285772072 4283600683 4280172817 0 0 4282736189 4284126245 4286692666 4287877449 4288797275 4289586536 4290112367 4290112368 4289718377 4288863579 4287877448 4286758970 4284126756 4282803005 0 0 4286284920 4283533850 4287283524 4288731993 4289718632 4290507893 4291099774 4291165055 4290705785 4289850729 4288797788 4287415878 4283599642 4286350968 0 0 4290362041 4283331374 4286560575 4289322854 4290770809 4291559299 4291952522 4292083595 4291690372 4290903163 4289455464 4286889281 4283462959 4290362040 0 0 4292664540 4287928465 4283793702 4288007509 4290572412 4291689100 4292607381 4292607382 4291885710 4290900861 4288666201 4284122406 4287928465 4292664540 0 0 0 4292993505 4288059538 4284842051 4286688328 4289384043 4290962050 4291224710 4289646450 4287083084 4285171781 4287928466 4292993505 0 0 0 0 0 4292927712 4291217093 4287402885 4285630033 4284907832 4284973881 4285893715 4287468677 4291348680 4292927712 0 0 0 0 0 0 0 4292401368 4293125091 4293454056 4293190884 4293190884 4293190884 4293125091 4292401368 0 0 0 0)
	offset: 0@0)
]

{ #category : #'initialize-release' }
GLMUITheme >> newWindowMenuForm [
	"Answer a new form for a window menu box."

	^(Form
	extent: 24@16
	depth: 32
	fromArray: #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4293125091 4287335307 4283453520 4281150765 4280690214 4280821800 4280821800 4280821800 4280821800 4280821800 4280821800 4280821800 4280821800 4280690214 4281150765 4283453520 4287335307 4293125091 0 0 0 0 0 4293059298 4285493103 4282795590 4287072135 4289638062 4290493371 4290822336 4290756543 4290756543 4290822336 4290822336 4290756543 4290756543 4290822336 4290493371 4289638062 4287072135 4282795590 4285493103 4293059298 0 0 0 0 4287335307 4282598211 4288322202 4291875024 4292927712 4293322470 4293519849 4293519849 4293519849 4293519849 4293519849 4293519849 4293519849 4293519849 4293322470 4292927712 4291875024 4288322202 4282598211 4287401100 0 0 0 0 4283585106 4285953654 4289967027 4291677645 4292269782 4292401368 4292401368 4292401368 4292335575 4292335575 4292335575 4292335575 4292401368 4292401368 4292401368 4292269782 4291677645 4289967027 4285953654 4283585106 0 0 0 0 4281742902 4287861651 4290493371 4291085508 4291480266 4291546059 4291611852 4291611852 4291546059 4291480266 4291480266 4291546059 4291611852 4291611852 4291546059 4291480266 4291085508 4290493371 4287861651 4281742902 0 0 0 0 4281940281 4288782753 4291414473 4292203989 4292664540 4292796126 4292927712 4292796126 4292861919 4292927712 4292927712 4292861919 4292796126 4292927712 4292796126 4292664540 4292203989 4291414473 4288782753 4281874488 0 0 0 0 4284045657 4288256409 4291546059 4293190884 4294177779 4294572537 4294440951 4294572537 4294506744 4294572537 4294572537 4294506744 4294572537 4294440951 4294572537 4294177779 4293190884 4291546059 4288256409 4284045657 0 0 0 0 4287269514 4283914071 4290624957 4293190884 4294638330 4294769916 4294835709 4294835709 4294835709 4294835709 4294835709 4294835709 4294835709 4294835709 4294769916 4294638330 4293190884 4290624957 4283914071 4287269514 0 0 0 0 4292467161 4286414205 4283387727 4287993237 4291019715 4292269782 4292467161 4292467161 4292467161 4292467161 4292467161 4292467161 4292467161 4292467161 4292598747 4291611852 4287993237 4283387727 4286414205 4292467161 0 0 0 0 4292401368 4292467161 4288124823 4284177243 4281150765 4280229663 4280361249 4280361249 4280361249 4280361249 4280361249 4280361249 4280361249 4280361249 4280229663 4281282351 4284177243 4288124823 4292467161 4292401368 0 0 0 0 0 4292203989 4292203989 4292335575 4292401368 4292927712 4292927712 4292927712 4292927712 4292927712 4292927712 4292927712 4292927712 4292927712 4292664540 4292401368 4292335575 4292269782 4292203989 0 0 0 0 0 0 0 4292006610 4292401368 4292467161 4292730333 4292730333 4292730333 4292730333 4292730333 4292730333 4292730333 4292730333 4292730333 4292796126 4292467161 4292401368 4292006610 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
	offset: 0@0)
]

{ #category : #'initialize-release' }
GLMUITheme >> newWindowMinimizeForm [
	"Answer a new form for a window minimize box."

	^(Form
	extent: 16@16
	depth: 32
	fromArray: #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4290295992 4285953140 4282726971 4280619283 4280619283 4282661434 4285953140 4290295992 0 0 0 0 0 0 0 4287400586 4282921779 4284629572 4287526262 4288909456 4288974992 4287591798 4284761414 4282856243 4287400586 0 0 0 0 0 4287334536 4282588703 4286796631 4290682268 4292529868 4293385950 4293385950 4292529612 4290682268 4286731095 4282654242 4287400329 0 0 0 4290164406 4283247407 4286332215 4290281068 4292457116 4293447349 4293579448 4293579447 4293447349 4292457116 4290346605 4286660409 4283771952 4290164406 0 0 4287004286 4284555291 4289551160 4291461439 4292647750 4292978252 4292978510 4292978510 4292912459 4292516422 4291461695 4289485625 4285736224 4287004543 0 0 4284694079 4287316261 4291129383 4292379927 4292907543 4293237538 4293434920 4293369896 4293303330 4293104407 4292380439 4291130151 4288301098 4284694078 0 0 4285013269 4289947179 4292577049 4293498387 4293959974 4294159159 4294291774 4294357567 4294291256 4294091813 4293695508 4292774682 4290144044 4285013782 0 0 4286197779 4291263275 4293565218 4294486826 4294752322 4294754384 4294624599 4294756183 4294755663 4294753345 4294618155 4293828129 4291395115 4286263315 0 0 4286797373 4291592487 4294093364 4294753602 4294822482 4294825059 4294826346 4294826603 4294825828 4294822740 4294753602 4294225462 4291855399 4286928446 0 0 4287791736 4290870043 4294029633 4294691156 4294826081 4294894447 4294962297 4294963066 4294895474 4294892130 4294691669 4294096449 4291001115 4287857272 0 0 4290558649 4287916079 4292847677 4294431071 4294829938 4294964349 4294965892 4294966661 4294964606 4294896499 4294563169 4292980029 4287981872 4290558648 0 0 4292664540 4288452497 4288312611 4292590416 4294239351 4294636933 4294835601 4294835346 4294637704 4294306681 4293052245 4288576291 4288452497 4292664540 0 0 0 4292993505 4288321426 4287199810 4289700930 4291873639 4293321856 4293387137 4292005738 4290096709 4287463236 4288321426 4292993505 0 0 0 0 0 4292927712 4291282629 4287861124 4287137103 4286939445 4286939701 4287532112 4287926916 4291348680 4292927712 0 0 0 0 0 0 0 4292401368 4293125091 4293454056 4293190884 4293190884 4293190884 4293125091 4292401368 0 0 0 0)
	offset: 0@0)
]

{ #category : #'border-styles' }
GLMUITheme >> plainGroupPanelBorderStyleFor: aGroupPanel [
	"Answer the normal border style for a plain group panel."

	^SimpleBorder new
		width: 1;
		baseColor: (self buttonBaseColorFor: aGroupPanel) lighter
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

	^ self class baseColor" paneColor"
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
		baseColor: ((self buttonBaseColorFor: aTabGroup));
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
