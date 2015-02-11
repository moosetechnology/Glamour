Class {
	#name : #GLMPopupBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'anchorBrick',
		'triggerBrick',
		'contentBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #examples }
GLMPopupBrick class >> createButton: hoverAction [

	^ (GLMActionButtonBrick new
			color: Color white;
			icon: GLMUIThemeExtraIcons glamorousBrowse;
			addHoverAction: hoverAction;
			width: [ :b | b icon width * 2 ];
			height: [ :b | b icon height * 2 ])
]

{ #category : #examples }
GLMPopupBrick class >> exampleAll [
	<example: 'all types'>

	(GLMBrick new
		addBrickBack: (self createButton: [ :b | self new openFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beHelp; openFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beError; openFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beSuccess; openFor: b ]);
		marginTop: 35)
			asBrickedMorph
			extent: 300@120;
			openInWindow
]

{ #category : #examples }
GLMPopupBrick class >> exampleError [
	<example: 'Popup brick example with anchor'>

	self openExample: [ :b | self new beError; openFor: b ]
]

{ #category : #examples }
GLMPopupBrick class >> exampleHelp [
	<example: 'Popup brick example with anchor'>

	self openExample: [ :b | self new beHelp; openFor: b ]
]

{ #category : #examples }
GLMPopupBrick class >> exampleNormal [
	<example: 'Popup brick example with anchor'>

	self openExample: [ :b | self new openFor: b ]
]

{ #category : #examples }
GLMPopupBrick class >> exampleSuccess [
	<example: 'Popup brick example with anchor'>

	self openExample: [ :b | self new beSuccess; openFor: b ]
]

{ #category : #examples }
GLMPopupBrick class >> openExample: hoverAction [
	|root|
	
	root := GLMBrick new marginTop: 35.
	1 to: 4 do: [ :i | root addBrickBack: (self createButton: hoverAction) ].
			
	root
		asBrickedMorph
			extent: 300@100;
			openInWindow
]

{ #category : #accessing }
GLMPopupBrick >> anchorBrick [

	^ anchorBrick
]

{ #category : #accessing }
GLMPopupBrick >> anchorBrick: aBrick [

	anchorBrick := aBrick
]

{ #category : #initialization }
GLMPopupBrick >> beError [

	self themer: self themer popupErrorThemer themer
]

{ #category : #initialization }
GLMPopupBrick >> beHelp [

	self themer: self themer popupHelpThemer themer
]

{ #category : #initialization }
GLMPopupBrick >> beSuccess [

	self themer: self themer popupSuccessThemer themer
]

{ #category : #accessing }
GLMPopupBrick >> contentBrick [

	^ contentBrick

	
]

{ #category : #accessing }
GLMPopupBrick >> contentBrick: aBrick [

	contentBrick := aBrick.
	self contentBrick
		color: self themer popupThemer backgroundColor; 
		borderColor: self themer popupThemer borderColor;
		textColor: self themer popupThemer textColor;
	 	borderWidth: self themer popupThemer borderWidth.
	self addBrickBack: contentBrick

	
]

{ #category : #'events-processing' }
GLMPopupBrick >> handleListenEvent: anEvent [
	
	(self triggerBrick boundsInWorld containsPoint: anEvent position) |
		(self contentBrick boundsInWorld containsPoint: anEvent position) ifFalse: [
			(self owner isKindOf: GLMFoundationBrick)
				ifTrue: [ self owner delete ]
				ifFalse: [ self delete ] ]
]

{ #category : #initialization }
GLMPopupBrick >> initialize [
	super initialize.
	
	self
		initializeListeners;
		useVerticalLinearLayout;
		vShrinkWrap;
		hShrinkWrap;
		enable.
	
	
	
]

{ #category : #initialization }
GLMPopupBrick >> initializeListeners [

	"using the most general event subscribtion for all events spawned by the hand"
	self activeHand addEventListener: self.
]

{ #category : #'instance creation' }
GLMPopupBrick >> newContentBrick [

	^ GLMLabelBrick new
		text: 'Press CMD+Right';
		padding: #(10 10);
		width: [ :b | b approximateWidth ];
		height: [ :b | b approximateHeight ]
]

{ #category : #'instance creation' }
GLMPopupBrick >> newTriggerBrick [

	^ GLMActionButtonBrick new
		icon: (self anchorBrick
			ifNil: [ GLMUIThemeExtraIcons glamorousExample ]
			ifNotNil: [ self anchorBrick brickTransparentImageForm ]);
		width: [ :b | b icon width ];
		height: [ :b | b icon width ]
]

{ #category : #opening }
GLMPopupBrick >> openAbove: aRectangle [
	"aRectangle must be in global coordinates"
	self asBrickedMorph
		bounds: ((aRectangle origin - (0@self contentBrick height) + (0@self themer popupThemer borderWidth)) extent: self extent);
		openInWorld
	
]

{ #category : #opening }
GLMPopupBrick >> openFor: aBrick [

	self anchorBrick: aBrick.
	self contentBrick: self newContentBrick.
	self triggerBrick: self newTriggerBrick.
	
	aBrick ifNotNil: [ self openAbove: aBrick boundsInWorld ]
]

{ #category : #initialization }
GLMPopupBrick >> outOfWorld: aWorld [
	super outOfWorld: aWorld.
	
	self unsubscribeListeners
]

{ #category : #accessing }
GLMPopupBrick >> triggerBrick [

	^ triggerBrick
]

{ #category : #accessing }
GLMPopupBrick >> triggerBrick: aBrick [

	triggerBrick := aBrick.
	self triggerBrick
		color: self themer popupThemer backgroundColor;
		borderColor: self themer popupThemer borderColor;
		borderWidth: self themer popupThemer borderWidth;
		borderDo: [ :b | b widthTop: 0 ];
		marginTop: self themer popupThemer borderWidth negated.
		
	self addBrickBack: self triggerBrick.
]

{ #category : #initialization }
GLMPopupBrick >> unsubscribeListeners [

	self activeHand removeEventListener: self
]
