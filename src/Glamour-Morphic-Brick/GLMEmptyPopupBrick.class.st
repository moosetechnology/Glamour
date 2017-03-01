"
I am a general popup widget that also visually preserves a context of a trigger element.
I can opened based on opening strategy (hover, shift + hover, or double click + shift).
Subclasses should implement #onCreated method to customize popup content
"
Class {
	#name : #GLMEmptyPopupBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'anchorBrick',
		'triggerBrick',
		'contentBrick',
		'closer'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI-Popup'
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

{ #category : #examples }
GLMEmptyPopupBrick class >> createLabel: hoverAction [
	| label |

	label := GLMLabelBrick new
			enable;
			color: Color white;
			text: 'Hover me';
			vShrinkWrap;
			hShrinkWrap;
			yourself.
	
	
	label	when: #onMouseHover do: [ hoverAction value: label ].
	
	^ label
]

{ #category : #initialization }
GLMEmptyPopupBrick >> addCloserListener [

	self
		assert: [ self closer isNotNil ]
		description: [ 'Closer must not be nil' ].
	
	self closer popup: self.
	self activeHand addEventListener: self closer
]

{ #category : #accessing }
GLMEmptyPopupBrick >> addContentBricks [
	
	self onCreated.
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
GLMEmptyPopupBrick >> closer [
	"Return a current popup closer"
	^ closer
]

{ #category : #accessing }
GLMEmptyPopupBrick >> closer: aPopupCloser [
	"Change current popup closer to a given one"
	
	self removeCloserListener.
	closer := aPopupCloser.
	self addCloserListener
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

{ #category : #initialization }
GLMEmptyPopupBrick >> defaultCloser [
	"Return a default popup closer responsible for hiding a popup"
	<return: #GLMPopupBrickCloser>

	^ GLMPopupBrickCloser new
		predicate: GLMPopupBrickUnhoverPredicate new;
		yourself
]

{ #category : #accessing }
GLMEmptyPopupBrick >> foundationBrick [

	^ (self owner isKindOf: GLMFoundationBrick)
		ifTrue: [ self owner ]
		ifFalse: [ self ]
]

{ #category : #initialization }
GLMEmptyPopupBrick >> initialize [
	super initialize.

	closer := self defaultCloser.

	self
		initializeListeners;
		useVerticalLinearLayout;
		vShrinkWrap;
		hShrinkWrap;
		enable
]

{ #category : #initialization }
GLMEmptyPopupBrick >> initializeListeners [
	"using the most general event subscribtion for all events spawned by the hand"
	
	self addCloserListener
]

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> isInsideOfContentBrick: anEvent [
	self contentBrick 
		ifNil: [^ false]
		ifNotNil: [:aBrick | 
			anEvent withHandPositionDo: [ :position | ^ aBrick boundsInWorld containsPoint: position ]]
]

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> isInsideOfPopupBrick: anEvent [
	^ (self isInsideOfTriggerBrick: anEvent) | (self isInsideOfContentBrick: anEvent)
]

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> isInsideOfTriggerBrick: anEvent [
	self triggerBrick 
		ifNil: [^ false]
		ifNotNil: [:aBrick | 
			anEvent withHandPositionDo: [ :position | ^ aBrick boundsInWorld containsPoint: position ] ]
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
			ifNotNil: [ self anchorBrick brickImageForm: self themer popupThemer backgroundColor ]);
		width: [ :b | b icon width + b paddingLeft + b paddingRight ];
		height: [ :b | b icon height + b paddingTop + b paddingBottom ];
		padding: self padding
]

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> onCreated [
	self subclassResponsibility
]

{ #category : #'events-processing' }
GLMEmptyPopupBrick >> onOpened [
]

{ #category : #opening }
GLMEmptyPopupBrick >> openAbove: aRectangle [
	"aRectangle must be in global coordinates"
	^ self asBrickedMorph
		vShrinkWrap;
		hShrinkWrap;
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
	| anOrigin anExtent aFoundationBrick |

	anOrigin := aRectangle origin - ((self paddingLeft @ self paddingTop) * 2).
	anExtent := self extent + (0 @ self themer popupThemer borderWidth) + (self hPadding @ self vPadding).

	aFoundationBrick := self asBrickedMorph
		vShrinkWrap;
		hShrinkWrap;
		bounds: (anOrigin extent: anExtent);
		openInWorld.
		
	self onOpened.
	
	^ aFoundationBrick
]

{ #category : #opening }
GLMEmptyPopupBrick >> openBelowFor: aBrick [

	self anchorBrick: aBrick.
	self triggerBrick: self newTriggerBrick.
	self contentBrick: self newContentBrick.
	self triggerBrick
		marginBottom: self themer popupThemer borderWidth negated.
	self addContentBricks.
	
	self contentBrick
		borderDo: [ :b | b widthTop: [ self contentBrick width > self triggerBrick width
			ifTrue: [ self themer popupThemer borderWidth ]
			ifFalse: [ 0 ] ] ];
		zIndex: [ :b | self contentBrick width > self triggerBrick width
			ifTrue: [ 1 ]
			ifFalse: [ 2 ] ].

	self triggerBrick
		borderDo: [ :b | b widthBottom: [ self contentBrick width > self triggerBrick width
			ifTrue: [ 0 ]
			ifFalse: [ self themer popupThemer borderWidth ] ] ];
	zIndex: [ :b | self contentBrick width > self triggerBrick width
			ifTrue: [ 2 ]
			ifFalse: [ 1 ] ].
	
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

{ #category : #'brick-geometry-properties' }
GLMEmptyPopupBrick >> padding: aCollection [
	super padding: aCollection.
	
	self triggerBrick ifNotNil: [ :aBrick | aBrick padding: aCollection ]
]

{ #category : #initialization }
GLMEmptyPopupBrick >> removeCloserListener [

	self
		assert: [ self closer isNotNil ]
		description: [ 'Closer must not be nil' ].
	
	self activeHand removeEventListener: self closer.
	self closer popup: nil
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
		borderWidth: self themer popupThemer borderWidth.
		
	self addBrickBack: self triggerBrick
]

{ #category : #initialization }
GLMEmptyPopupBrick >> unsubscribeListeners [

	self removeCloserListener
]
