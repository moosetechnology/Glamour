"
This offers support for a do it context.

Example:
context := GLMContext withAll: {#a -> 1 . #b -> 2}.
Compiler new evaluate: 'a + b' in: context to: context
"
Class {
	#name : #GLMContext,
	#superclass : #Object,
	#instVars : [
		'variableBindings'
	],
	#category : #'Glamour-Tools'
}

{ #category : #'instance creation' }
GLMContext class >> with: aBinding withAll: aCollectionOfBindings [
	| col |
	col := OrderedCollection with: aBinding.
	col addAll: aCollectionOfBindings.
	^ self withAll: col
]

{ #category : #'instance creation' }
GLMContext class >> withAll: aCollectionOfBindings [
	^ self new variableBindings: (aCollectionOfBindings inject: Dictionary new into: [:dict :each | dict at: each key put: each value. dict])
]

{ #category : #bindings }
GLMContext >> bindingOf: aKey [
	^ self variableBindings at: #aKey ifAbsent: [nil]
]

{ #category : #bindings }
GLMContext >> method [ 
	^ GLMContext >> #method
]

{ #category : #bindings }
GLMContext >> namedTempAt: index [
	^ self variableBindings at: (self tempNames at: index)
]

{ #category : #bindings }
GLMContext >> tempNames [
	^ self variableBindings keys asSortedCollection
]

{ #category : #accessing }
GLMContext >> variableBindings [
	^ variableBindings
]

{ #category : #accessing }
GLMContext >> variableBindings: anObject [
	variableBindings := anObject
]
