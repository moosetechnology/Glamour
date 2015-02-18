Class {
	#name : #GLMTaskbarButtonBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'iconBrick',
		'labelBrick',
		'actionbarBrick',
		'taskBarMorph',
		'windowBrick',
		'model'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Windows'
}

{ #category : #accessing }
GLMTaskbarButtonBrick >> actionbarBrick [
	^ actionbarBrick
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> actionbarBrick: anObject [

	actionbarBrick := anObject.
	
	self actionbarBrick
		hShrinkWrap;
		vSpaceFill.
	self addBrickBack: self actionbarBrick
]

{ #category : #adding }
GLMTaskbarButtonBrick >> addCloseButton [
	|closeButton|
	
	closeButton := GLMActionButtonBrick new.
	closeButton
		icon: GLMUIThemeExtraIcons glamorousClose;
		width: [ :b | b icon width * 1.2 ];
		addUpAction: [ self windowBrick delete ].
		
	self pushActionButton: closeButton
	
]

{ #category : #actions }
GLMTaskbarButtonBrick >> click: anEvent [
	super click: anEvent.
	self windowBrick taskbarButtonClicked.
	^ true
]

{ #category : #initialization }
GLMTaskbarButtonBrick >> for: aWindowBrick taskbar: aTaskbarMorph [

	self windowBrick: aWindowBrick.
	self taskbarMorph: aTaskbarMorph.
	self invalidateWith: [ :b | b
		label: b windowBrick taskbarLabel;
		icon: b windowBrick taskbarIcon ]
		
	
	
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> icon: anImage [

	self iconBrick icon: anImage
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> iconBrick [
	^ iconBrick
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> iconBrick: aBrick [
	
	iconBrick := aBrick.
	self iconBrick
		icon: Smalltalk ui icons smallWindowIcon;
		width: [ :b | b icon width * 1.5 ];
		vSpaceFill.
	self addBrickBack: self iconBrick
]

{ #category : #initialization }
GLMTaskbarButtonBrick >> initialize [
	super initialize.
	
	self
		normalColor: (Color veryVeryLightGray alpha: 0.8);
		selectedColor: (Color veryVeryLightGray);
		checkedColor: (Color r: 35 g: 205 b: 255 range: 255);
		borderColor: (Color veryLightGray);
		borderWidth: 1;
		hShrinkWrap;
		enable.
		
	self iconBrick: self newIconBrick.
	self labelBrick: self newLabelBrick.
	self actionbarBrick: self newActionbarBrick.
	self addCloseButton
	

]

{ #category : #accessing }
GLMTaskbarButtonBrick >> label: aString [

	self labelBrick
		text: aString;
		doLayoutForce
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> labelBrick [
	^ labelBrick
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> labelBrick: aBrick [

	labelBrick := aBrick.
	self labelBrick
		width: #approximateWidth;
		textPosition: #center;
		maxWidth: 200;
		vSpaceFill.
	self addBrickBack: self labelBrick
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> model: aModel [

	model := aModel
]

{ #category : #'instance creation' }
GLMTaskbarButtonBrick >> newActionbarBrick [

	^ GLMBrick new
]

{ #category : #'instance creation' }
GLMTaskbarButtonBrick >> newIconBrick [

	^ GLMActionButtonBrick new
]

{ #category : #'instance creation' }
GLMTaskbarButtonBrick >> newLabelBrick [

	^ GLMLabelBrick new
]

{ #category : #adding }
GLMTaskbarButtonBrick >> pushActionButton: aBrick [

	aBrick
		selectedColor: (Color veryLightGray alpha: 0.5);
		vSpaceFill.
	self actionbarBrick addBrickBack: aBrick.
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> taskbarMorph [

	^ taskBarMorph
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> taskbarMorph: aTaskBarMorph [

	taskBarMorph := aTaskBarMorph
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> windowBrick [

	^ windowBrick
]

{ #category : #accessing }
GLMTaskbarButtonBrick >> windowBrick: aWindowBrick [

	windowBrick := aWindowBrick
]
