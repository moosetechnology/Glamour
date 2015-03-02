Class {
	#name : #GLMEmptyPopupBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'anchorBrick',
		'triggerBrick',
		'contentBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #examples }
GLMEmptyPopupBrick class >> createButton: hoverAction [

	^ (GLMActionButtonBrick new
			color: Color white;
			icon: GLMUIThemeExtraIcons glamorousBrowse;
			addHoverAction: hoverAction;
			width: [ :b | b icon width * 2 ];
			height: [ :b | b icon height * 2 ])
]

{ #category : #examples }
GLMEmptyPopupBrick class >> openExample: hoverAction [
	|root|
	
	root := GLMBrick new marginTop: 35.
	1 to: 4 do: [ :i | root addBrickBack: (self createButton: hoverAction) ].
			
	root
		asBrickedMorph
			extent: 300@100;
			openInWindow
]

{ #category : #accessing }
GLMEmptyPopupBrick >> addContentBricks [
	
]

{ #category : #accessing }
GLMEmptyPopupBrick >> anchorBrick [

	^ anchorBrick
]

{ #category : #accessing }
GLMEmptyPopupBrick >> anchorBrick: aBrick [

	anchorBrick := aBrick
]

{ #category : #initialization }
GLMEmptyPopupBrick >> beError [

	self themer: self themer popupErrorThemer themer
]

{ #category : #initialization }
GLMEmptyPopupBrick >> beHelp [

	self themer: self themer popupHelpThemer themer
]

{ #category : #initialization }
GLMEmptyPopupBrick >> beSuccess [

	self themer: self themer popupSuccessThemer themer
]

{ #category : #opening }
GLMEmptyPopupBrick >> close [

	(self owner isKindOf: GLMFoundationBrick)
		ifTrue: [ self owner delete ]
		ifFalse: [ self delete ]
]

{ #category : #accessing }
GLMEmptyPopupBrick >> contentBrick [

	^ contentBrick

	
]

{ #category : #accessing }
GLMEmptyPopupBrick >> contentBrick: aBrick [

	contentBrick := aBrick.
	self contentBrick
		vShrinkWrap;
		hShrinkWrap;
		paddingTop: 5;
		paddingBottom: 5;
		color: self themer popupThemer backgroundColor; 
		borderColor: self themer popupThemer borderColor;
	 	borderWidth: self themer popupThemer borderWidth.
	self addBrickBack: contentBrick

	
]

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> handleListenEvent: anEvent [
	(self isInsideOfPopupBrick: anEvent) ifFalse: [ self close ]
]

{ #category : #initialization }
GLMEmptyPopupBrick >> initialize [
	super initialize.
	
	self
		initializeListeners;
		useVerticalLinearLayout;
		vShrinkWrap;
		hShrinkWrap;
		enable.
	
	
	
]

{ #category : #initialization }
GLMEmptyPopupBrick >> initializeListeners [

	"using the most general event subscribtion for all events spawned by the hand"
	self activeHand addEventListener: self.
]

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> isInsideOfContentBrick: anEvent [
	^ self contentBrick 
		ifNil: [false]
		ifNotNil: [:aBrick | aBrick boundsInWorld containsPoint: anEvent position]
]

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> isInsideOfPopupBrick: anEvent [
	^ (self isInsideOfTriggerBrick: anEvent) | (self isInsideOfContentBrick: anEvent)
]

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> isInsideOfTriggerBrick: anEvent [
	^ self triggerBrick 
		ifNil: [false]
		ifNotNil: [:aBrick | aBrick boundsInWorld containsPoint: anEvent position ]
]

{ #category : #'instance creation' }
GLMEmptyPopupBrick >> newContentBrick [

	^ GLMBandBrick new
]

{ #category : #'instance creation' }
GLMEmptyPopupBrick >> newTriggerBrick [

	^ GLMActionButtonBrick new
		icon: (self anchorBrick
			ifNil: [ GLMUIThemeExtraIcons glamorousExample ]
			ifNotNil: [ self anchorBrick brickTransparentImageForm ]);
		width: [ :b | b icon width ];
		height: [ :b | b icon height ]
]

{ #category : #opening }
GLMEmptyPopupBrick >> openAbove: aRectangle [
	"aRectangle must be in global coordinates"
	^ self asBrickedMorph
		bounds: ((aRectangle origin - (0@self contentBrick height) + (0@self themer popupThemer borderWidth)) extent: self extent);
		openInWorld
	
]

{ #category : #opening }
GLMEmptyPopupBrick >> openAboveFor: aBrick [

	self anchorBrick: aBrick.
	self contentBrick: self newContentBrick.
	self triggerBrick: self newTriggerBrick.
	self addContentBricks.
	
	^ aBrick ifNotNil: [ self openAbove: aBrick boundsInWorld ]
]

{ #category : #opening }
GLMEmptyPopupBrick >> openBelow: aRectangle [
	"aRectangle must be in global coordinates"
	^ self asBrickedMorph
		bounds: (aRectangle origin 
						extent: (self extent - (0@self themer popupThemer borderWidth)));
		openInWorld
	
]

{ #category : #opening }
GLMEmptyPopupBrick >> openBelowFor: aBrick [

	self anchorBrick: aBrick.
	self triggerBrick: self newTriggerBrick.
	self contentBrick: self newContentBrick.
	self addContentBricks.
	
	^ aBrick ifNotNil: [ self openBelow: aBrick boundsInWorld ]
]

{ #category : #opening }
GLMEmptyPopupBrick >> openFor: aBrick [
	^ self openAboveFor: aBrick
]

{ #category : #initialization }
GLMEmptyPopupBrick >> outOfWorld: aWorld [
	super outOfWorld: aWorld.
	
	self unsubscribeListeners
]

{ #category : #accessing }
GLMEmptyPopupBrick >> triggerBrick [

	^ triggerBrick
]

{ #category : #accessing }
GLMEmptyPopupBrick >> triggerBrick: aBrick [

	triggerBrick := aBrick.
	self triggerBrick
		color: self themer popupThemer backgroundColor;
		borderColor: self themer popupThemer borderColor;
		borderWidth: self themer popupThemer borderWidth;
		borderDo: [ :b | b widthTop: 0 ];
		marginTop: self themer popupThemer borderWidth negated;
		addUpAction: [ :b :evt | self close. self anchorBrick click: evt ].
		
	self addBrickBack: self triggerBrick.
]

{ #category : #initialization }
GLMEmptyPopupBrick >> unsubscribeListeners [

	self activeHand removeEventListener: self
]
