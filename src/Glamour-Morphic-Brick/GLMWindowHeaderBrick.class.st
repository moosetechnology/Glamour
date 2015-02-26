Class {
	#name : #GLMWindowHeaderBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'actionbarBrick',
		'labelBrick',
		'menuBrick',
		'windowBrick',
		'startDragging',
		'startDraggingOrigin'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Windows'
}

{ #category : #accessing }
GLMWindowHeaderBrick >> actionbarBrick [
	^ actionbarBrick
]

{ #category : #accessing }
GLMWindowHeaderBrick >> actionbarBrick: anObject [
	actionbarBrick := anObject.
	
	self actionbarBrick
		vSpaceFill;
		hShrinkWrap.
	
	self addBrickBack: self actionbarBrick.
]

{ #category : #adding }
GLMWindowHeaderBrick >> addCloseButton [

	self pushActionButton: (
		GLMActionButtonBrick new
			icon: (GLMUIThemeExtraIcons glamorousClose);
			addUpAction: [ self window delete ])
]

{ #category : #adding }
GLMWindowHeaderBrick >> addOffcanvasMenuButton [

	self pushMenuButton: (
		GLMActionButtonBrick new
			icon: (Smalltalk ui icons iconNamed: #nautilusIcon);
			addUpAction: [ self window toggleOffcanvas ])
]

{ #category : #'event handling' }
GLMWindowHeaderBrick >> handlesMouseStillDown: evt [
	^ true
]

{ #category : #initialization }
GLMWindowHeaderBrick >> initialize [
	super initialize.
	
	self actionbarBrick: self newActionbarBrick.
	self labelBrick: self newLabelBrick.
	self menuBrick: self newMenuBrick.
	self
		addCloseButton;
		addOffcanvasMenuButton;
		enable
	
]

{ #category : #accessing }
GLMWindowHeaderBrick >> labelBrick [
	^ labelBrick
]

{ #category : #accessing }
GLMWindowHeaderBrick >> labelBrick: anObject [
	labelBrick := anObject.
	
	self labelBrick
		textPosition: #center;
		with: [ :b | b layout vAlign: #center ];
		fontSize: 11;
		with: [ :b | b label familyName: 'Bitmap DejaVu Sans' ];
		vSpaceFill;
		hSpaceFill.
		
	self addBrickBack: self labelBrick
]

{ #category : #accessing }
GLMWindowHeaderBrick >> menuBrick [
	^ menuBrick
]

{ #category : #accessing }
GLMWindowHeaderBrick >> menuBrick: anObject [
	menuBrick := anObject.
	
	self menuBrick
		width: [ self actionbarBrick width ];
		vSpaceFill.
		
	self menuBrick layout widthDependency: [ self actionbarBrick ].
		
	self addBrickBack: self menuBrick
]

{ #category : #'mouse events' }
GLMWindowHeaderBrick >> mouseDown: evt [
	super mouseDown: evt.
	
	startDragging := evt position.
	startDraggingOrigin := self window topLeft
	
]

{ #category : #'event handling' }
GLMWindowHeaderBrick >> mouseMove: evt [
	|delta|
	super mouseMove: evt.
	
	startDragging ifNil: [ ^ self ].
	
	delta := startDragging - evt position.
	self window topLeft: (startDraggingOrigin - delta)
]

{ #category : #'mouse events' }
GLMWindowHeaderBrick >> mouseUp: evt [
	super mouseUp: evt.
	
	startDragging := nil
]

{ #category : #'instance creation' }
GLMWindowHeaderBrick >> newActionbarBrick [

	^ GLMBrick new
]

{ #category : #'instance creation' }
GLMWindowHeaderBrick >> newLabelBrick [

	^ GLMLabelBrick new
]

{ #category : #'instance creation' }
GLMWindowHeaderBrick >> newMenuBrick [

	^ GLMBrick new
]

{ #category : #adding }
GLMWindowHeaderBrick >> pushActionButton: aButton [

	aButton
		width: [ :b | b icon width * 1.2 ];
		vSpaceFill.
		
	self actionbarBrick addBrickBack: aButton
]

{ #category : #adding }
GLMWindowHeaderBrick >> pushMenuButton: aButton [

	aButton
		width: [ :b | b icon width * 1.2 ];
		vSpaceFill.
		
	self menuBrick addBrickBack: aButton
]

{ #category : #accessing }
GLMWindowHeaderBrick >> window [

	^ windowBrick
]

{ #category : #accessing }
GLMWindowHeaderBrick >> window: aWindowBrick [

	windowBrick := aWindowBrick.
	self labelBrick text: self window labelString.
	self doLayoutForce
]
