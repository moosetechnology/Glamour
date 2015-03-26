"
A GLMRubEditingAreaBrick is basic text editor brick used for multi line input fields. 

vShrinkWrap - height fits text size + vertical paddings
hShrinkWrap - doesn't make any sense.
vSpaceFill - fills parent vertically. Actual text editor height = parent height - vertical paddings
hSpaceFill - doesn't really makes sense, since text area still shrinks to fit text
"
Class {
	#name : #GLMRubEditingAreaBrick,
	#superclass : #GLMRubScrolledTextBrick,
	#category : #'Glamour-Morphic-Brick-Widgets-Basic'
}

{ #category : #examples }
GLMRubEditingAreaBrick class >> example [
	<gtExample: 'Basic Rubric Editing Area'>
	^ self exampleBasic
		updateTextWith: 'Hello world!';
		yourself
]

{ #category : #examples }
GLMRubEditingAreaBrick class >> exampleBand [
	<gtExample: 'Two rubric text areas in band'>
	
	^ GLMBandBrick new
		padding: #(20 20);
		hSpaceFill;
		vShrinkWrap;
		color: Color veryVeryLightGray;
		addAllBricks: { self exampleBasic. self exampleBasic };
		yourself
]

{ #category : #'examples-open' }
GLMRubEditingAreaBrick class >> exampleBandOpen [

	self exampleBand openInBrickWindow
]

{ #category : #examples }
GLMRubEditingAreaBrick class >> exampleBasic [
	<gtExample: 'Basic Rubric Editing Area with padding and border'>
	^ self new
		padding: 20;
		borderWidth: 20;
		margin: 5;
		borderColor: Color veryLightGray
]

{ #category : #examples }
GLMRubEditingAreaBrick class >> exampleFill [
	<gtExample: 'Basic Rubric Editing Area that fills parent'>
	^ self exampleBasic
		vSpaceFill;
		updateTextWith: 'Hello world!';
		yourself
]

{ #category : #'examples-open' }
GLMRubEditingAreaBrick class >> exampleFillOpen [

	self exampleFill openCenteredInBrickWindow
]

{ #category : #'examples-open' }
GLMRubEditingAreaBrick class >> exampleOpen [

	self example openCenteredInBrickWindow
]

{ #category : #examples }
GLMRubEditingAreaBrick class >> exampleScrollPane [
	<gtExample: 'Multiple rubric text areas in scroll pane'>
	
	^ GLMScrollPaneBrick new
		hSpaceFill;
		vSpaceFill;
		color: Color veryVeryLightGray;
		layoutMorphs: true;
		addAllBricks: ((1 to: 20) collect: [ :i | self exampleBasic ]);
		yourself
]

{ #category : #'examples-open' }
GLMRubEditingAreaBrick class >> exampleScrollPaneOpen [
	
	self exampleScrollPane openInBrickWindowLabeled: 'Rubric in ScrollPane'
]

{ #category : #initialization }
GLMRubEditingAreaBrick >> initialize [
	super initialize.
	
	self
		hSpaceFill;
		vShrinkWrap
]

{ #category : #'rubric-brick-creation' }
GLMRubEditingAreaBrick >> newRubricMorph [

	^ RubEditingArea new beWrapped
]

{ #category : #'brick-properties' }
GLMRubEditingAreaBrick >> withoutBackground [

	self rubric color: Color transparent
]
