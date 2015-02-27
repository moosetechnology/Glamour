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
GLMPopupBrick class >> exampleAll [
	<example: 'all types'>

	(GLMBrick new
		addBrickBack: (self createButton: [ :b | self new openFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beHelp; openFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beError; openFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beSuccess; openFor: b ]);
		marginTop: 35)
			asBrickedMorph
				extent: 300@120;
				openInWindow
]

{ #category : #examples }
GLMPopupBrick class >> exampleAllBelow [
	<example: 'all types below'>

	(GLMBrick new
		addBrickBack: (self createButton: [ :b | self new openBelowFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beHelp; openBelowFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beError; openBelowFor: b ]);
		addBrickBack: (self createButton: [ :b | self new beSuccess; openBelowFor: b ]);
		marginTop: 35)
			asBrickedMorph
				extent: 300@120;
				openInWindow
]

{ #category : #examples }
GLMPopupBrick class >> exampleError [
	<example: 'Popup brick example with anchor'>

	self openExample: [ :b | self new beError; openFor: b ]
]

{ #category : #examples }
GLMPopupBrick class >> exampleHelp [
	<example: 'Popup brick example with anchor'>

	self openExample: [ :b | self new beHelp; openFor: b ]
]

{ #category : #examples }
GLMPopupBrick class >> exampleNormal [
	<example: 'Popup brick example with anchor'>

	self openExample: [ :b | self new openFor: b ]
]

{ #category : #examples }
GLMPopupBrick class >> exampleSuccess [
	<example: 'Popup brick example with anchor'>

	self openExample: [ :b | self new beSuccess; openFor: b ]
]

{ #category : #opening }
GLMPopupBrick >> addContentBricks [
	self titleBrick: self newTitleBrick.
	self hintBrick: self newHintBrick.

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
