"
I am a popup with a text editor allowing users to ""in-place"" edit values
"
Class {
	#name : #GLMEditorPopupBrick,
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
GLMEditorPopupBrick class >> exampleOpen [
	
	self gtExample openCenteredInBrickWindowLabeled: 'All Popup Types'
]

{ #category : #examples }
GLMEditorPopupBrick class >> gtExample [
	<gtExample>
	<label: 'Example of all popup types'>

	^ GLMBrick new
		hShrinkWrap;
		vShrinkWrap;
		addBrickBack: (self createLabel: [ :b |
			self new
				closer: (GLMPopupBrickCloser predicate: GLMPopupBrickOutisideClickPredicate new);
				textModel: 'haba';
				openOn: b ]);
		yourself
]

{ #category : #initialization }
GLMEditorPopupBrick >> initialize [
	super initialize.
	
	self themer: self themer popupEditorShadowThemer themer.
	"self themer: self themer popupEditorBorderThemer themer"
]

{ #category : #'instance creation' }
GLMEditorPopupBrick >> newTextEditField [

	^ GLMRubEditingAreaBrick new
		wrapped: false;
		hShrinkWrap;
		vShrinkWrap;
		withoutBorder;
		withoutMargins;
		beForSmalltalkCode;
		text: self textModel;
		yourself
]

{ #category : #'events-processing' }
GLMEditorPopupBrick >> onCreated [

	self textEditBrick: self newTextEditField
]

{ #category : #'events-processing' }
GLMEditorPopupBrick >> onOpened [
	super onOpened.

	self textEditBrick
		takeKeyboardFocus;
		selectAll
]

{ #category : #accessing }
GLMEditorPopupBrick >> textEditBrick [
	^ textEditBrick
]

{ #category : #accessing }
GLMEditorPopupBrick >> textEditBrick: aBrick [
	textEditBrick := aBrick.
	
	self contentBrick addBrickBack: self textEditBrick
]

{ #category : #accessing }
GLMEditorPopupBrick >> textModel [
	^ textModel ifNil: [ textModel := '' ]
]

{ #category : #accessing }
GLMEditorPopupBrick >> textModel: aTextModel [
	textModel := aTextModel.
	
	self textEditBrick ifNotNil: [ :aTextEditBrick | aTextEditBrick text: self textModel ]
]
