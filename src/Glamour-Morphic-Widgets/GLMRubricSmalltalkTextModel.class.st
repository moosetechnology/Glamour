Class {
	#name : #GLMRubricSmalltalkTextModel,
	#superclass : #GLMRubricTextModel,
	#instVars : [
		'highlightSmalltalk',
		'highlightSmalltalkContext',
		'bindingsStrategy',
		'variableBindings'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #bindings }
GLMRubricSmalltalkTextModel >> appendVariableBinding: anAssociationList [

	anAssociationList ifNotNil: [
		anAssociationList do: [ :anAssociation | 
			self variableBindings at: anAssociation key put: anAssociation value ] ]
]

{ #category : #bindings }
GLMRubricSmalltalkTextModel >> bindingOf: aSymbol [

	^ self bindingsStrategy cull: self variableBindings cull: aSymbol
]

{ #category : #bindings }
GLMRubricSmalltalkTextModel >> bindingsStrategy [

	^ bindingsStrategy ifNil: [ bindingsStrategy := self defaultBindingsStrategy ]
]

{ #category : #bindings }
GLMRubricSmalltalkTextModel >> bindingsStrategy: aBlock [

	bindingsStrategy := aBlock
]

{ #category : #bindings }
GLMRubricSmalltalkTextModel >> defaultBindingsStrategy [

	^ [ :currentBindings :aSymbol |
		 currentBindings associationAt: aSymbol ifAbsent: [nil] ]
]

{ #category : #bindings }
GLMRubricSmalltalkTextModel >> guessTypeForName: aString [ 
	^ nil
]

{ #category : #bindings }
GLMRubricSmalltalkTextModel >> hasBindingOf: aSymbol [

	^ self variableBindings includesKey: aSymbol
]

{ #category : #bindings }
GLMRubricSmalltalkTextModel >> hasBindingThatBeginsWith: aString [
	^ self variableBindings keys anySatisfy: [:each | each beginsWith: aString]
]

{ #category : #shout }
GLMRubricSmalltalkTextModel >> highlightSmalltalk [
	^ highlightSmalltalk
]

{ #category : #shout }
GLMRubricSmalltalkTextModel >> highlightSmalltalk: aBoolean [
	highlightSmalltalk := aBoolean
]

{ #category : #shout }
GLMRubricSmalltalkTextModel >> highlightSmalltalkContext [
	^ highlightSmalltalkContext
]

{ #category : #shout }
GLMRubricSmalltalkTextModel >> highlightSmalltalkContext: aClassOrMetaclass [
	highlightSmalltalkContext := aClassOrMetaclass
]

{ #category : #'as yet unclassified' }
GLMRubricSmalltalkTextModel >> isCodeCompletionAllowed [ 
	^true
]

{ #category : #shout }
GLMRubricSmalltalkTextModel >> shoutAboutToStyle: aPluggableShoutMorph [
	self highlightSmalltalk ifFalse: [^ false].
	self highlightSmalltalkContext ifNotNil: [ :classOrMetaClass |
 		aPluggableShoutMorph classOrMetaClass: classOrMetaClass  ].
	^ true
]

{ #category : #bindings }
GLMRubricSmalltalkTextModel >> variableBindings [
	^ variableBindings ifNil: [variableBindings := Dictionary new]
]

{ #category : #bindings }
GLMRubricSmalltalkTextModel >> variableBindings: aDictionary [
	variableBindings := aDictionary
]
