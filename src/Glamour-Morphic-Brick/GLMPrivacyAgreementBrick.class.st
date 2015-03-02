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
				self updateSefaultSettingInfoText ];
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
	
	^ 'Make default for all images of this user that do not have a setting'
]

{ #category : #preferences }
GLMPrivacyAgreementBrick >> defaultSaveUserDataPreference [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ '' ].
	^ settingsClass defaultSaveUserDataPreference
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> defaultSettingInfoText [

	^ 'Current default setting: ', (self defaultSaveUserDataPreference
		ifNil: [ 'not set (no data is send by default)' ]
		ifNotNil: [ :aBoolean |
			aBoolean 
				ifTrue: [ 'send anonymous usage data' ]
				ifFalse: [ 'do not send any usage data' ] ])
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> defaultSettingsInfoBrick [
	^ defaultSettingsInfoBrick
]

{ #category : #accessing }
GLMPrivacyAgreementBrick >> defaultSettingsInfoBrick: anObject [
	defaultSettingsInfoBrick := anObject.
	self defaultSettingsInfoBrick
		beReadOnly;
		withoutAnyDecorator;
		marginTop: -5;
		marginLeft: 0;
		font: self themer privacyAgreementThemer font;
		text: self defaultSettingInfoText.

	self addBrickBack: self defaultSettingsInfoBrick
]

{ #category : #initialization }
GLMPrivacyAgreementBrick >> initialize [
	super initialize.
	
	self useVerticalLinearLayout.
	self basicAgreeCheckboxBrick: self newCheckboxBrick.
	self saveDefaultSettingsButtonBrick: self newButtonBrick. 
	self defaultSettingsInfoBrick: self newTitleBrick.
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
			self persistSettings.
			self updateSefaultSettingInfoText ].
	
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

{ #category : #actions }
GLMPrivacyAgreementBrick >> updateSefaultSettingInfoText [

	self defaultSettingsInfoBrick
		text: self defaultSettingInfoText.
]
