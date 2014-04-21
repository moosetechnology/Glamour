Class {
	#name : #GLMRubricSmalltalkTextModel,
	#superclass : #GLMRubricTextModel,
	#instVars : [
		'highlightSmalltalk',
		'highlightSmalltalkContext'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #'as yet unclassified' }
GLMRubricSmalltalkTextModel >> highlightSmalltalk [
	^ highlightSmalltalk
]

{ #category : #'as yet unclassified' }
GLMRubricSmalltalkTextModel >> highlightSmalltalk: aBoolean [
	highlightSmalltalk := aBoolean
]

{ #category : #'as yet unclassified' }
GLMRubricSmalltalkTextModel >> highlightSmalltalkContext [
	^ highlightSmalltalkContext
]

{ #category : #'as yet unclassified' }
GLMRubricSmalltalkTextModel >> highlightSmalltalkContext: aClassOrMetaclass [
	highlightSmalltalkContext := aClassOrMetaclass
]

{ #category : #'as yet unclassified' }
GLMRubricSmalltalkTextModel >> shoutAboutToStyle: aPluggableShoutMorph [
	self highlightSmalltalk ifFalse: [^ false].
	self highlightSmalltalkContext ifNotNil: [ :classOrMetaClass |
 		aPluggableShoutMorph classOrMetaClass: classOrMetaClass  ].
	^ true
]
