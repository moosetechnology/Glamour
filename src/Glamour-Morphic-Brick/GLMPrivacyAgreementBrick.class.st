Class {
	#name : #GLMPrivacyAgreementBrick,
	#superclass : #GLMBrick,
	#instVars : [
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
GLMPrivacyAgreementBrick class >> exampleOpen [

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
			extent: 600@400
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
				self sendUsageData: boolean ];
		text: self defaultGeneralText.

	self addBrickBack: self basicAgreeCheckboxBrick.
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
GLMPrivacyAgreementBrick >> defaultSaveDefaultSettingsButtonText [
	
	^ 'Export Settings'
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> defaultSettingsInfoBrick [
	^ defaultSettingsInfoBrick
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> initialize [
	super initialize.
	
	self useVerticalLinearLayout.
	self basicAgreeCheckboxBrick: self newCheckboxBrick.
	self saveDefaultSettingsButtonBrick: self newButtonBrick.
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

{ #category : #preferences }
GLMPrivacyAgreementBrick >> persistSettings [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ false ].
	^ settingsClass persistSettings
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
		hSpaceFill: 90;
		vShrinkWrap;
		marginTop: 15;
		marginBottom: 0;
		text: self defaultSaveDefaultSettingsButtonText;
		when: #onClicked do: [ :anAnnouncemnt :anAnnoucer | 
			self persistSettings ].
	
	self addBrickBack: self saveDefaultSettingsButtonBrick
]

{ #category : #preferences }
GLMPrivacyAgreementBrick >> sendUsageData [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ false ].
	^ settingsClass sendUsageData
]

{ #category : #preferences }
GLMPrivacyAgreementBrick >> sendUsageData: aBoolean [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ self ].
	^ settingsClass sendUsageData: aBoolean
]
