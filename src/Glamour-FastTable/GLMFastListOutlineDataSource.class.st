"
I'm a model datasource to handle glamour fast outline list presentations.

Description 
--------------------

My basics functionnalities works as in my superclass but I do not get my data at my creation. Instead I ask to my Glamour presentation to get them.

I work with a GLMFastListPresentation and a GLMMorphicFastListRenderer. 

Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	announcer:		This is an announcer use to work with Glamour workflow. 
	glamourPresentation:		This is a glamour presentation use to get some informations as the data manage by myself.
	tagsToFilterBy:		This is a list of filtering tags for the dasaSource.


"
Class {
	#name : #GLMFastListOutlineDataSource,
	#superclass : #FTOutlineDataSource,
	#traits : 'TGLMFastTable + TGLMFastTableTag',
	#classTraits : 'TGLMFastTable classTrait + TGLMFastTableTag classTrait',
	#instVars : [
		'announcer',
		'glamourPresentation',
		'tagsToFilterBy'
	],
	#category : #'Glamour-FastTable-Model'
}

{ #category : #announcing }
GLMFastListOutlineDataSource >> announcer [
	^ announcer ifNil: [ announcer := GLMAnnouncer new ]
]

{ #category : #accessing }
GLMFastListOutlineDataSource >> basicItems [
	^ self glamourPresentation displayValue
]

{ #category : #accessing }
GLMFastListOutlineDataSource >> calculateItems [
	Halt once.
	^ self basicItems collect: [:coll | coll select: [ :each | self elementShouldBeDisplayed: each ] ]
]

{ #category : #accessing }
GLMFastListOutlineDataSource >> cellColumn: column row: rowIndex [ 
	| element cell |
	
	element := self elementAt: rowIndex.
	cell := FTCellMorph new
		cellInset: 5;
		addMorph: (self rowMorphForElement: element);
		yourself.

	(self needSeparatorBefore: rowIndex)
		ifTrue: [ cell withTopSeparator ].

	^ cell
]

{ #category : #accessing }
GLMFastListOutlineDataSource >> glamourPresentation [
	^ glamourPresentation
]

{ #category : #accessing }
GLMFastListOutlineDataSource >> glamourPresentation: aGlamourPresentation [
	glamourPresentation := aGlamourPresentation
]

{ #category : #accessing }
GLMFastListOutlineDataSource >> items [ 
	^ items ifNil: [ items := self calculateItems ]
]

{ #category : #private }
GLMFastListOutlineDataSource >> resetChildrenContent [
	items := self calculateItems.
]

{ #category : #factory }
GLMFastListOutlineDataSource >> rowMorphForElement: element [
	| rowElements |
	rowElements := OrderedCollection new.
	(self glamourPresentation icon cull: element) ifNotNil: [ :icon | rowElements add: icon asMorph ].
	rowElements
		add: (self glamourPresentation formatedDisplayValueOf: element) asMorph;
		addAll: (self tagMorphsFrom: self glamourPresentation for: element).
	^ Smalltalk ui theme newRowIn: World for: rowElements
]

{ #category : #accessing }
GLMFastListOutlineDataSource >> tagsToFilterBy [
	^ tagsToFilterBy ifNil: [ tagsToFilterBy := OrderedCollection new ]
]
