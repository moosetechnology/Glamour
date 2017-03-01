"
I am a popup with a text editor allowing users to ""in-place"" edit values
"
Class {
	#name : #GLMEditPopupBrick,
	#superclass : #GLMEmptyPopupBrick,
	#instVars : [
		'titleBrick',
		'titleText',
		'textModel',
		'textEditBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI-Popup'
}

{ #category : #examples }
GLMEditPopupBrick class >> exampleOpen [
	
	self gtExample openCenteredInBrickWindowLabeled: 'All Popup Types'
]

{ #category : #examples }
GLMEditPopupBrick class >> gtExample [
	<gtExample>
	<label: 'Example of all popup types'>

	^ GLMBrick new
		hShrinkWrap;
		vShrinkWrap;
		addBrickBack: (self createLabel: [ :b |
			self new
				textModel: 'haba';
				openBelowFor: b ]);
		marginBottom: 35;
		yourself
]

{ #category : #'instance creation' }
GLMEditPopupBrick >> newTextEditField [

	^ GLMRubEditingAreaBrick new
		wrapped: false;
		hShrinkWrap;
		vShrinkWrap;
		text: self textModel;
		yourself
]

{ #category : #'events-processing' }
GLMEditPopupBrick >> onCreated [

	self contentBrick padding: 2.
	self textEditBrick: self newTextEditField
]

{ #category : #'events-processing' }
GLMEditPopupBrick >> onOpened [
	super onOpened.

	self textEditBrick
		takeKeyboardFocus;
		selectAll
]

{ #category : #accessing }
GLMEditPopupBrick >> textEditBrick [
	^ textEditBrick
]

{ #category : #accessing }
GLMEditPopupBrick >> textEditBrick: aBrick [
	textEditBrick := aBrick.
	
	self contentBrick addBrickBack: self textEditBrick
]

{ #category : #accessing }
GLMEditPopupBrick >> textModel [
	^ textModel ifNil: [ textModel := '' ]
]

{ #category : #accessing }
GLMEditPopupBrick >> textModel: aTextModel [
	textModel := aTextModel.
	
	self textEditBrick ifNotNil: [ :aTextEditBrick | aTextEditBrick text: self textModel ]
]
