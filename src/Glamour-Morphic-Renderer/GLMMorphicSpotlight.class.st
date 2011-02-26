Class {
	#name : #GLMMorphicSpotlight,
	#superclass : #DialogWindow,
	#instVars : [
		'textMorph',
		'text',
		'answer',
		'childrenMorphs'
	],
	#category : #'Glamour-Morphic-Renderer-Spotter'
}

{ #category : #'instance creation' }
GLMMorphicSpotlight class >> on: aRequest [
	^ self basicNew initializeOn: aRequest
]

{ #category : #'instance creation' }
GLMMorphicSpotlight class >> openOn: aRequest [
	^ UITheme builder openModal: (self on: aRequest)
]

{ #category : #accessing }
GLMMorphicSpotlight >> answer [
	^ answer
]

{ #category : #accessing }
GLMMorphicSpotlight >> answer: anObject [
	answer := anObject
]

{ #category : #accessing }
GLMMorphicSpotlight >> childrenMorphs [
	^ childrenMorphs
]

{ #category : #accessing }
GLMMorphicSpotlight >> childrenMorphs: anObject [
	childrenMorphs := anObject
]

{ #category : #callbacks }
GLMMorphicSpotlight >> editorKeyStroke: anEvent [
"	anEvent keyCharacter = Character arrowDown ifTrue: [
		self listIndex: (self listIndex + 1 min: listValues size).
		^ true ].
	anEvent keyCharacter = Character arrowUp ifTrue: [
		self listIndex: (self listIndex - 1 max: 1). 
		^ true ]."
	^ false
]

{ #category : #initialization }
GLMMorphicSpotlight >> initialize [ 
	childrenMorphs := OrderedCollection new.
	super initialize
]

{ #category : #initialization }
GLMMorphicSpotlight >> initializeOn: aRequest [
	model := aRequest.
	self initialize.
	self title: aRequest prompt.
	self text: aRequest default

]

{ #category : #morphic }
GLMMorphicSpotlight >> newContentMorph [
	^ (self newColumn: 
			((OrderedCollection with: self newTextMorph) addAll: self newListMorphs; yourself) )
		minWidth: 320;
		minHeight: 200;
		yourself
]

{ #category : #morphic }
GLMMorphicSpotlight >> newListMorphs [
	| list |
	self model requests do: [:each | 
		list := (GLMMorphicSingleSpotlight on: each).
		self childrenMorphs add: list ].
	^ childrenMorphs collect: #newListMorph
]

{ #category : #morphic }
GLMMorphicSpotlight >> newTextMorph [
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

{ #category : #accessing }
GLMMorphicSpotlight >> text [
	^ text
]

{ #category : #accessing }
GLMMorphicSpotlight >> text: aString [
	text = aString
		ifTrue: [ ^ self ].
	text := aString.
	self childrenMorphs do: [:each | each text: aString ].
	self changed: #text; changed: #isEnabled
]

{ #category : #accessing }
GLMMorphicSpotlight >> textMorph [
	^ textMorph
]

{ #category : #accessing }
GLMMorphicSpotlight >> textMorph: anObject [
	textMorph := anObject
]
