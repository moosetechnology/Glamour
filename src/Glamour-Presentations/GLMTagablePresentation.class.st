Class {
	#name : #GLMTagablePresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'tagsBlock'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #testing }
GLMTagablePresentation >> hasTags [
	^ tagsBlock notNil
]

{ #category : #accessing }
GLMTagablePresentation >> tagsBlock [
	^ tagsBlock
]

{ #category : #accessing }
GLMTagablePresentation >> tagsBlock: anObject [
	tagsBlock := anObject
]

{ #category : #accessing }
GLMTagablePresentation >> tagsFor: anObject [
	| value |
	self hasTags ifFalse: [ ^ OrderedCollection new ].
	value := self tagsBlock glamourValue: (anObject asGlamorousMultiValue, self entity asGlamorousMultiValue).
	^ value isString
		ifTrue: [ OrderedCollection with: value ]
		ifFalse: [ value asOrderedCollection ]
]
