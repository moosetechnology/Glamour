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
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString; 
		computation: aBlock)
]

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock sortedBy: aSortingBlock [
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString; 
		computation: aBlock;
		sortBlock: aSortingBlock)
]

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock tags: anObject [ 
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString; 
		computation: aBlock;
		tags: anObject)
]

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock tags: anObject filtered: anotherObject [
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString; 
		computation: aBlock;
		tagsBlock: anObject;
		tagsFilter: anotherObject)
]

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock tags: anObject sortedBy: aSortingBlock [
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString; 
		computation: aBlock;
		tags: anObject;
		sortBlock: aSortingBlock)
]

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock width: aNumber [ 
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString; 
		computation: aBlock;
		width: aNumber;
		yourself)	
]

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock width: aNumber tags: anObject [
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString; 
		computation: aBlock;
		width: aNumber;
		tags: anObject;
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

{ #category : #tags }
GLMTablePresentation >> computeTagsFilterFor: aGlamourValue [
	| tags |
	
	tags := OrderedCollection new.
	self columns collect: [ :aColumn | 
		tags addAll: (aColumn computeTagsFilterFor: aGlamourValue) ].
	^ tags
]

{ #category : #tags }
GLMTablePresentation >> computeTagsFor: anObject [
	| tags |
	
	tags := OrderedCollection new.
	self columns collect: [ :aColumn | 
		tags addAll: (aColumn computeTagsFor: anObject) ].
	^ tags
]

{ #category : #testing }
GLMTablePresentation >> hasTags [

	^ self columns anySatisfy: [ :aColumn | aColumn hasTags ]
]

{ #category : #testing }
GLMTablePresentation >> hasTagsFilter [

	^ self columns anySatisfy: [ :aColumn | aColumn hasTagsFilter ]
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
