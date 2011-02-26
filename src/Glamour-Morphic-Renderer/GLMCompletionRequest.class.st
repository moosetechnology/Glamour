Class {
	#name : #GLMCompletionRequest,
	#superclass : #Notification,
	#instVars : [
		'prompt',
		'default',
		'assisted',
		'searchBlock',
		'labelBlock',
		'iconBlock'
	],
	#category : #'Glamour-Morphic-Renderer-Spotter'
}

{ #category : #utilities }
GLMCompletionRequest class >> substring: testString matches: aString caseSensitive: aBoolean [
	"Checks if a testString is a substring of aString. The matching parts do not necessarily need to be consecutive, for example 'egli' matches 'renggli'."

	| index |
	index := 0.
	testString do: [ :char |
		index := aString
			findString: (String with: char)
			startingAt: index + 1
			caseSensitive: aBoolean.
		index = 0
			ifTrue: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
GLMCompletionRequest >> assisted [
	^ assisted
]

{ #category : #accessing }
GLMCompletionRequest >> assisted: aBoolean [
	"A boolean indicating that the typing of the user is assisted but not constrained."
	
	assisted := aBoolean
]

{ #category : #configuration }
GLMCompletionRequest >> collection: aCollection [
	self collection: aCollection caseSensitive: false
]

{ #category : #configuration }
GLMCompletionRequest >> collection: aCollection caseSensitive: aBoolean [
	"Configure this completion dialog with aCollection and match the elements case sensitive if aBoolean is true. Display the complete list if the filter is empty."

	self searchBlock: [ :value |
		value isEmpty
			ifTrue: [ aCollection ]
			ifFalse: [
				aCollection select: [ :each |
					self class
						substring: value
						matches: (self labelFor: each)
						caseSensitive: aBoolean ] ] ]
]

{ #category : #accessing }
GLMCompletionRequest >> default [
	^ default
]

{ #category : #accessing }
GLMCompletionRequest >> default: aString [
	"The default string initially used for filtering."
	
	default := aString
]

{ #category : #dispatching }
GLMCompletionRequest >> handleWith: anObject [
	^ anObject handleCompletionRequest: self
]

{ #category : #accessing }
GLMCompletionRequest >> iconBlock [
	^ iconBlock
]

{ #category : #accessing }
GLMCompletionRequest >> iconBlock: aOneArgumentBlock [
	"A one argument block answering the icon symbol for a given element."
	
	iconBlock := aOneArgumentBlock
]

{ #category : #querying }
GLMCompletionRequest >> iconFor: anObject [
	^ iconBlock value: anObject
]

{ #category : #initialization }
GLMCompletionRequest >> initialize [
	super initialize.
	prompt := 'Completion Request'.
	default := String new.
	assisted := false.
	searchBlock := [ :value | #() ].
	labelBlock := [ :value | value asString ].
	iconBlock := [ :value | nil ]
]

{ #category : #accessing }
GLMCompletionRequest >> labelBlock [
	^ labelBlock
]

{ #category : #accessing }
GLMCompletionRequest >> labelBlock: aOneArgumentBlock [
	"A one argument block answering the string for a given element."
	
	labelBlock := aOneArgumentBlock
]

{ #category : #querying }
GLMCompletionRequest >> labelFor: anObject [
	^ labelBlock value: anObject
]

{ #category : #accessing }
GLMCompletionRequest >> name [
	^self prompt
]

{ #category : #accessing }
GLMCompletionRequest >> prompt [
	^ prompt
]

{ #category : #accessing }
GLMCompletionRequest >> prompt: aString [
	"A string with the title for this request."
	
	prompt := aString
]

{ #category : #accessing }
GLMCompletionRequest >> searchBlock [
	^ searchBlock
]

{ #category : #accessing }
GLMCompletionRequest >> searchBlock: aOneArgumentBlock [
	"A one argument block returning the elements for the given filter."
	
	searchBlock := aOneArgumentBlock
]

{ #category : #querying }
GLMCompletionRequest >> valuesFor: anObject [
	^ searchBlock value: anObject
]
