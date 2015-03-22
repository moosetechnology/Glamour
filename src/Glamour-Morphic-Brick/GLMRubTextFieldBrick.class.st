"
A GLMRubTextFieldBrick is basic text editor brick used for single line input fields. Supports variety of layout properties: 

vShrinkWrap - height fits text size + vertical paddings
hShrinkWrap - width fits text size + horizontal paddings
vSpaceFill - fills parent vertically. Actual text editor height = parent height - vertical paddings
hSpaceFill - fills parent hprozontally. Actual text editor width = parent width - horizontal paddings
beCentered - actuall text editor field will be centered vertically

Instance Variables
	isCentered:		<Boolean>

isCentered
	- true if actual text editor field should be centered vertically,
	   false otherwise

"
Class {
	#name : #GLMRubTextFieldBrick,
	#superclass : #GLMRubScrolledTextBrick,
	#instVars : [
		'isCentered'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Basic'
}

{ #category : #examples }
GLMRubTextFieldBrick class >> example [
	<example: 'Rubric text field that shrinks to fit height and width of the text'>
	
	^ self exampleWithBorder
			setTextWith: 'Hello world!';
			yourself
]

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleFullSpaceFill [
	<example: 'Rubric centered text field that fills parent'>
	
	^ self exampleWithBorder
			hSpaceFill;
			vSpaceFill;
			setTextWith: 'Hello world!';
			yourself
]

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleFullSpaceFillCentered [
	<example: 'Rubric centered text field that fills parent'>
	^ self exampleWithBorder
			hSpaceFill;
			vSpaceFill;
			beCentered;
			setTextWith: 'Hello world!';
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
	
	^ self exampleWithBorder
			hSpaceFill;
			setTextWith: 'Hello world!';
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
	
	^ self exampleWithBorder
			vSpaceFill;
			setTextWith: 'Hello world!';
			yourself
]

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleVSpaceFillCentered [
	<example: 'Rubric centered text field that shrinks to fit width of the text and fills parent height'>
	
	^ self exampleWithBorder
			vSpaceFill;
			beCentered;
			setTextWith: 'Hello world!';
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

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleWithBorder [
	<example: 'Rubric field with support of border'>
	
	^ self new
			padding: 20;
			borderWidth: 20;
			borderColor: Color lightGray
]

{ #category : #'brick-properties' }
GLMRubTextFieldBrick >> beCentered [

	isCentered := true.
	self isVFilling
		ifTrue: [ self rubric forceHeight: [ self height - self vPadding ] ].
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

{ #category : #'brick-layout-properties' }
GLMRubTextFieldBrick >> vSpaceFill: anInteger [
	super vSpaceFill: anInteger.
	
	self isCentered ifTrue: [ self beCentered ]
]
