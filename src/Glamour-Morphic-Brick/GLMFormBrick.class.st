Class {
	#name : #GLMFormBrick,
	#superclass : #GLMBandBrick,
	#category : #'Glamour-Morphic-Brick-Widgets-Basic'
}

{ #category : #examples }
GLMFormBrick class >> example [
	<example: 'Input form with title, two labels, four checkboxes and submit button'>
	^ self new
		title: [ :t | t
			text: 'Grüezi' ];
		label: [ :l | l
			text: 'What would you like to eat?' ];
		checkbox: [ :c | c
			id: #fondue;
			check;
			text: 'Cheese Fondue, CHF 20.-' ];
		checkbox: [ :c | c
			id: #raclette;
			text: 'Raclette, CHF 15.-' ];
		
		label: [ :l | l 
			text: 'What would you like to drink?'];
		checkbox: [ :c | c
			id: #schorle;
			text: 'Apfel Schorle, CHF 4.-' ];
		checkbox: [ :c | c
			id: #rivella;
			check;
			text: 'Rivella, CHF 4.-' ];
		submit;
		yourself
]

{ #category : #open }
GLMFormBrick class >> exampleInWindow [

	self example
		when: GLMFormSubmitted do: [ :ann | ann result brickAlert ];
		openCenteredInBrickWindow
]

{ #category : #'brick-structure-converting' }
GLMFormBrick >> asFormValue [
	|result|
	result := OrderedCollection new.
	self subbricks do: [ :each |
		each asFormValue ifNotNil: [ :v | result addAll: v asCollection ] ].
	^ result
]

{ #category : #scripting }
GLMFormBrick >> checkbox [

	^ self addBrickBack: self newCheckbox
]

{ #category : #scripting }
GLMFormBrick >> checkbox: aBlock [

	aBlock cull: self checkbox
	
]

{ #category : #initialization }
GLMFormBrick >> initialize [
	super initialize.
	
	self
		hShrinkWrap;
		color: Color veryVeryLightGray muchLighter;
		borderWidth: 1;
		borderColor: Color veryVeryLightGray;
		padding: # (4 7)
]

{ #category : #scripting }
GLMFormBrick >> label [

	^ self addBrickBack: self newLabel
]

{ #category : #scripting }
GLMFormBrick >> label: aBlock [

	aBlock cull: self label
	
]

{ #category : #'instance creation' }
GLMFormBrick >> newButton [

	^ GLMButtonBrick new margin: #(3 0)
]

{ #category : #'instance creation' }
GLMFormBrick >> newCheckbox [

	^ GLMCheckboxBrick new margin: #(3 0)
]

{ #category : #'instance creation' }
GLMFormBrick >> newLabel [

	^ GLMLabelBrick new margin: #(3 0)
]

{ #category : #scripting }
GLMFormBrick >> submit [

	^ self addBrickBack: (
		self newButton
			text: 'Submit';
			when: #onClicked do: [ self submitForm ])
]

{ #category : #scripting }
GLMFormBrick >> submit: aBlock [

	aBlock cull: self submit
]

{ #category : #actions }
GLMFormBrick >> submitForm [

	self announce: (GLMFormSubmitted new result: self asFormValue)
]

{ #category : #scripting }
GLMFormBrick >> title [

	^ self addBrickBack: (self newLabel hAlign: #center)
]

{ #category : #scripting }
GLMFormBrick >> title: aBlock [

	aBlock cull: self title
]
