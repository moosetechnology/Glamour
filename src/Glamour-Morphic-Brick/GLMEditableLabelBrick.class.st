"
A GLMEditableLabelBrick is improved label that can be edited in-place double-clicking on it or using edit icon

Instance Variables
	editBrick:		<Object>
	labelBrick:		<Object>

editBrick
	- xxxxx

labelBrick
	- xxxxx

"
Class {
	#name : #GLMEditableLabelBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'labelBrick',
		'editBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #examples }
GLMEditableLabelBrick class >> example [
	<example: 'Editable label simple example'>
	^ self new
		text: 'Click me to edit. Press enter to accept';
		yourself
]

{ #category : #examples }
GLMEditableLabelBrick class >> exampleOpen [

	self example openCenteredInBrickWindow
]

{ #category : #'label-brick-actions' }
GLMEditableLabelBrick >> beEdit [
	
	self editBrick updateTextWith: self labelBrick text.
	self editBrick moveCursorToIndex: 1.
	self editBrick rubric width: self width.
	self borderColor: (Color r: 52 g: 153 b: 219 range: 255).

	self addBrickFirst: self editBrick.
	self editBrick rubric takeKeyboardFocus.
]

{ #category : #'label-brick-actions' }
GLMEditableLabelBrick >> beNormal [
	

	self borderColor: Color transparent.

	self removeBrick: self editBrick
]

{ #category : #initialization }
GLMEditableLabelBrick >> defaultBorderWidth [

	^ 2
]

{ #category : #'reflective operations' }
GLMEditableLabelBrick >> doesNotUnderstand: aMessage [
	^ self labelBrick
		perform: aMessage selector
		withArguments: aMessage arguments
]

{ #category : #'label-brick-accessing' }
GLMEditableLabelBrick >> editBrick [

	^ editBrick
]

{ #category : #'label-brick-accessing' }
GLMEditableLabelBrick >> editBrick: aBrick [

	editBrick := aBrick.
	
	self editBrick
		hShrinkWrap;
		vSpaceFill;
		zIndex: 2;
		margin: self defaultBorderWidth;
		marginTop: self defaultBorderWidth - 1;
		"marginBottom: 10;"
		margins: (0@0 extent: 5@5);
		withoutAdornment;
		rubricTextFamilyName: StandardFonts defaultFont familyName;
		rubricBorderWidth: 0;
		rubricBorderColor: Color transparent;
		floating: #left.
		
	self editBrick textArea announcer subscribe: RubReturnEntered  send: #onTextAccepted: to: self.
]

{ #category : #'brick-layout-properties' }
GLMEditableLabelBrick >> hShrinkWrap [
	super hShrinkWrap.
	
	self labelBrick hShrinkWrap.
	self editBrick hShrinkWrap
]

{ #category : #'brick-layout-properties' }
GLMEditableLabelBrick >> hSpaceFill [
	super hSpaceFill.
	
	self labelBrick hSpaceFill.
	self editBrick hSpaceFill
]

{ #category : #initialization }
GLMEditableLabelBrick >> initialize [
	super initialize.
	
	self labelBrick: self newLabelBrick.
	self editBrick: self newEditBrick.
	
	self
		color: (Color r: 236 g: 240 b: 241 range: 255);
		padding: self defaultBorderWidth;
		borderWidth: self defaultBorderWidth;
		hShrinkWrap;
		vShrinkWrap;
		enable;
		when: #onClicked do: [ (self hasSubbrick: self editBrick) ifFalse: [ self beEdit ] ]
]

{ #category : #'label-brick-accessing' }
GLMEditableLabelBrick >> labelBrick [

	^ labelBrick
]

{ #category : #'label-brick-accessing' }
GLMEditableLabelBrick >> labelBrick: aBrick [

	labelBrick := aBrick.
	
	self addBrickBack: labelBrick
	
]

{ #category : #'label-brick-creation' }
GLMEditableLabelBrick >> newEditBrick [

	^ GLMRubTextFieldBrick new
]

{ #category : #'label-brick-creation' }
GLMEditableLabelBrick >> newLabelBrick [

	^ GLMLabelBrick new
]

{ #category : #'label-events' }
GLMEditableLabelBrick >> onTextAccepted: ann [

	self labelBrick text: ann morph text.
	self beNormal
]

{ #category : #'brick-layout-properties' }
GLMEditableLabelBrick >> vShrinkWrap [
	super vShrinkWrap.
	
	self labelBrick vShrinkWrap.
	self editBrick vShrinkWrap
]

{ #category : #'brick-layout-properties' }
GLMEditableLabelBrick >> vSpaceFill [
	super vSpaceFill.
	
	self labelBrick vSpaceFill.
	self editBrick vSpaceFill
]
