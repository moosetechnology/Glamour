Class {
	#name : #GLMTurboDropDownTrick,
	#superclass : #GLMTurboRoundCompositeButtonTrick,
	#instVars : [
		'model',
		'getListSelector',
		'getSelectionSelector',
		'setSelectionSelector',
		'selectHeaderAction',
		'deselectHeaderAction'
	],
	#category : #'Glamour-Morphic-Widgets-Turbo-UI'
}

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> deselectHeaderAction [
	
	^ deselectHeaderAction
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> deselectHeaderActionBock: aBlock [
	
	deselectHeaderAction := MessageSend receiver: aBlock selector: #cull:
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> deselectHeaderSelector: aSymbol [
	
	deselectHeaderAction := MessageSend receiver: self model selector: aSymbol
]

{ #category : #accessing }
GLMTurboDropDownTrick >> dropDownButton [

	^ buttons second
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> getListSelector [

	^ getListSelector
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> getListSelector: anObject [
	"Set the value of getListSelector"

	getListSelector := anObject
]

{ #category : #accessing }
GLMTurboDropDownTrick >> getSelectedObject [

	^ self getSelectionSelector ifNotNil: [ self model perform: self getSelectionSelector ]
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> getSelectionSelector [

	^ getSelectionSelector
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> getSelectionSelector: anObject [

	getSelectionSelector := anObject
]

{ #category : #accessing }
GLMTurboDropDownTrick >> headerButton [

	^ buttons first 
]

{ #category : #initialization }
GLMTurboDropDownTrick >> initialize [
	
	super initialize.
	
	self
		addButton: self newHeaderButton;
		addButton: self newDropDownButton.
	self dropDownButton anchorTrick: self.
	
		
		

]

{ #category : #actions }
GLMTurboDropDownTrick >> markDeselected [

	buttons do: [ :each | each uncheck ]
]

{ #category : #actions }
GLMTurboDropDownTrick >> markSelected [

	buttons do: [ :each | each check ]
]

{ #category : #accessing }
GLMTurboDropDownTrick >> model [

	^ model
]

{ #category : #'ui-building' }
GLMTurboDropDownTrick >> newDropDownButton [
	| dropDownButtonTrick |
	
	dropDownButtonTrick := GLMTurboSelectorButtonTrick new.
	dropDownButtonTrick announcer on: GLMTurboObjectInListSelected do: [ :ann |
		self setSelectionSelector ifNotNil: [ 
			self flag: 'Bug here'.
			"self model perform: self setSelectionSelector withEnoughArguments: ann object" ].
		
		self dropDownButton selectedObject: self getSelectedObject.
		self headerButton data: ann object ].
	
	^ dropDownButtonTrick 
]

{ #category : #'ui-building' }
GLMTurboDropDownTrick >> newHeaderButton [
	|headerButtonTrick|
	
	headerButtonTrick := GLMTurboButtonTrick new.	
	
	headerButtonTrick announcer on: GLMTurboDataChanged do: [
		headerButtonTrick text: headerButtonTrick data asString ].
	
	headerButtonTrick announcer on: GLMTurboButtonClicked  do: [ :ann |
		self headerButton isChecked
			ifTrue: [ 
				self performAction: self deselectHeaderAction withEnoughArguments: #().
				self headerButton uncheck ]
			ifFalse: [ 
				self performAction: self selectHeaderAction withEnoughArguments: {ann data}.
				self headerButton check ] ].
	
	^ headerButtonTrick
]

{ #category : #initialization }
GLMTurboDropDownTrick >> on: anObject list: getListSel selected: getSelectionSel changeSelection: setSelectionSel [ 

	model := anObject.
	self 
		getListSelector: getListSel;
		getSelectionSelector: getSelectionSel;
		setSelectionSelector: setSelectionSel.

	self updateList.
	self updateSelection.
]

{ #category : #actions }
GLMTurboDropDownTrick >> performAction: aMessageSend withEnoughArguments: anArray [

	aMessageSend ifNotNil: [ 
		aMessageSend  valueWithEnoughArguments: anArray ]
]

{ #category : #'as yet unclassified' }
GLMTurboDropDownTrick >> root: aGLMTurboMorph [
	super root: aGLMTurboMorph.
	
	self root ifNotNil: [ self root theme codeWidgetThemer filterTurboButtonStyleFor: self headerButton ]
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> selectHeaderAction [
	
	^ selectHeaderAction
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> selectHeaderActionBock: aBlock [
	
	selectHeaderAction := MessageSend receiver: aBlock selector: #cull:
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> selectHeaderSelector: aSymbol [
	
	selectHeaderAction := MessageSend receiver: self model selector: aSymbol
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> setSelectionSelector [
	
	^ setSelectionSelector
]

{ #category : #'accessing - selectors' }
GLMTurboDropDownTrick >> setSelectionSelector: anObject [
	
	setSelectionSelector := anObject
]

{ #category : #updating }
GLMTurboDropDownTrick >> updateList [

	self getListSelector ifNotNil: [
		self dropDownButton addAllSelectableObjects: (self model perform: self getListSelector) ]
]

{ #category : #updating }
GLMTurboDropDownTrick >> updateSelection [

	self getSelectedObject ifNotNil: [ :selectedObject |
		self dropDownButton selectedObject: selectedObject.
		self headerButton data: selectedObject ]
]
