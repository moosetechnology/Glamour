Class {
	#name : #GLMBrowser,
	#superclass : #Object,
	#instVars : [
		'browserType',
		'context',
		'type'
	],
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMBrowser >> browserType [

	^browserType
]

{ #category : #'as yet unclassified' }
GLMBrowser >> browserType: anObject [

	browserType := anObject
]

{ #category : #'as yet unclassified' }
GLMBrowser >> context [
	^context ifNil: [context := GLMVariableContext new]
]

{ #category : #'as yet unclassified' }
GLMBrowser >> context: anObject [

	context := anObject
]

{ #category : #'browser types' }
GLMBrowser >> finder [

	^self browserType: GLMFinderType new
]

{ #category : #'browser protocol' }
GLMBrowser >> for: aConditionBlock show: aTransformationBlock using: aRendererBlock [

	self context on: aConditionBlock put: (GLMContext transform: aTransformationBlock renderer: aRendererBlock)
]

{ #category : #'browser protocol' }
GLMBrowser >> openOn: anObject [

	| window |
	self context entity: anObject.

	window := SystemWindow labelled: 'Glamorous Browser'.
	window model: nil.
	window extent: 640 @ 480.
	window addMorph: (self browserType glamorousValue: self context) frame:  (0 @ 0 corner: 1 @ 1).
	window openInWorld.
]
