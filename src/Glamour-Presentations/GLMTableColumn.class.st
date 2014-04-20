"
This is a helper class for the TablePresentation.

Instance Variables:
	title	<ProtoObject | PseudoContext>
	computation	<ProtoObject | PseudoContext>
"
Class {
	#name : #GLMTableColumn,
	#superclass : #Object,
	#instVars : [
		'title',
		'computation',
		'width',
		'tagsBlock',
		'tagsFilterBlock'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMTableColumn >> computation [
	^ computation
]

{ #category : #accessing }
GLMTableColumn >> computation: anObject [
	computation := anObject
]

{ #category : #tags }
GLMTableColumn >> computeTagsFilterFor: aGlamourValue [ 

	^ self computeTagsFor: aGlamourValue from: self tagsFilterBlock
]

{ #category : #tags }
GLMTableColumn >> computeTagsFor: aGlamourValue [ 

	^ self computeTagsFor: aGlamourValue from: self tagsBlock
]

{ #category : #tags }
GLMTableColumn >> computeTagsFor: aGlamourValue from: aBlock [
	| value |
	
	value := aBlock glamourValue: aGlamourValue.
	^ value isString
		ifTrue: [ OrderedCollection with: value ]
		ifFalse: [ value asOrderedCollection ]
]

{ #category : #testing }
GLMTableColumn >> hasTags [
	^ tagsBlock notNil
]

{ #category : #testing }
GLMTableColumn >> hasTagsFilter [
	^ tagsFilterBlock notNil
]

{ #category : #accessing }
GLMTableColumn >> tags: anObject [

	tagsBlock := anObject.
	self hasTagsFilter ifFalse:[ tagsFilterBlock := anObject ]
]

{ #category : #accessing }
GLMTableColumn >> tagsBlock [
	^ tagsBlock
]

{ #category : #accessing }
GLMTableColumn >> tagsBlock: anObject [
	tagsBlock := anObject
]

{ #category : #accessing }
GLMTableColumn >> tagsFilter: anObject [
	tagsFilterBlock := anObject 
]

{ #category : #accessing }
GLMTableColumn >> tagsFilterBlock [
	^ tagsFilterBlock
]

{ #category : #accessing }
GLMTableColumn >> title [
	^ title
]

{ #category : #accessing }
GLMTableColumn >> title: anObject [
	title := anObject
]

{ #category : #accessing }
GLMTableColumn >> width [
	^ width ifNil: [200]
]

{ #category : #accessing }
GLMTableColumn >> width: anObject [
	width := anObject
]
