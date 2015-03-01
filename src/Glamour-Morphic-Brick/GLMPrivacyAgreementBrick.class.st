Class {
	#name : #GLMPrivacyAgreementBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'titleBrick',
		'persistSettingsCheckboxBrick',
		'basicAgreeCheckboxBrick',
		'defaultSettingsInfoBrick',
		'saveDefaultSettingsButtonBrick'
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
		action: [ :boolean | 
				self sendUsageData: boolean.
				self refreshDefaultSettingsButtonBrick ];
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

{ #category : #preferences }
GLMPrivacyAgreementBrick >> defaultSaveUserDataPreference [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ '' ].
	^ settingsClass defaultSaveUserDataPreference
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> initialize [
	super initialize.
	
	self useVerticalLinearLayout.
	self basicAgreeCheckboxBrick: self newCheckboxBrick.
	self refreshDefaultSettingsButtonBrick.
]

{ #category : #'instance creation' }
GLMPrivacyAgreementBrick >> newButtonBrick [

	^ GLMButtonBrick new
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

{ #category : #accessing }
GLMPrivacyAgreementBrick >> refreshDefaultSettingsButtonBrick [

	self defaultSaveUserDataPreference = self sendUsageData 
		ifTrue: [ 
			self saveDefaultSettingsButtonBrick ifNotNil: [ :aBrick |
				saveDefaultSettingsButtonBrick := nil.
				self 
					removeBrick: aBrick;
					changed ] ]
		ifFalse: [  
				self saveDefaultSettingsButtonBrick ifNil: [ 
					self saveDefaultSettingsButtonBrick: self newButtonBrick. 
					self changed.] ]
	
	
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> saveDefaultSettingsButtonBrick [
	^ saveDefaultSettingsButtonBrick
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> saveDefaultSettingsButtonBrick: anObject [
	saveDefaultSettingsButtonBrick := anObject.
	
	self saveDefaultSettingsButtonBrick
		margin: self defaultMargin;
		hSpaceFill: 80;
		vShrinkWrap;
		borderColor: Color red;
		borderWidth: 0;
		marginTop: 5;
		text: 'Make default for all images of this user';
		when: #onClicked do: [ :anAnnouncemnt :anAnnoucer | 
			self persistSettings.
			"self refreshDefaultSettingsButtonBrick"
			"self defer: [self refreshDefaultSettingsButtonBrick]" ].
	
	self addBrickBack: self saveDefaultSettingsButtonBrick
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
