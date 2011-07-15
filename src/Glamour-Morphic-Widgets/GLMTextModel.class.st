Class {
	#name : #GLMTextModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'text',
		'highlightSmalltalk',
		'highlightSmalltalkContext',
		'variableBindings'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #callbacks }
GLMTextModel >> accept: aText notifying: anObject [ 
	aText asString withBlanksTrimmed ifEmpty: [^self].
	self text: aText.
	self changed: #text
]

{ #category : #accessing }
GLMTextModel >> addVariableBinding: anAssociation [
	self variableBindings at: anAssociation key put: anAssociation value
]

{ #category : #accessing }
GLMTextModel >> bindingOf: aSymbol [
	^ self variableBindings associationAt: aSymbol ifAbsent: [nil]
]

{ #category : #accessing }
GLMTextModel >> hasBindingOf: aSymbol [
	^ self variableBindings includesKey: aSymbol
]

{ #category : #accessing }
GLMTextModel >> hasBindingThatBeginsWith: aString [
	^ self variableBindings keys anySatisfy: [:each | each beginsWith: aString]
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
	anEvent anyModifierKeyPressed ifTrue: [ ^ super keystroke: anEvent from: aMorph ].
	self glamourPresentation text: self text.
	^ false
]

{ #category : #callbacks }
GLMTextModel >> menu: aMorphMenu shifted: b [
	^ self menu: aMorphMenu
]

{ #category : #callbacks }
GLMTextModel >> selectSilently: anIndex [
	self changed: #selection
]

{ #category : #accessing }
GLMTextModel >> selectedClassOrMetaClass [
	^ self highlightSmalltalkContext
]

{ #category : #callbacks }
GLMTextModel >> selection [
	^ self glamourPresentation selectionInterval ifNil: [1 to: 0]
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

{ #category : #accessing }
GLMTextModel >> variableBindings [
	^ variableBindings ifNil: [variableBindings := Dictionary new]
]

{ #category : #accessing }
GLMTextModel >> variableBindings: anObject [
	variableBindings := anObject
]
