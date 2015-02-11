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
GLMPopupBrick class >> example [
	<example>
	
	(self new openFor: nil) asBrickedMorph openInWindow
]

{ #category : #examples }
GLMPopupBrick class >> exampleWidthAnchor [
	|root|
	
	root := GLMBrick new.
	root addBrickBack:
		(GLMActionButtonBrick new
			color: Color white;
			icon: GLMUIThemeExtraIcons glamorousBrowse;
			addUpAction: [ :b | self new openFor: b ];
			width: [ :b | b icon width * 2 ];
			height: [ :b | b icon height * 2 ]).
			
	root asBrickedMorph openInWindow
]

{ #category : #accessing }
GLMPopupBrick >> anchorBrick [

	^ anchorBrick
]

{ #category : #accessing }
GLMPopupBrick >> anchorBrick: aBrick [

	anchorBrick := aBrick
]

{ #category : #accessing }
GLMPopupBrick >> contentBrick [

	^ contentBrick

	
]

{ #category : #accessing }
GLMPopupBrick >> contentBrick: aBrick [

	contentBrick := aBrick.
	self contentBrick
		color: self defaultBackgroundColor; 
		borderColor: self defaultBorderColor;
		textColor: self defaultTextColor;
	 	borderWidth: self defaultBorderWidth.
	self addBrickBack: contentBrick

	
]

{ #category : #initialization }
GLMPopupBrick >> defaultBackgroundColor [

	^ Color r: 190 g: 236 b: 250 range: 255
]

{ #category : #initialization }
GLMPopupBrick >> defaultBorderColor [

	^ Color r: 48 g:194 b:240 range: 255
]

{ #category : #initialization }
GLMPopupBrick >> defaultBorderWidth [

	^ 1
]

{ #category : #initialization }
GLMPopupBrick >> defaultTextColor [

	^ Color r: 16 g: 172 b: 221 range: 255
]

{ #category : #initialization }
GLMPopupBrick >> initialize [
	super initialize.
	
	self useVerticalLinearLayout.
	self vShrinkWrap.
	self hShrinkWrap.
	self enable
	
	
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
		bounds: ((aRectangle origin - (0@self contentBrick height) + (0@self defaultBorderWidth)) extent: self extent);
		openInWorld
	
]

{ #category : #opening }
GLMPopupBrick >> openFor: aBrick [

	self anchorBrick: aBrick.
	self contentBrick: self newContentBrick.
	self triggerBrick: self newTriggerBrick.
	
	aBrick ifNotNil: [ self openAbove: aBrick boundsInWorld ]
]

{ #category : #accessing }
GLMPopupBrick >> triggerBrick [

	^ triggerBrick
]

{ #category : #accessing }
GLMPopupBrick >> triggerBrick: aBrick [

	triggerBrick := aBrick.
	self triggerBrick
		color: self defaultBackgroundColor;
		borderColor: self defaultBorderColor;
		borderWidth: self defaultBorderWidth;
		borderDo: [ :b | b widthTop: 0 ];
		marginTop: self defaultBorderWidth negated.
		
	self addBrickBack: self triggerBrick.
]
