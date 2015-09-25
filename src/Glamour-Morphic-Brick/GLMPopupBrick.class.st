Class {
	#name : #GLMPopupBrick,
	#superclass : #GLMEmptyPopupBrick,
	#instVars : [
		'hintBrick',
		'hintText',
		'titleBrick',
		'titleText'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #examples }
GLMPopupBrick class >> exampleAllTypesBelowOpen [
	
	self gtExampleAllTypesBelow openCenteredInBrickWindowLabeled: 'All Below Popup Types'
]

{ #category : #examples }
GLMPopupBrick class >> exampleAllTypesOpen [
	
	self gtExampleAllTypes openCenteredInBrickWindowLabeled: 'All Popup Types'
]

{ #category : #examples }
GLMPopupBrick class >> gtExampleAllTypes [
	<gtExample>
	<label: 'Example of all popup types'>

	^ GLMBrick new
		hShrinkWrap;
		vShrinkWrap;
		addBrickBack: (self createButton: [ :b | self new openFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beHelp; openFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beError; openFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beSuccess; openFor: b ]);
		marginTop: 35;
		yourself
]

{ #category : #examples }
GLMPopupBrick class >> gtExampleAllTypesBelow [
	<gtExample>
	<label: 'Example of all popup types opening below of anchor brick'>

	^ GLMBrick new
		hShrinkWrap;
		vShrinkWrap;
		addBrickBack: (self createButton: [ :b | self new openBelowFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beHelp; openBelowFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beError; openBelowFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beSuccess; openBelowFor: b ]);
		marginTop: 35
]

{ #category : #'events-processing' }
GLMPopupBrick >> handleListenEvent: anEvent [
	(self isInsideOfTriggerBrick: anEvent) ifFalse: [ self close ]
]

{ #category : #accessing }
GLMPopupBrick >> hintBrick [
	^ hintBrick
]

{ #category : #accessing }
GLMPopupBrick >> hintBrick: anObject [
	hintBrick := anObject.
	
	
	self hintBrick
		textColor: self themer popupThemer textColor.
		
	self contentBrick addBrickBack: self hintBrick
]

{ #category : #accessing }
GLMPopupBrick >> hintText [
	^ hintText ifNil: [ hintText := 'Need help?' ]
]

{ #category : #accessing }
GLMPopupBrick >> hintText: anObject [
	hintText := anObject.
	
	self hintBrick ifNotNil: [ self hintBrick text: self hintText ]
]

{ #category : #'instance creation' }
GLMPopupBrick >> newHintBrick [

	^ GLMLabelBrick new
		text: self hintText;
		padding: #(0 10);
		width: [ :b | b approximateWidth ];
		height: [ :b | b approximateHeight ]
]

{ #category : #'instance creation' }
GLMPopupBrick >> newTitleBrick [

	^ GLMLabelBrick new
		text: self titleText;
		padding: #(0 10);
		width: [ :b | b approximateWidth ];
		height: [ :b | b approximateHeight ]
]

{ #category : #'events-processing' }
GLMPopupBrick >> onCreated [
	self contentBrick padding: #(5 0).
	self titleBrick: self newTitleBrick.
	self hintBrick: self newHintBrick.
]

{ #category : #accessing }
GLMPopupBrick >> titleBrick [
	^ titleBrick
]

{ #category : #accessing }
GLMPopupBrick >> titleBrick: anObject [
	titleBrick := anObject.
	
	self titleBrick
		textColor: self themer popupThemer textColor.
		
	self contentBrick addBrickFirst: self titleBrick
]

{ #category : #accessing }
GLMPopupBrick >> titleText [
	^ titleText ifNil: [ titleText := 'Hi,' ]
]

{ #category : #accessing }
GLMPopupBrick >> titleText: anObject [
	titleText := anObject.
	
	self titleBrick ifNotNil: [ self titleBrick text: self titleText ]
]
