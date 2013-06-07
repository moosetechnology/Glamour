Class {
	#name : #GLMTablePresentation,
	#superclass : #GLMListingPresentation,
	#instVars : [
		'columns'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMTablePresentation >> addColumn: aColumn [
	self columns add: aColumn
]

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock [
	self addColumn: (GLMTableColumn new title: aBlockOrString; computation: aBlock)
]

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock width: aNumber [ 
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString; 
		computation: aBlock;
		width: aNumber;
		yourself)	
]

{ #category : #private }
GLMTablePresentation >> column: aGlamourColumn valueFor: anObject [
	^ aGlamourColumn computation glamourValue: 
		(anObject asGlamorousMultiValue,
		 self entity asGlamorousMultiValue)
]

{ #category : #accessing }
GLMTablePresentation >> columns [
	^ columns ifNil: [ columns := OrderedCollection new ]
]

{ #category : #accessing }
GLMTablePresentation >> columns: aCollection [
	columns := aCollection 
]

{ #category : #rendering }
GLMTablePresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderTablePresentation: self
]

{ #category : #private }
GLMTablePresentation >> titleValueOfColumn: aColumn [
	^ aColumn title glamourValue: self entity
]
