Class {
	#name : #GLMRubTextFieldBrick,
	#superclass : #GLMRubScrolledTextBrick,
	#instVars : [
		'isCentered'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #examples }
GLMRubTextFieldBrick class >> example [
	<example: 'Rubric text field that shrinks to fit height and width of the text'>
	
	^ self new
			padding: 20;
			borderWidth: 20;
			borderColor: Color lightGray;
			setTextWith: 'Hello world!';
			yourself
]

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleFullSpaceFill [
	<example: 'Rubric centered text field that fills parent'>
	
	^ GLMBrick new
		hSpaceFill;
		vSpaceFill;
		padding: #(20 20);
		color: Color veryVeryLightGray;
		addBrickBack: (
			self new
				hSpaceFill;
				vSpaceFill;
				setTextWith: 'Hello world!';
				yourself);
		yourself
]

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleFullSpaceFillCentered [
	<example: 'Rubric centered text field that fills parent'>
	
	^ GLMBrick new
		hSpaceFill;
		vSpaceFill;
		padding: #(20 20);
		color: Color veryVeryLightGray;
		addBrickBack: (
			self new
				hSpaceFill;
				vSpaceFill;
				beCentered;
				setTextWith: 'Hello world!';
				yourself);
		yourself
]

{ #category : #'examples-open' }
GLMRubTextFieldBrick class >> exampleFullSpaceFillCenteredOpen [

	self exampleFullSpaceFillCentered openCenteredInBrickWindow
]

{ #category : #'examples-open' }
GLMRubTextFieldBrick class >> exampleFullSpaceFillOpen [

	self exampleFullSpaceFill openCenteredInBrickWindow
]

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleHSpaceFill [
	<example: 'Rubric text field that shrinks to fit height of the text and fills parent width'>
	
	^ GLMBrick new
		hSpaceFill;
		vShrinkWrap;
		padding: #(20 20);
		color: Color veryVeryLightGray;
		addBrickBack: (
			self new
				hSpaceFill;
				setTextWith: 'Hello world!';
				yourself);
		yourself
]

{ #category : #'examples-open' }
GLMRubTextFieldBrick class >> exampleHSpaceFillOpen [

	self exampleHSpaceFill openCenteredInBrickWindow
]

{ #category : #'examples-open' }
GLMRubTextFieldBrick class >> exampleOpen [

	self example openCenteredInBrickWindow
]

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleVSpaceFill [
	<example: 'Rubric text field that shrinks to fit width of the text and fills parent height'>
	
	^ GLMBrick new
		hShrinkWrap;
		vSpaceFill;
		padding: #(20 20);
		color: Color veryVeryLightGray;
		addBrickBack: (
			self new
				vSpaceFill;
				setTextWith: 'Hello world!';
				yourself);
		yourself
]

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleVSpaceFillCentered [
	<example: 'Rubric centered text field that shrinks to fit width of the text and fills parent height'>
	
	^ GLMBrick new
		hShrinkWrap;
		vSpaceFill;
		padding: #(20 20);
		color: Color veryVeryLightGray;
		addBrickBack: (
			self new
				vSpaceFill;
				beCentered;
				setTextWith: 'Hello world!';
				yourself);
		yourself
]

{ #category : #'examples-open' }
GLMRubTextFieldBrick class >> exampleVSpaceFillCenteredOpen [

	self exampleVSpaceFillCentered openCenteredInBrickWindow
]

{ #category : #'examples-open' }
GLMRubTextFieldBrick class >> exampleVSpaceFillOpen [

	self exampleVSpaceFill openCenteredInBrickWindow
]

{ #category : #'brick-properties' }
GLMRubTextFieldBrick >> beCentered [

	isCentered := true.
	self isVFilling
		ifTrue: [ self rubric forceHeight: [ self height ] ].
]

{ #category : #initialization }
GLMRubTextFieldBrick >> initialize [
	super initialize.
	
	self
		vShrinkWrap;
		hShrinkWrap
]

{ #category : #'rubric-testing' }
GLMRubTextFieldBrick >> isCentered [

	^ isCentered ifNil: [ isCentered := false ]
]

{ #category : #'rubric-brick-creation' }
GLMRubTextFieldBrick >> newRubricMorph [

	^ GLMRubTextFieldMorph new
]

{ #category : #'brick-geometry' }
GLMRubTextFieldBrick >> shrinkingWidth [

	self rubric width: self rubric textArea width.
	self onLayouted.
	^ self rubric textArea width
]

{ #category : #'as yet unclassified' }
GLMRubTextFieldBrick >> vSpaceFill [
	super vSpaceFill.
	
	self isCentered ifTrue: [ self beCentered ]
]
