Class {
	#name : #GLMTextModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'text',
		'highlightSmalltalk',
		'highlightSmalltalkContext'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #callbacks }
GLMTextModel >> accept: aText notifying: anObject [ 
	aText asString withBlanksTrimmed ifEmpty: [^self].
	self text: aText.
	self changed: #text
]

{ #category : #accessing }
GLMTextModel >> highlightSmalltalk [
	^ highlightSmalltalk
]

{ #category : #accessing }
GLMTextModel >> highlightSmalltalk: anObject [
	highlightSmalltalk := anObject
]

{ #category : #accessing }
GLMTextModel >> highlightSmalltalkContext [
	^ highlightSmalltalkContext
]

{ #category : #accessing }
GLMTextModel >> highlightSmalltalkContext: anObject [
	highlightSmalltalkContext := anObject
]

{ #category : #callbacks }
GLMTextModel >> keystroke: anEvent from: aMorph [
	anEvent anyModifierKeyPressed ifTrue: [ super keystroke: anEvent keyCharacter from: aMorph ].
	self glamourPresentation text: self text.

]

{ #category : #callbacks }
GLMTextModel >> menu: aMorphMenu shifted: b [
	^ self menu: aMorphMenu
]

{ #category : #callbacks }
GLMTextModel >> selectSilently: anIndex [
	self changed: #selection
]

{ #category : #callbacks }
GLMTextModel >> selection [
	^ 1 to: 0
]

{ #category : #accessing }
GLMTextModel >> shoutAboutToStyle: aPluggableShoutMorph [
	self highlightSmalltalk ifFalse: [^ false].
	self highlightSmalltalkContext notNil ifTrue: [
		aPluggableShoutMorph classOrMetaClass: self highlightSmalltalkContext].
	^ true
]

{ #category : #callbacks }
GLMTextModel >> text [
	^text
]

{ #category : #accessing }
GLMTextModel >> text: aTextOrString [
	text := aTextOrString.
	self glamourPresentation ifNotNil: [ :presentation | presentation text: text ]
]
