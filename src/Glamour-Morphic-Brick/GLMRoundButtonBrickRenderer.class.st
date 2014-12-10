"
A GLMRoundButtonBrickRenderer allows to render a button with rounded corners. Uses TrachelCanvas to support antialiasing

Instance Variables
	antialiasing:		<Object>
	isRoundedLeft:		<Object>
	isRoundedRight:		<Object>

antialiasing
	- xxxxx

isRoundedLeft
	- xxxxx

isRoundedRight
	- xxxxx

"
Class {
	#name : #GLMRoundButtonBrickRenderer,
	#superclass : #GLMInteractableBrickRenderer,
	#instVars : [
		'isRoundedLeft',
		'isRoundedRight',
		'antialiasing'
	],
	#category : #'Glamour-Morphic-Brick-Renderer'
}

{ #category : #accessing }
GLMRoundButtonBrickRenderer >> antialiasing [

	^ antialiasing
]

{ #category : #accessing }
GLMRoundButtonBrickRenderer >> antialiasing: aBoolean [

	antialiasing := aBoolean
]

{ #category : #drawing }
GLMRoundButtonBrickRenderer >> drawCircle: radius position: aPoint on: aCanvas color: aColor antialiasing: isAntialiased [
	
	isAntialiased
		ifTrue: [ self drawTrachelCircle: radius position: aPoint on: aCanvas color: aColor ]
		ifFalse: [ self drawMorphicCircle: radius position: aPoint on: aCanvas color: aColor ]
	
]

{ #category : #drawing }
GLMRoundButtonBrickRenderer >> drawMorphicCircle: radius position: aPoint on: aCanvas color: aColor [

	aCanvas fillOval: (Rectangle origin: aPoint extent: ((2*radius)@(2*radius))) color: aColor borderWidth: 0 borderColor: Color transparent.
]

{ #category : #drawing }
GLMRoundButtonBrickRenderer >> drawTrachelCanvas: trachelCanvas at: aPoint on: aCanvas [
	|surface|
	
	surface := AthensCairoSurface extent: (trachelCanvas extent) asIntegerPoint.
	
	surface drawDuring: [:cs |
		surface clear.
		trachelCanvas shapes do: [ :trachelShape |
			trachelShape drawOn: cs.
		].
	].

	aCanvas image: surface asForm at: aPoint sourceRect: (0 @ 0 extent: surface extent) rule: 34.
]

{ #category : #drawing }
GLMRoundButtonBrickRenderer >> drawTrachelCircle: radius position: aPoint on: aCanvas color: aColor [
			
	self drawTrachelCanvas: (
		TRCanvas new addShape: (
			TRArcShape new
				color: aColor;
				alphaAngle: 0  betaAngle: 360  innerRadius: 0 externalRadius: radius;
				translateBy: radius @ radius
		)
	) at: aPoint on: aCanvas.
]

{ #category : #initialization }
GLMRoundButtonBrickRenderer >> initialize [
	super initialize.
	
	self isRoundedLeft: false.
	self isRoundedRight: false.
	self antialiasing: true.
]

{ #category : #accessing }
GLMRoundButtonBrickRenderer >> isRoundedLeft [
	^ isRoundedLeft
]

{ #category : #accessing }
GLMRoundButtonBrickRenderer >> isRoundedLeft: anObject [
	isRoundedLeft := anObject
]

{ #category : #accessing }
GLMRoundButtonBrickRenderer >> isRoundedRight [
	^ isRoundedRight
]

{ #category : #accessing }
GLMRoundButtonBrickRenderer >> isRoundedRight: anObject [
	isRoundedRight := anObject
]

{ #category : #rendering }
GLMRoundButtonBrickRenderer >> renderColorOf: aBrick on: aCanvas [
	|rectangle radius diameter bounds|
	
	bounds := aBrick brickBounds.
		
	radius := (aBrick height / 2) roundDownTo: 1.0.
	diameter := radius * 2.
	rectangle := bounds withHeight: diameter.
	
	self isRoundedLeft ifTrue: [ 
		self drawCircle: radius position: bounds topLeft on: aCanvas color: aBrick currentColor antialiasing: self antialiasing.
		rectangle := (rectangle withWidth: rectangle width - radius) translateBy: radius@0.
	].

	self isRoundedRight ifTrue: [
		self drawCircle: radius position: bounds topRight - (diameter@0) on: aCanvas color: aBrick currentColor antialiasing: self antialiasing.
		rectangle := rectangle withWidth: rectangle width - radius.
	].
	
	aCanvas fillRectangle: rectangle basicFillStyle: (SolidFillStyle color: aBrick currentColor).
]
