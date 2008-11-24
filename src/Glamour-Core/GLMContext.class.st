Class {
	#name : #GLMContext,
	#superclass : #Object,
	#instVars : [
		'rendererBlock',
		'entity',
		'transformationBlock',
		'parentContext',
		'selectedEntity',
		'observers'
	],
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMContext class >> transform: aTransformationBlock renderer: aRendererBlock [

	^self new
		transformation: aTransformationBlock;
		renderer: aRendererBlock;
		yourself
]

{ #category : #announcing }
GLMContext >> announce: anObject [
	(self observersAt: anObject) do: [ :each |
		each value: anObject
	]
]

{ #category : #'as yet unclassified' }
GLMContext >> asDisplayObject [

	^ rendererBlock glamorousValue: self
]

{ #category : #'as yet unclassified' }
GLMContext >> entity [

	^ entity
]

{ #category : #'as yet unclassified' }
GLMContext >> entity: anEntity [

	entity := anEntity
]

{ #category : #'as yet unclassified' }
GLMContext >> items [
	^ self transformationOf: self entity
]

{ #category : #announcing }
GLMContext >> observers [
	^ observers ifNil: [ observers := Dictionary new ]
]

{ #category : #announcing }
GLMContext >> observersAt: aSymbol [
	^ self observers at: aSymbol ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #announcing }
GLMContext >> on: anObject do: aBlock [
	(self observersAt: anObject) add: aBlock
]

{ #category : #announcing }
GLMContext >> onSelectionChange: aBlock [
	self on: GLMContextSelectionChanged do: aBlock
]

{ #category : #'as yet unclassified' }
GLMContext >> renderer: aRendererBlock [

	rendererBlock := aRendererBlock 
]

{ #category : #'as yet unclassified' }
GLMContext >> selection [
	
	^ selectedEntity
]

{ #category : #'as yet unclassified' }
GLMContext >> selectionIndex [
	^ self items indexOf: self selection
]

{ #category : #'as yet unclassified' }
GLMContext >> selectionIndex: anInteger [ 
	selectedEntity := self items at: anInteger.
	self halt.
	self announce: (GLMContextSelectionChanged new context: self; yourself)
]

{ #category : #'as yet unclassified' }
GLMContext >> transformation: aTransformationBlock [

	transformationBlock := aTransformationBlock
]

{ #category : #'as yet unclassified' }
GLMContext >> transformationOf: anObject [

	^ transformationBlock glamorousValue: anObject
]
