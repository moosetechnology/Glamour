Class {
	#name : #GLMMorphicSpotlightTry,
	#superclass : #DialogWindow,
	#instVars : [
		'textMorph',
		'text',
		'listMorph',
		'listValues',
		'listLabels',
		'listIndex',
		'answer',
		'listMorphs',
		'listLabelsDict',
		'listModels'
	],
	#category : #'Glamour-Morphic-Renderer-Spotter'
}

{ #category : #'instance creation' }
GLMMorphicSpotlightTry class >> on: aRequest [
	^ self basicNew initializeOn: aRequest
]

{ #category : #'instance creation' }
GLMMorphicSpotlightTry class >> openOn: aRequest [
	^ UITheme builder openModal: (self on: aRequest)
]

{ #category : #accessing }
GLMMorphicSpotlightTry >> answer [
	"Answer the result of the dialog or nil, if this dialog has been cancelled."
	
	^ answer
]

{ #category : #callbacks }
GLMMorphicSpotlightTry >> arrowKey: anEvent from: aMorph [
	"Ignore this request."
]

{ #category : #actions }
GLMMorphicSpotlightTry >> cancel [
	answer := nil.
	^ super cancel
]

{ #category : #callbacks }
GLMMorphicSpotlightTry >> clickIconAt: anInteger [
	"Ignore this request."
]

{ #category : #morphic }
GLMMorphicSpotlightTry >> defaultFocusMorph [
	^ textMorph
]

{ #category : #callbacks }
GLMMorphicSpotlightTry >> doubleClick [
	self ok
]

{ #category : #callbacks }
GLMMorphicSpotlightTry >> editorKeyStroke: anEvent [
	anEvent keyCharacter = Character arrowDown ifTrue: [
		self listIndex: (self listIndex + 1 min: listValues size).
		^ true ].
	anEvent keyCharacter = Character arrowUp ifTrue: [
		self listIndex: (self listIndex - 1 max: 1). 
		^ true ].
	^ false
]

{ #category : #callbacks }
GLMMorphicSpotlightTry >> iconAt: anIndex [
	^ model iconFor: (listValues at: anIndex ifAbsent: [ ^ nil ])
]

{ #category : #initialization }
GLMMorphicSpotlightTry >> initializeOn: aRequest [
	model := aRequest.
	listValues := listLabels := #().
	listIndex := 0.
	self initialize.
	self title: aRequest prompt.
	self text: aRequest default

]

{ #category : #testing }
GLMMorphicSpotlightTry >> isAssisted [
	^ self model assisted
]

{ #category : #testing }
GLMMorphicSpotlightTry >> isEnabled [
	^ "self model assisted
		ifTrue: [ self text isEmptyOrNil not ]
		ifFalse: [ "self listIndex > 0 "]"
]

{ #category : #'accessing-list' }
GLMMorphicSpotlightTry >> list: listName values: aCollection [
	| previous |
	previous := self listSelection: listName.
	listValues := aCollection asArray.
	listLabelsDict at: listName put: (listValues
		collect: [ :each | model labelForList: listName forElement: each ]).
	self changed: #listLabels; listSelection: previous
]

{ #category : #'accessing-list' }
GLMMorphicSpotlightTry >> listIndex [
	^ listIndex
]

{ #category : #'accessing-list' }
GLMMorphicSpotlightTry >> listIndex: anInteger [
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
GLMMorphicSpotlightTry >> listLabels [
	^ listLabels
]

{ #category : #'accessing-list' }
GLMMorphicSpotlightTry >> listSelection [
	^ listValues at: self listIndex ifAbsent: [ nil ]
]

{ #category : #'accessing-list' }
GLMMorphicSpotlightTry >> listSelection: anObject [
	self listIndex: (listValues indexOf: anObject ifAbsent: [ 0 ])
]

{ #category : #'accessing-list' }
GLMMorphicSpotlightTry >> listValues [
	^ listValues
]

{ #category : #'accessing-list' }
GLMMorphicSpotlightTry >> listValues: aCollection [
	| previous |
	previous := self listSelection.
	listValues := aCollection asArray.
	listLabels := listValues
		collect: [ :each | model labelFor: each ].
	self changed: #listLabels; listSelection: previous
]

{ #category : #morphic }
GLMMorphicSpotlightTry >> newContentMorph [
	| allMorphs |
	allMorphs := OrderedCollection new.
	allMorphs 
		add: self newTextMorph;
		addAll: self newListMorphs values.
	
	^ (self newColumn: allMorphs)
		minWidth: 320;
		minHeight: 200;
		yourself
]

{ #category : #morphic }
GLMMorphicSpotlightTry >> newListMorph [
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
GLMMorphicSpotlightTry >> newListMorphs [
	listMorphs := Dictionary new.

	self model requests do: [:aRequest|
		listModels at: aRequest name put: GLMMorphicListModel new.
		
		listMorph := OBPluggableListMorph
			on: (listModels at: aRequest name)
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
			listMorphs at: aRequest put: listMorph.
		].

	^ listMorphs
]

{ #category : #morphic }
GLMMorphicSpotlightTry >> newOKButton [
	^ self newOKButtonFor: self getEnabled: #isEnabled
]

{ #category : #morphic }
GLMMorphicSpotlightTry >> newTextMorph [
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
GLMMorphicSpotlightTry >> ok [
	answer := self model assisted
		ifTrue: [ self text ]
		ifFalse: [ self listSelection ].
	^ super ok
]

{ #category : #'accessing-text' }
GLMMorphicSpotlightTry >> text [
	^ text
]

{ #category : #'accessing-text' }
GLMMorphicSpotlightTry >> text: aString [
	text = aString
		ifTrue: [ ^ self ].
	text := aString.

	self listValues: (self model valuesFor: text).
"	self isAssisted ifFalse: [
		self listIndex: (self listLabels size = 1
			ifTrue: [ 1 ]
			ifFalse: [ self listLabels findFirst: [ :each | each sameAs: text ] ]) ].
"	self changed: #text; changed: #isEnabled
]
