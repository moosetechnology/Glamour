Class {
	#name : #GLMPopupDialogBrick,
	#superclass : #GLMEmptyPopupBrick,
	#instVars : [
		'contentBricks'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #examples }
GLMPopupDialogBrick class >> example [

	self openExample: [ :b |
		self new
			addText: 'Text' asText allBold;
			addCheckbox: 'Send anonymous data' checked: false action: [ :bool | self inform: bool ];
			addCheckbox: 'Send queries and selected elements' checked: false action: [ :bool | self inform: bool ];
			addButton: 'Save as default' action: [ self inform: 'Saved' ];
			openFor: b
	]
]

{ #category : #examples }
GLMPopupDialogBrick class >> exampleAggrement [

	self openExample: [ :b |
		self new
			addContentBrick: (
				GLMPrivacyAgreementBrick new
					padding: 2;
					borderColor: Color lightGray;
					borderWidth: 2;
					margin: 10;
					hSpaceFill;
					vShrinkWrap;
					yourself);
			openFor: b
	]
]

{ #category : #examples }
GLMPopupDialogBrick class >> exampleText [

	self openExample: [ :b |
		self new
			addText: 'Text';
			addText: 'Very long long text';
			addCheckbox: 'Can you check it?' 
				action: [ :boolean | self inform: 'Toggled to ', boolean asString ] 
				checked: true;
			padding: 2;
			openFor: b
	]
]

{ #category : #examples }
GLMPopupDialogBrick class >> exampleTextBelow [

	self openExample: [ :b |
		self new
			addText: 'Title';
			addText: 'A brief description';
			addCheckbox: 'Can you uncheck me?' 
				action: [ :boolean | self inform: 'Toggled to ', boolean asString ] 
				checked: true;
			padding: 2;
			openBelowFor: b
	]
]

{ #category : #adding }
GLMPopupDialogBrick >> addCheckbox: aString action: aBlock checked: aBoolean [
	^ self addContentBrick: (
				GLMCheckboxBrick new 
					text: aString;
					check: aBoolean;
					action: aBlock;
					yourself)
]

{ #category : #adding }
GLMPopupDialogBrick >> addContentBrick: aBrick [
	^ self contentBricks addLast: aBrick
]

{ #category : #accessing }
GLMPopupDialogBrick >> addContentBricks [
	self contentBricks do: [ :eachBrick |
		self contentBrick addBrickBack: eachBrick ]
]

{ #category : #adding }
GLMPopupDialogBrick >> addText: aTextOrString [
	^ self addContentBrick: (GLMLabelBrick new text: aTextOrString; yourself)
]

{ #category : #accessing }
GLMPopupDialogBrick >> contentBricks [
	^ contentBricks ifNil: [ contentBricks := OrderedCollection new ]
]
