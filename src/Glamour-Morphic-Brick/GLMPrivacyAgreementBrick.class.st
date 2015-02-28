Class {
	#name : #GLMPrivacyAgreementBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'titleBrick',
		'persistSettingsCheckboxBrick',
		'basicAgreeCheckboxBrick'
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
				vShrinkWrap;
				yourself);
		yourself)
			openInBrickWindow
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> basicAgreeCheckboxBrick [
	^ basicAgreeCheckboxBrick
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> basicAgreeCheckboxBrick: anObject [
	basicAgreeCheckboxBrick := anObject.
	self basicAgreeCheckboxBrick
		marginTop: 5;
		check: self sendUsageData;
		action: [ :boolean | self sendUsageData: boolean ];
		text: self defaultGeneralText.

	self addBrickBack: self basicAgreeCheckboxBrick.
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> defaultExplanationText [

	^ 'Help us improve Spotter by allowing us to collect usage data.'
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> defaultGeneralText [

	^ 'Send anonymous usage data'
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> defaultMargin [

	^ 5
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> initialize [
	super initialize.
	
	self useVerticalLinearLayout.
	self titleBrick: self newTitleBrick.
	self basicAgreeCheckboxBrick: self newCheckboxBrick.
	self persistSettingsCheckboxBrick: self newCheckboxBrick.
]

{ #category : #'instance creation' }
GLMPrivacyAgreementBrick >> newCheckboxBrick [

	^ GLMCheckboxBrick new
		hSpaceFill;
		vShrinkWrap;
		margin: #(3 0);
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

{ #category : #preferences }
GLMPrivacyAgreementBrick >> persistSettings [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ false ].
	^ settingsClass uniqueInstance persistSettings
]

{ #category : #preferences }
GLMPrivacyAgreementBrick >> persistSettings: aBoolean [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ self ].
	settingsClass uniqueInstance persistSettings: aBoolean
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> persistSettingsCheckboxBrick [
	^ persistSettingsCheckboxBrick 
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> persistSettingsCheckboxBrick: anObject [
	persistSettingsCheckboxBrick := anObject.
	self persistSettingsCheckboxBrick
		check: self persistSettings;
		action: [ :boolean | self persistSettings: boolean ];
		marginTop: 15;
		text: 'Remember setting (set as default for all local images)'.
	
	self addBrickBack: self persistSettingsCheckboxBrick.
]

{ #category : #preferences }
GLMPrivacyAgreementBrick >> sendUsageData [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ false ].
	^ settingsClass uniqueInstance sendUsageData
]

{ #category : #preferences }
GLMPrivacyAgreementBrick >> sendUsageData: aBoolean [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ self ].
	^ settingsClass uniqueInstance sendUsageData: aBoolean
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
		margin: self themer privacyAgreementThemer margin;
		font: self themer privacyAgreementThemer font;
		text: self defaultExplanationText.
		
	self addBrickBack: self titleBrick
]
