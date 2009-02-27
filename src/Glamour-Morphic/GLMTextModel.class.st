Class {
	#name : #GLMTextModel,
	#superclass : #Object,
	#instVars : [
		'text',
		'onTextChanged'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #callbacks }
GLMTextModel >> accept: aText notifying: anObject [ 
 	aText asString withBlanksTrimmed ifEmpty: [^self].
	"onTextChanged ifNotNil: [onTextChanged value: aText]."
	text := aText.
	self changed: #text
]

{ #category : #accessing }
GLMTextModel >> onTextChanged: aBlock [
	onTextChanged := aBlock
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
