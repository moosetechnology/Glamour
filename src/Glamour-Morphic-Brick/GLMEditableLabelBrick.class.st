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
		'editBrick',
		'borderAnimation'
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

{ #category : #geometry }
GLMEditableLabelBrick >> approximateHeight [
	
	^ self labelBrick approximateHeight + self vMargin + self vPadding
]

{ #category : #geometry }
GLMEditableLabelBrick >> approximateWidth [
	
	^ self hMargin + self hPadding + (self isReadMode
		ifTrue: [ self labelBrick approximateWidth ]
		ifFalse: [ self editBrick width + self editBrick hPadding + self editBrick hMargin])
]

{ #category : #'label-brick-actions' }
GLMEditableLabelBrick >> beEdit [

	self editBrick updateTextWith: self labelBrick text.
	self editBrick moveCursorToIndex: self labelBrick text size + 1.

	self addBrickFirst: self editBrick.
	self removeBrick: self labelBrick.
	self borderColor: (self themer focusedBorderColor alpha: 0).
	self editBrick rubric takeKeyboardFocus.
]

{ #category : #'label-brick-actions' }
GLMEditableLabelBrick >> beNormal [
	
	self removeBrick: self editBrick.
	self activeHand releaseKeyboardFocus.
	self addBrickBack: self labelBrick
]

{ #category : #'label-brick-accessing' }
GLMEditableLabelBrick >> borderAnimation [

	^ borderAnimation ifNil: [ borderAnimation := GLMAnimation borderColor duration: 200 ]
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
		vShrinkWrap;
		withoutMargins;
		withoutAdornment;
		withoutBorder;
		beTransparent;
		autoAccept: true;
		marginTop: self themer focusedBorderWidth negated;
		rubricTextFamilyName: StandardFonts defaultFont familyName.
		
	self editBrick rubric announcer weak subscribe: RubReturnEntered  send: #onTextAccepted: to: self.
	self editBrick rubric announcer weak subscribe: MorphLostFocus send: #onLostFocus: to: self.
	self editBrick rubric announcer weak subscribe: MorphGotFocus send: #onGotFocus: to: self.
	self editBrick rubric announcer weak subscribe: RubTextAcceptRequest send: #onTextChanged: to: self.
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
		padding: self themer focusedBorderWidth;
		borderWidth: self themer focusedBorderWidth;
		hShrinkWrap;
		vShrinkWrap;
		enable;
		when: #onClicked do: [ (self hasSubbrick: self editBrick) ifFalse: [ self beEdit ] ]
]

{ #category : #'label-brick-testing' }
GLMEditableLabelBrick >> isEditMode [

	^ self hasSubbrick: self editBrick
]

{ #category : #'label-brick-testing' }
GLMEditableLabelBrick >> isReadMode [

	^ self isEditMode not
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
GLMEditableLabelBrick >> onGotFocus: ann [

	self borderAnimation
		from: self borderColor first;
		to: self themer focusedBorderColor;
		animate: self.
]

{ #category : #'label-events' }
GLMEditableLabelBrick >> onLostFocus: ann [
	
	self borderAnimation
		from: self borderColor first;
		to: (self isEditMode ifTrue: [ self themer normalBorderColor ] ifFalse: [ self borderColor first alpha: 0 ]);
		animate: self.
]

{ #category : #'label-events' }
GLMEditableLabelBrick >> onTextAccepted: ann [
	|isChanged|
	
	isChanged := (self text asString = ann morph text asString) not.
	ann morph text isEmpty ifFalse: [ self text: ann morph text ].
	self beNormal.
	isChanged ifTrue: [ self announce: #onAccepted ]
]

{ #category : #'label-events' }
GLMEditableLabelBrick >> onTextChanged: ann [

	self onTextAccepted: ann
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
