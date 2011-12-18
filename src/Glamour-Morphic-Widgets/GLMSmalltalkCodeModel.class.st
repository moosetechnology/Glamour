Class {
	#name : #GLMSmalltalkCodeModel,
	#superclass : #GLMTextModel,
	#instVars : [
		'highlightSmalltalk',
		'highlightSmalltalkContext',
		'variableBindings'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #accessing }
GLMSmalltalkCodeModel >> addVariableBinding: anAssociation [
	self variableBindings at: anAssociation key put: anAssociation value
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> bindingOf: aSymbol [
	^ self variableBindings associationAt: aSymbol ifAbsent: [nil]
]

{ #category : #completion }
GLMSmalltalkCodeModel >> completionController [
	| controller | 
	controller := self triggerEvent: #getCompletionController.
	controller ifNil: [controller := self initializeCompletionController].
	^controller
]

{ #category : #completion }
GLMSmalltalkCodeModel >> createCompletionController [
	self class environment at: #ECPreferences ifPresent: [ :preferences |
		self class environment at: #OController ifPresent: [ :ocontroller |
			preferences useECompletionInsteadOfOCompletion
				ifTrue: [ ^ ocontroller model: self ] ].
		self class environment at: #ECController ifPresent: [ :eccontroller |
			^ eccontroller model: self ] ].
	^ nil
]

{ #category : #callbacks }
GLMSmalltalkCodeModel >> doItContext [
	^ nil "it might be necessary to ask the presentation"
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> doItReceiver [
	^ self glamourPresentation doItReceiver 
]

{ #category : #completion }
GLMSmalltalkCodeModel >> guessTypeForName: aString [ 
	^ nil
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> hasBindingOf: aSymbol [
	^ self variableBindings includesKey: aSymbol
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> hasBindingThatBeginsWith: aString [
	^ self variableBindings keys anySatisfy: [:each | each beginsWith: aString]
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> highlightSmalltalk [
	^ highlightSmalltalk
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> highlightSmalltalk: anObject [
	highlightSmalltalk := anObject
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> highlightSmalltalkContext [
	^ highlightSmalltalkContext
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> highlightSmalltalkContext: anObject [
	highlightSmalltalkContext := anObject
]

{ #category : #completion }
GLMSmalltalkCodeModel >> initializeCompletionController [
	| controller |
	controller := self createCompletionController.
	self 
		when: #getCompletionController
		evaluate: (MessageSend 
				receiver: controller
				selector: #yourself).
	^ controller
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> selectedClassOrMetaClass [
	^ self highlightSmalltalkContext
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> shoutAboutToStyle: aPluggableShoutMorph [
	self highlightSmalltalk ifFalse: [^ false].
	self highlightSmalltalkContext notNil ifTrue: [
		aPluggableShoutMorph classOrMetaClass: self highlightSmalltalkContext].
	^ true
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> variableBindings [
	^ variableBindings ifNil: [variableBindings := Dictionary new]
]

{ #category : #accessing }
GLMSmalltalkCodeModel >> variableBindings: anObject [
	variableBindings := anObject
]
