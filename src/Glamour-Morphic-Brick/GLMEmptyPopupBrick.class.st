Class {
	#name : #GLMEmptyPopupBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'anchorBrick',
		'triggerBrick',
		'contentBrick',
		'contentLogic',
		'isHideUnhover'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #examples }
GLMEmptyPopupBrick class >> createButton: hoverAction [

	^ (GLMActionButtonBrick new
			color: Color white;
			icon: GLMUIThemeExtraIcons glamorousBrowse;
			hoverAction: hoverAction;
			width: [ :b | b icon width * 2 ];
			height: [ :b | b icon height * 2 ])
]

{ #category : #accessing }
GLMEmptyPopupBrick >> addContentBricks [
	
	self onCreated.
	contentLogic ifNotNil: [
		self contentBrick addAllBricks: ((contentLogic brickValue: self withEnoughArguments: { self triggerBrick }) asCollection select: #isNotNil) ].
	self announce: #onCreated event: self triggerBrick
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

{ #category : #opening }
GLMEmptyPopupBrick >> beRightToLeftWithOffset: anOffset [

	self invalidateWith: [
		self triggerBrick hAlign: #right.
		self triggerBrick marginRight: anOffset.
		self foundationBrick bounds: (self foundationBrick bounds translateBy: (self width - self triggerBrick width - anOffset @ 0) negated ) ]
]

{ #category : #initialization }
GLMEmptyPopupBrick >> beSuccess [

	self themer: self themer popupSuccessThemer themer
]

{ #category : #opening }
GLMEmptyPopupBrick >> close [

	self foundationBrick delete
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
		padding: self themer popupThemer borderWidth;
		color: self themer popupThemer backgroundColor; 
		borderColor: self themer popupThemer borderColor;
	 	borderWidth: self themer popupThemer borderWidth.
	self addBrickBack: contentBrick

	
]

{ #category : #actions }
GLMEmptyPopupBrick >> doNotHideUnhover [

	isHideUnhover := false
]

{ #category : #accessing }
GLMEmptyPopupBrick >> foundationBrick [

	^ (self owner isKindOf: GLMFoundationBrick)
		ifTrue: [ self owner ]
		ifFalse: [ self ]
]

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> handleListenEvent: anEvent [

	self isHideUnhover not & (anEvent type = #mouseMove)
		ifTrue: [ ^ self ].

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

{ #category : #actions }
GLMEmptyPopupBrick >> isHideUnhover [

	^ isHideUnhover ifNil: [ isHideUnhover := true ]
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

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> onCreated [

	
]

{ #category : #initialization }
GLMEmptyPopupBrick >> onCreated: aBlock [

	contentLogic := aBlock
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
	self triggerBrick
		borderDo: [ :b | b widthTop: 0 ];
		marginTop: self themer popupThemer borderWidth negated.
	self addContentBricks.
	
	^ aBrick ifNotNil: [ self openAbove: aBrick boundsInWorld ]
]

{ #category : #opening }
GLMEmptyPopupBrick >> openBelow: aRectangle [
	"aRectangle must be in global coordinates"
	^ self asBrickedMorph
		bounds: (aRectangle origin extent: (self extent + (0@self themer popupThemer borderWidth)));
		openInWorld
	
]

{ #category : #opening }
GLMEmptyPopupBrick >> openBelowFor: aBrick [

	self anchorBrick: aBrick.
	self triggerBrick: self newTriggerBrick.
	self contentBrick: self newContentBrick.
	self triggerBrick zIndex: 2.
	self triggerBrick
		borderDo: [ :b | b widthBottom: 0 ];
		marginBottom: self themer popupThemer borderWidth negated.
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
		action: [ :b :evt | self close. self anchorBrick click: evt ].
		
	self addBrickBack: self triggerBrick.
]

{ #category : #initialization }
GLMEmptyPopupBrick >> unsubscribeListeners [

	self activeHand removeEventListener: self
]
