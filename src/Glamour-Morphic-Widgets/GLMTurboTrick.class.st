"
A GLMTurboTrick is the main Trick class. Can holds another Tricks and contains logic of rendering, positioning tricks and also possibilities to interate with them using mouse or keyboard.

The idea of this project is to boost  performance of complicated glamour widgets where smooth and fast work is neccessary.

Instance Variables
	backgroundColor:		<Object>
	bounds:		<Object>
	layoutManager:		<Object>
	layoutParams:		<Object>
	owner:		<Object>
	root:		<Object>
	submorphs:		<Object>

backgroundColor
	- xxxxx

bounds
	- xxxxx

layoutManager
	- xxxxx

layoutParams
	- xxxxx

owner
	- xxxxx

root
	- xxxxx

submorphs
	- xxxxx

"
Class {
	#name : #GLMTurboTrick,
	#superclass : #Object,
	#instVars : [
		'bounds',
		'owner',
		'root',
		'layoutManager',
		'layoutParams',
		'subtricks',
		'normalImage',
		'pressedImage',
		'selectedImage',
		'checkedImage',
		'announcer',
		'checkedColor',
		'normalColor',
		'pressedColor',
		'selectedColor',
		'isSelected',
		'isPressed',
		'isChecked',
		'data',
		'isEnabled',
		'renderer'
	],
	#category : #'Glamour-Morphic-Widgets-Turbo-UI'
}

{ #category : #'as yet unclassified' }
GLMTurboTrick class >> resizeImage: anImage scale: aScale [

	((aScale > (1@0)) | (aScale > (0@1))) ifTrue: [
		^ GLMForm increaseFormExtentCentered: anImage to: (anImage extent * aScale).
	].

	aScale = (1@1) ifTrue: [
		^ anImage
	].
	
	^ anImage magnify: anImage boundingBox by: aScale smoothing: 2.
]

{ #category : #adding }
GLMTurboTrick >> addTrickBack: aTrick [

	subtricks add: aTrick.
	aTrick root: self root.
	aTrick owner: self.
	^ aTrick
]

{ #category : #actions }
GLMTurboTrick >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GLMTurboTrick >> bounds [
	^ bounds
]

{ #category : #private }
GLMTurboTrick >> bounds: aRectangle [
	bounds := (aRectangle origin + ((self layoutParams paddingLeft) @ (self layoutParams paddingTop)))
		corner: (aRectangle corner - ((self layoutParams paddingRight) @ (self layoutParams paddingBottom))).

]

{ #category : #actions }
GLMTurboTrick >> check [
	self isChecked ifFalse: [
		isChecked := true.
		self repaint.
	]
]

{ #category : #accessing }
GLMTurboTrick >> checkedColor [
	^ checkedColor
]

{ #category : #accessing }
GLMTurboTrick >> checkedColor: anObject [
	checkedColor := anObject
]

{ #category : #accessing }
GLMTurboTrick >> checkedImage [
	^ checkedImage
]

{ #category : #accessing }
GLMTurboTrick >> checkedImage: anObject [
	checkedImage := anObject
]

{ #category : #actions }
GLMTurboTrick >> click [
	^ false
]

{ #category : #accessing }
GLMTurboTrick >> currentColor [
	^ self state pressedColor: (self isPressed) selectedColor: (self isSelected) checkedColor: (self isChecked) of: self
]

{ #category : #accessing }
GLMTurboTrick >> currentImage [
	^ self state pressed: (self isPressed) selected: (self isSelected) checked: (self isChecked) of: self
]

{ #category : #accessing }
GLMTurboTrick >> data [

	^ data
]

{ #category : #accessing }
GLMTurboTrick >> data: anObject [
	data := anObject.
	
	self announcer announce: GLMTurboDataChanged new.
]

{ #category : #actions }
GLMTurboTrick >> depress [
	self isPressed ifTrue: [
		isPressed := false.
		self repaint.
		^ true
	].

	^ false
]

{ #category : #actions }
GLMTurboTrick >> deselect [
	self isSelected ifTrue: [
		isSelected := false.
		self repaint.
	]
]

{ #category : #actions }
GLMTurboTrick >> disable [
	isEnabled := false.
]

{ #category : #layouting }
GLMTurboTrick >> doLayout [
	
	self layoutManager position: self.
	
	subtricks do: [ :each |
		each doLayout.
	]
	
]

{ #category : #private }
GLMTurboTrick >> drawOn: aCanvas area: aRectangle [
	|area newCanvasOrigin|
	
	area := aRectangle.
	"do smart drawing logic here"
		
	(aRectangle width = 0) | (aRectangle height = 0) ifTrue: [
		"draw nothing"
		^ self
	].

	self onDraw: aCanvas area: aRectangle.
	
	area := aRectangle translateBy: (self bounds origin negated).
	newCanvasOrigin := aCanvas origin + self bounds origin.
	
	subtricks do: [ :each |
		|intersection canvas drawArea|
		intersection := (area intersect: each bounds ifNone: (0@0 extent: 0@0)).
		
		drawArea := intersection translateBy: (area origin negated).
		
		canvas := aCanvas copyOrigin: newCanvasOrigin clipRect: (drawArea translateBy: newCanvasOrigin).
		
		each drawOn: canvas area: drawArea.
	]
	
	
]

{ #category : #actions }
GLMTurboTrick >> enable [
	
	isEnabled := true.
]

{ #category : #accessing }
GLMTurboTrick >> extent [

	^ self bounds extent
]

{ #category : #geometry }
GLMTurboTrick >> globalBounds [

	^ self bounds translateBy: owner globalBounds origin
]

{ #category : #geometry }
GLMTurboTrick >> globalBoundsOfArea: aRectangle [

	^ aRectangle translateBy: owner globalBounds origin
	
]

{ #category : #'mouse events' }
GLMTurboTrick >> handlesOnMouseDown: evt where: aPoint [
	
	^ self isEnabled
]

{ #category : #'mouse events' }
GLMTurboTrick >> handlesOnMouseDragging: evt where: aPoint [
	
	^ self isEnabled
]

{ #category : #'mouse events' }
GLMTurboTrick >> handlesOnMouseOver: evt where: aPoint [
	
	^ self isEnabled
]

{ #category : #'mouse events' }
GLMTurboTrick >> handlesOnMouseUp: evt where: aPoint [
	
	^ self isEnabled
]

{ #category : #accessing }
GLMTurboTrick >> height [
	^ self bounds height + self layoutParams paddingTop  + self layoutParams paddingTop
]

{ #category : #initialization }
GLMTurboTrick >> initialize [
	super initialize.
	
	isSelected := false.
	isPressed := false.
	isChecked := false.
	isEnabled := false.
	
	subtricks := OrderedCollection new.
	layoutManager := GLMTurboHorizontalLinearLayout new.
	layoutParams := GLMTurboLayoutParams new.
	self renderer: GLMTurboTrickRenderer.
	
	bounds := 0@0 extent: 50@50.
]

{ #category : #actions }
GLMTurboTrick >> isChecked [
	^ isChecked.
]

{ #category : #actions }
GLMTurboTrick >> isEnabled [
	^ isEnabled
]

{ #category : #testing }
GLMTurboTrick >> isFitInParent [

	^ self owner globalBounds containsRect: self globalBounds
]

{ #category : #actions }
GLMTurboTrick >> isPressed [
	^ isPressed.
]

{ #category : #actions }
GLMTurboTrick >> isSelected [
	^ isSelected.
]

{ #category : #accessing }
GLMTurboTrick >> layoutManager [
	^ layoutManager
]

{ #category : #accessing }
GLMTurboTrick >> layoutManager: aLayoutManager [

	layoutManager := aLayoutManager
]

{ #category : #accessing }
GLMTurboTrick >> layoutParams [

	^ layoutParams
]

{ #category : #accessing }
GLMTurboTrick >> normalColor [
	^ normalColor
]

{ #category : #accessing }
GLMTurboTrick >> normalColor: anObject [
	normalColor := anObject
]

{ #category : #accessing }
GLMTurboTrick >> normalImage [
	^ normalImage
]

{ #category : #accessing }
GLMTurboTrick >> normalImage: anObject [
	normalImage := anObject
]

{ #category : #drawing }
GLMTurboTrick >> onDraw: aCanvas area: aRectangle [

	self renderer render: self on: aCanvas. 
]

{ #category : #'mouse events' }
GLMTurboTrick >> onMouseDown: evt where: aPoint [
	^ self press.
]

{ #category : #'mouse events' }
GLMTurboTrick >> onMouseDragging: evt where: aPoint [

	^ false.
]

{ #category : #'mouse events' }
GLMTurboTrick >> onMouseOver: evt where: aPoint [

	^ false.
]

{ #category : #'mouse events' }
GLMTurboTrick >> onMouseUp: evt where: aPoint [

	
	(self bounds containsPoint: aPoint) & (self isPressed) ifTrue: [
		self depress.
		^ self click.
	] ifFalse: [ 
		^ self depress.
	]
]

{ #category : #actions }
GLMTurboTrick >> outOfWorld: aWorld [

	self subtricks do: [ :each |
		each outOfWorld: aWorld.
	]
]

{ #category : #accessing }
GLMTurboTrick >> owner [
	^ owner
]

{ #category : #private }
GLMTurboTrick >> owner: aTrick [

	owner := aTrick.
]

{ #category : #actions }
GLMTurboTrick >> press [
	self isPressed ifFalse: [
		isPressed := true.
		self repaint.
	].

	^ false
]

{ #category : #accessing }
GLMTurboTrick >> pressedColor [
	^ pressedColor
]

{ #category : #accessing }
GLMTurboTrick >> pressedColor: anObject [
	pressedColor := anObject
]

{ #category : #accessing }
GLMTurboTrick >> pressedImage [
	^ pressedImage
]

{ #category : #accessing }
GLMTurboTrick >> pressedImage: anObject [
	pressedImage := anObject
]

{ #category : #private }
GLMTurboTrick >> privateHandleMouseEvent: evt where: aPoint onHandler: aSymbol [
	
	(self bounds containsPoint: aPoint) ifTrue: [
		|consumed|
		consumed := false.
		self subtricks do: [ :each |
			consumed ifFalse: [ consumed := each privateHandleMouseEvent: evt where: (aPoint - self bounds origin) onHandler: aSymbol]
			ifTrue: [ evt type = #mouseUp ifTrue: [ each privateHandleMouseEvent: evt where: (aPoint - self bounds origin) onHandler: aSymbol] ].
		].
			
		consumed ifFalse: [ 
			(self perform: ('handlesOn',aSymbol) asSymbol withEnoughArguments: {evt. aPoint}) ifTrue: [ 
				^ self perform: ('on',aSymbol) asSymbol withEnoughArguments: {evt. aPoint}.
			] ifFalse: [ ^ false ]
		] ifTrue: [ ^ true ]
	] ifFalse: [
		evt type = #mouseUp ifFalse: [ ^ false ].
		self perform: ('on',aSymbol) asSymbol withEnoughArguments: {evt. aPoint}.
		self subtricks do: [ :each |
			each privateHandleMouseEvent: evt where: (aPoint - self bounds origin) onHandler: aSymbol.
		].
	].

	^ false.
]

{ #category : #geometry }
GLMTurboTrick >> relativeBounds [
	^ self bounds translateBy: owner relativeBounds origin
]

{ #category : #adding }
GLMTurboTrick >> removeTrick: aTrick [

	subtricks remove: aTrick ifAbsent: [ ^ aTrick ].
	aTrick root: nil.
	aTrick owner: nil.
	^ aTrick
]

{ #category : #accessing }
GLMTurboTrick >> renderer [

	^ renderer
]

{ #category : #accessing }
GLMTurboTrick >> renderer: aRenderer [

	renderer := aRenderer
]

{ #category : #drawing }
GLMTurboTrick >> repaint [

	(self root isNotNil & self owner isNotNil) ifTrue: [ self root world ifNotNil: [ self root world canvas ifNotNil: [
				"let's leave it untill better times
				|canvas|
				canvas := self root world canvas.
				canvas := canvas copyOrigin: self owner worldBounds origin clipRect: self owner worldBounds.
				
				self drawOn: canvas area: self bounds.
				
				canvas frameRectangle: self bounds width: 1 color: Color red."
				
				self root changed.
	] ] ]
]

{ #category : #accessing }
GLMTurboTrick >> root [

	^ root
]

{ #category : #private }
GLMTurboTrick >> root: aGLMTurboMorph [
	root := aGLMTurboMorph.
	
	self subtricks do: [ :each |
		each root: root.
	]
]

{ #category : #actions }
GLMTurboTrick >> select [
	self isSelected ifFalse: [ 
		isSelected := true.
		self repaint.
	]
]

{ #category : #accessing }
GLMTurboTrick >> selectedColor [
	^ selectedColor
]

{ #category : #accessing }
GLMTurboTrick >> selectedColor: anObject [
	selectedColor := anObject
]

{ #category : #accessing }
GLMTurboTrick >> selectedImage [
	^ selectedImage
]

{ #category : #accessing }
GLMTurboTrick >> selectedImage: anObject [
	selectedImage := anObject
]

{ #category : #accessing }
GLMTurboTrick >> state [

	^ GLMTurboImageState
]

{ #category : #accessing }
GLMTurboTrick >> subtricks [

	^ subtricks
]

{ #category : #actions }
GLMTurboTrick >> uncheck [
	self isChecked ifTrue: [
		isChecked := false.
		self repaint.
	]
]

{ #category : #accessing }
GLMTurboTrick >> width [

	^ self bounds width + self layoutParams paddingLeft  + self layoutParams paddingRight 
]

{ #category : #geometry }
GLMTurboTrick >> worldBounds [

	^ self bounds translateBy: owner worldBounds origin
]
