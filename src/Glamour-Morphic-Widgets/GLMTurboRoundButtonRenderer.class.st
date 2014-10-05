Class {
	#name : #GLMTurboRoundButtonRenderer,
	#superclass : #GLMTurboTrickRenderer,
	#instVars : [
		'isRoundedLeft',
		'isRoundedRight',
		'antialiasing'
	],
	#category : #'Glamour-Morphic-Widgets-Turbo-Model'
}

{ #category : #accessing }
GLMTurboRoundButtonRenderer >> antialiasing [

	^ antialiasing
]

{ #category : #accessing }
GLMTurboRoundButtonRenderer >> antialiasing: aBoolean [

	antialiasing := aBoolean
]

{ #category : #drawing }
GLMTurboRoundButtonRenderer >> drawCircle: radius position: aPoint on: aCanvas color: aColor antialiasing: isAntialiased [
	
	isAntialiased
		ifTrue: [ self drawTrachelCircle: radius position: aPoint on: aCanvas color: aColor ]
		ifFalse: [ self drawMorphicCircle: radius position: aPoint on: aCanvas color: aColor ]
	
]

{ #category : #drawing }
GLMTurboRoundButtonRenderer >> drawMorphicCircle: radius position: aPoint on: aCanvas color: aColor [

	aCanvas fillOval: (Rectangle origin: aPoint extent: ((2*radius)@(2*radius))) color: aColor borderWidth: 0 borderColor: Color transparent.
]

{ #category : #drawing }
GLMTurboRoundButtonRenderer >> drawTrachelCanvas: trachelCanvas at: aPoint on: aCanvas [
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
GLMTurboRoundButtonRenderer >> drawTrachelCircle: radius position: aPoint on: aCanvas color: aColor [
			
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
GLMTurboRoundButtonRenderer >> initialize [
	super initialize.
	
	self isRoundedLeft: false.
	self isRoundedRight: false.
	self antialiasing: true.
]

{ #category : #accessing }
GLMTurboRoundButtonRenderer >> isRoundedLeft [
	^ isRoundedLeft
]

{ #category : #accessing }
GLMTurboRoundButtonRenderer >> isRoundedLeft: anObject [
	isRoundedLeft := anObject
]

{ #category : #accessing }
GLMTurboRoundButtonRenderer >> isRoundedRight [
	^ isRoundedRight
]

{ #category : #accessing }
GLMTurboRoundButtonRenderer >> isRoundedRight: anObject [
	isRoundedRight := anObject
]

{ #category : #rendering }
GLMTurboRoundButtonRenderer >> renderColorOf: aTrick on: aCanvas [
	|rectangle radius diameter bounds|
	
	bounds := aTrick bounds.
		
	radius := (aTrick height / 2) roundDownTo: 1.0.
	diameter := radius * 2.
	rectangle := bounds withHeight: diameter.
	
	self isRoundedLeft ifTrue: [ 
		self drawCircle: radius position: bounds topLeft on: aCanvas color: aTrick currentColor antialiasing: self antialiasing.
		rectangle := (rectangle withWidth: rectangle width - radius) translateBy: radius@0.
	].

	self isRoundedRight ifTrue: [
		self drawCircle: radius position: bounds topRight - (diameter@0) on: aCanvas color: aTrick currentColor antialiasing: self antialiasing.
		rectangle := rectangle withWidth: rectangle width - radius.
	].
	
	aCanvas fillRectangle: rectangle basicFillStyle: (SolidFillStyle color: aTrick currentColor).
]
