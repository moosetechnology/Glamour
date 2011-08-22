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
		'width'
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
