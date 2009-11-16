Class {
	#name : #GLMTablePresentation,
	#superclass : #GLMListingPresentation,
	#instVars : [
		'columns'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #'as yet unclassified' }
GLMTablePresentation >> addColumn: aColumn [
	self columns add: aColumn
]

{ #category : #'as yet unclassified' }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock [
	self addColumn: (GLMTableColumn new title: aBlockOrString; computation: aBlock)
]

{ #category : #'as yet unclassified' }
GLMTablePresentation >> columns [
	^ columns ifNil: [ columns := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
GLMTablePresentation >> columns: aCollection [
	columns := aCollection 
]

{ #category : #rendering }
GLMTablePresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderTablePresentation: self
]
