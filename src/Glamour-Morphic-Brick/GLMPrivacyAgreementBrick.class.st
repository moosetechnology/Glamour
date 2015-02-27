Class {
	#name : #GLMPrivacyAgreementBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'titleBrick',
		'generalCheckboxBrick',
		'buttonsBrick',
		'advancedBrick',
		'buttonAction',
		'submitButton'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #examples }
GLMPrivacyAgreementBrick class >> example [
	<example: 'Simple agreement'>
	^ self new
]

{ #category : #examples }
GLMPrivacyAgreementBrick class >> exampleEmptyAgreementInWindow [

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
				vShrinkWrap;
				yourself);
		yourself)
			openInBrickWindow
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
				vShrinkWrap;
				applicationName: 'Spotter';
				buttonText: 'I agree';
				buttonAction: [ self inform: 'You have agreed.' ];
				checkboxAction: [ :boolean | self inform: 'Send anonymous data set to ', boolean asString ];
				with: [ :b |
					b advancedOption
						text: 'Include search query and selected search results';
						action: [ :boolean | self inform: 'Include search query set to ', boolean asString ].
					b advancedOption
						text: 'Include developer name';
						uncheck;
						action: [ :boolean | self inform: 'Include developer name set to ', boolean asString ].
					];
				yourself);
		yourself)
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
		when: #onClicked do: [ self toggleAdvanced ];
		with: [ :b | b label padding: #(3 0) ];
		hShrinkWrap;
		vShrinkWrap;
		floating: #right;
		hAlign: #right;
		vAlign: #center;
		enable.
		
	self pushButton: button
]

{ #category : #adding }
GLMPrivacyAgreementBrick >> addSubmitButton [

	submitButton := self newButtonBrick.
	submitButton
		text: 'Agree';
		when: #onClicked 
			do: [ :anAnnouncemnt :anAnnoucer | 
						self buttonAction cull: self cull: anAnnouncemnt cull: anAnnoucer ].
	self pushButton: submitButton
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> advancedBrick [
	^ advancedBrick
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> advancedBrick: anObject [
	advancedBrick := anObject.
	
	self advancedBrick
		hSpaceFill;
		margin: self defaultMargin;
		marginLeft: 20;
		marginTop: 0
]

{ #category : #scripting }
GLMPrivacyAgreementBrick >> advancedOption [

	^ self advancedBrick
		addBrickBack: self newCheckboxBrick
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> applicationName: aString [ 
	self titleBrick setTextWith: 'Would you like to help us improve ', aString asString, ', by allowing us to collect anonymous usage data?'
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> buttonAction [
	^ buttonAction ifNil: [ buttonAction := [ self inform: 'You have agreed.' ] ]
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> buttonAction: aBlockClosure [ 
	"It can have one argument receving this brick object."
	buttonAction := aBlockClosure 
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> buttonText: aString [
	submitButton text: aString
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
GLMPrivacyAgreementBrick >> checkboxAction: aBlockClosure [ 
	generalCheckboxBrick action: aBlockClosure 
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> checkboxBrick [
	^ generalCheckboxBrick
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> checkboxBrick: anObject [
	generalCheckboxBrick := anObject.
	
	self checkboxBrick
		text: self defaultGeneralText.
	
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

{ #category : #actions }
GLMPrivacyAgreementBrick >> hideAdvanced [

	self removeBrick: self advancedBrick
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> initialize [
	super initialize.
	
	self useVerticalLinearLayout.
	self addCancelButton.
	self titleBrick: self newTitleBrick.
	self checkboxBrick: self newCheckboxBrick.
	self buttonsBrick: self newButtonsBrick.
	self advancedBrick: self newAdvancedBrick.
	self addSubmitButton.
	self addShowMoreButton
]

{ #category : #'instance creation' }
GLMPrivacyAgreementBrick >> newAdvancedBrick [

	^ GLMBandBrick new
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
		hSpaceFill;
		vShrinkWrap;
		margin: #(5 0);
		marginLeft: self defaultMargin;
		check.
]

{ #category : #'instance creation' }
GLMPrivacyAgreementBrick >> newTitleBrick [

	^ GLMRubTextAreaBrick new
]

{ #category : #scripting }
GLMPrivacyAgreementBrick >> option [
]

{ #category : #adding }
GLMPrivacyAgreementBrick >> pushButton: aButton [

	self buttonsBrick addBrickBack: aButton
]

{ #category : #actions }
GLMPrivacyAgreementBrick >> showAdvanced [

	(self hasSubbrick: self advancedBrick)
		ifFalse: [ self addBrickBack: self advancedBrick ]
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

{ #category : #actions }
GLMPrivacyAgreementBrick >> toggleAdvanced [

	(self hasSubbrick: self advancedBrick)
		ifTrue: [ self hideAdvanced ]
		ifFalse: [ self showAdvanced ]
]
