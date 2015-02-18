Class {
	#name : #GLMSystemWindowBrick,
	#superclass : #GLMWindowBrick,
	#instVars : [
		'headerBrick',
		'offcanvasBrick',
		'offcanvasAnimation'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Windows'
}

{ #category : #examples }
GLMSystemWindowBrick class >> example [

	super example
]

{ #category : #examples }
GLMSystemWindowBrick class >> exampleContent [

	| rootBrick brick1 brick2 brick3 |
	
	rootBrick := GLMInteractableBrick new
		useVerticalLinearLayout;
		vSpaceFill;
		hSpaceFill;
		paddingLeft: 10;
		paddingTop: 15;
		paddingRight: 20;
		paddingBottom: 5.
	
	" ---- Creating first brick ---- "
	brick1 := GLMStringBrick new
		text: 'Welcome to Brick!';
		textColor: Color white;
		textPosition: #center;
		normalColor: Color veryLightGray;
		selectedColor: Color veryLightGray darker;
		pressedColor: Color gray;
		enable;
		hSpaceFill: 30;
		height: 30.		
		
	" ---- Creating second brick ---- "
	brick2 := GLMInteractableBrick new
		normalColor: Color veryLightGray;
		selectedColor: Color veryLightGray darker;
		pressedColor: Color gray;
		enable;
		margin: #(15 20 5 10);
		hSpaceFill: 90;
		vSpaceFill: 50.
		
		
	" ---- Creating third brick ---- "
	brick3 := GLMStringBrick new
		text: 'Welcome to Brick!';
		textColor: Color black;
		normalColor: Color veryLightGray;
		selectedColor: Color veryLightGray darker;
		pressedColor: Color gray;
		margin: #(15 20 5 10);
		hSpaceFill: 70;
		vSpaceFill: 20.
		
		
	" ---- Add them to the root brick ---- "
	rootBrick
		addBrickBack: brick1;
		addBrickBack: brick2;
		addBrickBack: brick3.
	
	rootBrick openInBrickWindow
]

{ #category : #accessing }
GLMSystemWindowBrick >> brickRoot: aBrick [

	aBrick
		useVerticalLinearLayout;
		color: Color white;
		borderColor: Color veryLightGray;
		borderWidth: self defaultPadding;
		padding: self defaultPadding;
		paddingTop: 0.

	super brickRoot: aBrick
]

{ #category : #initialization }
GLMSystemWindowBrick >> defaultHeaderHeight [

	^ 30
]

{ #category : #initialization }
GLMSystemWindowBrick >> defaultOffcanvasWidth [

	^ 200
]

{ #category : #initialization }
GLMSystemWindowBrick >> defaultPadding [

	^ 2
]

{ #category : #accessing }
GLMSystemWindowBrick >> headerBrick [
	^ headerBrick
]

{ #category : #accessing }
GLMSystemWindowBrick >> headerBrick: anObject [
	headerBrick := anObject.
	
	self headerBrick
		hSpaceFill;
		height: self defaultHeaderHeight;
		padding: #(0 5);
		window: self.
		
	self addBrickBack: self headerBrick
]

{ #category : #actions }
GLMSystemWindowBrick >> hideOffcanvas [

	self offcanvasAnimation ifNotNil: #terminate.
	offcanvasAnimation := GLMAnimation new
		duration: 200;
		from: self offcanvasBrick marginRight;
		to: self defaultOffcanvasWidth negated;
		step: [ :b :from :to :delta | (to - from) * delta + from ];
		onCompleted: [  ];
		animation: [ :b :v | b changedWith: [ b marginRight: v asInteger ] ];
		animate: self offcanvasBrick
]

{ #category : #initialization }
GLMSystemWindowBrick >> initialize [
	super initialize.
	
	self brickRoot: self newBrickRoot.
	self headerBrick: self newHeaderBrick.
	self offcanvasBrick: self newOffcanvasBrick.
	
	
]

{ #category : #testing }
GLMSystemWindowBrick >> isOffcanvasVisible [

	^ self offcanvasBrick marginRight > self defaultOffcanvasWidth negated
]

{ #category : #'instance creation' }
GLMSystemWindowBrick >> newBrickRoot [

	^ GLMWindowRootBrick new
]

{ #category : #'instance creation' }
GLMSystemWindowBrick >> newHeaderBrick [

	^ GLMWindowHeaderBrick new
]

{ #category : #'instance creation' }
GLMSystemWindowBrick >> newOffcanvasBrick [

	^ GLMWindowOffcanvasBrick new
]

{ #category : #accessing }
GLMSystemWindowBrick >> offcanvasAnimation [

	^ offcanvasAnimation
]

{ #category : #accessing }
GLMSystemWindowBrick >> offcanvasBrick [
	^ offcanvasBrick
]

{ #category : #accessing }
GLMSystemWindowBrick >> offcanvasBrick: anObject [
	offcanvasBrick := anObject.
	
	self offcanvasBrick
		vSpaceFill;
		color: Color white;
		width: self defaultOffcanvasWidth;
		borderDo: [ :b | b widthLeft: 1; widthTop: 1; color: Color veryVeryLightGray ];
		paddingLeft: 1;
		paddingTop: 1;
		marginTop: self defaultHeaderHeight;
		marginBottom: self defaultHeaderHeight negated;
		marginRight: self defaultOffcanvasWidth negated.
	
	self offcanvasBrick layout
		floating: #right;
		zIndex: 2.
		
	1 to: 20 do: [ :index |
		self offcanvasBrick addBrickBack: (GLMLabelBrick new
			color: Color white;
			text: ('Menu ', index asString);
			paddingLeft: 10;
			borderDo: [ :b | b widthBottom: 1; colorBottom: Color veryVeryLightGray ];
			hSpaceFill;
			height: 40) ].
	
	self addBrickBack: self offcanvasBrick
]

{ #category : #actions }
GLMSystemWindowBrick >> showOffcanvas [

	self offcanvasAnimation ifNotNil: #terminate.
	offcanvasAnimation := GLMAnimation new
		duration: 200;
		from: self offcanvasBrick marginRight;
		to: self brickRoot paddingRight;
		step: [ :b :from :to :delta | (to - from) * delta + from ];
		onCompleted: [  ];
		animation: [ :b :v | b changedWith: [ b marginRight: v asInteger ] ];
		animate: self offcanvasBrick
]

{ #category : #actions }
GLMSystemWindowBrick >> toggleOffcanvas [

	self isOffcanvasVisible
		ifTrue: [ self hideOffcanvas ]
		ifFalse: [ self showOffcanvas ]
]
