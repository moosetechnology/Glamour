Class {
	#name : #GLMMorphicSingleSpotlight,
	#superclass : #DialogWindow,
	#instVars : [
		'textMorph',
		'text',
		'listMorph',
		'listValues',
		'listLabels',
		'listIndex',
		'answer',
		'parent'
	],
	#category : #'Glamour-Morphic-Renderer-Spotter'
}

{ #category : #'instance creation' }
GLMMorphicSingleSpotlight class >> on: aRequest [
	^ self basicNew initializeOn: aRequest
]

{ #category : #'instance creation' }
GLMMorphicSingleSpotlight class >> on: aRequest parent: parent [
	^ self basicNew initializeOn: aRequest parent: parent
]

{ #category : #'instance creation' }
GLMMorphicSingleSpotlight class >> openOn: aRequest [
	^ UITheme builder openModal: (self on: aRequest)
]

{ #category : #accessing }
GLMMorphicSingleSpotlight >> answer [
	"Answer the result of the dialog or nil, if this dialog has been cancelled."
	
	^ answer
]

{ #category : #callbacks }
GLMMorphicSingleSpotlight >> arrowKey: anEvent from: aMorph [
	"Ignore this request."
]

{ #category : #actions }
GLMMorphicSingleSpotlight >> cancel [
	answer := nil.
	^ super cancel
]

{ #category : #callbacks }
GLMMorphicSingleSpotlight >> clickIconAt: anInteger [
	"Ignore this request."
]

{ #category : #morphic }
GLMMorphicSingleSpotlight >> defaultFocusMorph [
	^ textMorph
]

{ #category : #morphic }
GLMMorphicSingleSpotlight >> deselect [
	self listIndex: 0.  
]

{ #category : #callbacks }
GLMMorphicSingleSpotlight >> doubleClick [
	self ok
]

{ #category : #callbacks }
GLMMorphicSingleSpotlight >> editorKeyStroke: anEvent [
	anEvent keyCharacter = Character arrowDown ifTrue: [
		self listIndex: (self listIndex + 1 min: listValues size).
		^ true ].
	anEvent keyCharacter = Character arrowUp ifTrue: [
		self listIndex: (self listIndex - 1 max: 1). 
		^ true ].
	^ false
]

{ #category : #callbacks }
GLMMorphicSingleSpotlight >> iconAt: anIndex [
	^ model iconFor: (listValues at: anIndex ifAbsent: [ ^ nil ])
]

{ #category : #initialization }
GLMMorphicSingleSpotlight >> initializeOn: aRequest [
	model := aRequest.
	listValues := listLabels := #().
	listIndex := 0.
	self initialize.
	self title: aRequest prompt.
	self text: aRequest default

]

{ #category : #initialization }
GLMMorphicSingleSpotlight >> initializeOn: aRequest parent: theParent [
	parent := theParent.
	self initializeOn: aRequest.

]

{ #category : #testing }
GLMMorphicSingleSpotlight >> isAssisted [
	^ self model assisted
]

{ #category : #testing }
GLMMorphicSingleSpotlight >> isEnabled [
	^ self model assisted
		ifTrue: [ self text isEmptyOrNil not ]
		ifFalse: [ self listIndex > 0 ]
]

{ #category : #'accessing-list' }
GLMMorphicSingleSpotlight >> listIndex [
	^ listIndex
]

{ #category : #'accessing-list' }
GLMMorphicSingleSpotlight >> listIndex: anInteger [
	anInteger isZero not ifTrue: [
		parent selectionIn: self.].
	listIndex = anInteger
		ifTrue: [ ^ self ].
	listIndex := anInteger.
	self listSelection ifNotNil: [ :selection |
		self isAssisted ifTrue: [ 
			text := self model labelFor: self listSelection.
			self changed: #text ] ].
	self changed: #listIndex; changed: #isEnabled
]

{ #category : #'accessing-list' }
GLMMorphicSingleSpotlight >> listLabels [
	^ listLabels
]

{ #category : #'accessing-list' }
GLMMorphicSingleSpotlight >> listSelection [
	^ listValues at: self listIndex ifAbsent: [ nil ]
]

{ #category : #'accessing-list' }
GLMMorphicSingleSpotlight >> listSelection: anObject [

	self listIndex: (listValues indexOf: anObject ifAbsent: [ 0 ])
]

{ #category : #'accessing-list' }
GLMMorphicSingleSpotlight >> listValues [
	^ listValues
]

{ #category : #'accessing-list' }
GLMMorphicSingleSpotlight >> listValues: aCollection [
	| previous |
	previous := self listSelection.
	listValues := aCollection asArray.
	listLabels := listValues
		collect: [ :each | model labelFor: each ].
	self changed: #listLabels; listSelection: previous
]

{ #category : #morphic }
GLMMorphicSingleSpotlight >> newContentMorph [
	^ (self newColumn: { self newTextMorph. self newListMorph })
		minWidth: 320;
		minHeight: 200;
		yourself
]

{ #category : #morphic }
GLMMorphicSingleSpotlight >> newListMorph [
	listMorph := OBPluggableListMorph
		on: self
		list: #listLabels
		selected: #listIndex
		changeSelected: #listIndex:.
	listMorph
		borderStyle: (self theme listNormalBorderStyleFor: listMorph);
		color: (self theme listNormalFillStyleFor: listMorph);
		cornerStyle: self preferredCornerStyle;
		doubleClickSelector: #doubleClick;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		autoDeselect: false.
	^ listMorph
]

{ #category : #morphic }
GLMMorphicSingleSpotlight >> newOKButton [
	^ self newOKButtonFor: self getEnabled: #isEnabled
]

{ #category : #morphic }
GLMMorphicSingleSpotlight >> newTextMorph [
	textMorph := self
		newTextEntryFor: self
		getText: #text
		setText: #text:
		help: nil.
	textMorph
		autoAccept: true;
		selectAll.
	textMorph textMorph
		on: #keyStroke send: #editorKeyStroke: to: self.
	^ textMorph
]

{ #category : #actions }
GLMMorphicSingleSpotlight >> ok [
	answer := self model assisted
		ifTrue: [ self text ]
		ifFalse: [ self listSelection ].
	^ super ok
]

{ #category : #accessing }
GLMMorphicSingleSpotlight >> parent [
	^ parent
]

{ #category : #accessing }
GLMMorphicSingleSpotlight >> parent: anObject [
	parent := anObject
]

{ #category : #'accessing-text' }
GLMMorphicSingleSpotlight >> text [
	^ text
]

{ #category : #'accessing-text' }
GLMMorphicSingleSpotlight >> text: aString [
	text = aString
		ifTrue: [ ^ self ].
	text := aString.
	self listValues: (self model valuesFor: text).
	self isAssisted ifFalse: [
		self listIndex: (self listLabels size = 1
			ifTrue: [ 1 ]
			ifFalse: [ self listLabels findFirst: [ :each | each sameAs: text ] ]) ].
	self changed: #text; changed: #isEnabled
]
