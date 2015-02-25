Class {
	#name : #GLMPrivacyAgreementBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'titleBrick',
		'generalCheckboxBrick',
		'buttonsBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #examples }
GLMPrivacyAgreementBrick class >> example [
	<example: 'Simple agreement'>
	^ self new
]

{ #category : #examples }
GLMPrivacyAgreementBrick class >> exampleInWindow [

	(GLMBrick new
		hSpaceFill;
		vSpaceFill;
		addBrickBack: (
			self example
				padding: 2;
				borderColor: Color lightGray;
				borderWidth: 2;
				margin: 10;
				hSpaceFill;
				vShrinkWrap);
		yourself)
			"asBrickedMorph
				extent: 400@300;
				openInWindow"
			openInBrickWindow
]

{ #category : #adding }
GLMPrivacyAgreementBrick >> addCancelButton [

	|button|
	button := GLMHintableActionButtonBrick new.
	button
		floating: #right;
		zIndex: 2;
		icon: GLMUIThemeExtraIcons glamorousClose;
		width: [ :b | b icon width * 1.5 ];
		height: [ :b | b icon height * 1.5 ];
		hintTitle: 'Close';
		hintText: '';
		selectedColor: self themer buttonSelectedColor;
		pressedColor: self themer buttonPressedColor;
		when: #onClicked do: [  ];
		enable.
		
	self addBrickBack: button
]

{ #category : #adding }
GLMPrivacyAgreementBrick >> addShowMoreButton [
	|button|

	button := GLMLabelBrick new.
	button
		text: 'Advanced options';
		textColor: (Color r: 51 g: 102 b: 187 range: 255);
		when: #onMouseHover do: [ button label highlight: button label text ];
		when: #onMouseUnhover do: [ button label highlight: nil ]; 
		with: [ :b | b label padding: #(3 0) ];
		width: 100;
		vShrinkWrap;
		floating: #right;
		hAlign: #right;
		vAlign: #center;
		enable.
		
	self pushButton: button
]

{ #category : #adding }
GLMPrivacyAgreementBrick >> addSubmitButton [

	|button|
	button := self newButtonBrick.
	button
		text: 'Agree';
		when: #onClicked do: [  ].
	self pushButton: button
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> buttonsBrick [
	^ buttonsBrick
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> buttonsBrick: anObject [
	buttonsBrick := anObject.
	
	self buttonsBrick
		margin: self defaultMargin;
		hSpaceFill: 100;
		vShrinkWrap.
	
	self addBrickBack: self buttonsBrick
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> checkboxBrick [
	^ generalCheckboxBrick
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> checkboxBrick: anObject [
	generalCheckboxBrick := anObject.
	
	self checkboxBrick
		text: self defaultGeneralText;
		hSpaceFill;
		vShrinkWrap;
		margin: #(5 0);
		marginLeft: self defaultMargin;
		check.
	
	self addBrickBack: self checkboxBrick.
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> defaultExplanationText [

	^ 'Would you like to help us improve %application_name%, by allowing us to collect anonymous usage data?'
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> defaultGeneralText [

	^ 'send anonymous data'
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> defaultMargin [

	^ 5
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> initialize [
	super initialize.
	
	self useVerticalLinearLayout.
	self addCancelButton.
	self titleBrick: self newTitleBrick.
	self checkboxBrick: self newCheckboxBrick.
	self buttonsBrick: self newButtonsBrick.
	self addSubmitButton.
	self addShowMoreButton
]

{ #category : #'instance creation' }
GLMPrivacyAgreementBrick >> newButtonBrick [

	^ GLMButtonBrick new
]

{ #category : #'instance creation' }
GLMPrivacyAgreementBrick >> newButtonsBrick [

	^ GLMBrick new
]

{ #category : #'instance creation' }
GLMPrivacyAgreementBrick >> newCheckboxBrick [

	^ GLMCheckboxBrick new
]

{ #category : #'instance creation' }
GLMPrivacyAgreementBrick >> newTitleBrick [

	^ GLMRubEditingAreaBrick new
]

{ #category : #adding }
GLMPrivacyAgreementBrick >> pushButton: aButton [

	self buttonsBrick addBrickBack: aButton
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> titleBrick [
	^ titleBrick
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> titleBrick: anObject [
	titleBrick := anObject.
	
	self titleBrick
		beReadOnly;
		withoutAnyDecorator;
		margin: { 0 . self defaultMargin };
		marginRight: 15;
		font: TextStyle defaultFont;
		setTextWith: self defaultExplanationText.
		
	self addBrickBack: self titleBrick
]
