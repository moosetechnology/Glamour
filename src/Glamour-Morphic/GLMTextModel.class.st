Class {
	#name : #GLMTextModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'text'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #callbacks }
GLMTextModel >> accept: aText notifying: anObject [ 
	aText asString withBlanksTrimmed ifEmpty: [^self].
	text := aText.
	self changed: #text
]

{ #category : #callbacks }
GLMTextModel >> keystroke: anEvent from: aMorph [
	anEvent anyModifierKeyPressed ifTrue: [super keystroke: anEvent keyCharacter from: aMorph]
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

{ #category : #callbacks }
GLMTextModel >> text [
	^text
]

{ #category : #accessing }
GLMTextModel >> text: aTextOrString [
	text := aTextOrString
]
