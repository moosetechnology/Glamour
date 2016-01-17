"
A GLMTablePresentation shows the given elements within a table.  If the #children block is set then it support a tree-like table where elements can be expanded.

Each column of the presetation can have its own tags and its own sorting block.

Instance Variables
	children:		<Object>
	columns:		<Object>
	rootsExpanded:		<Object>

children
	- xxxxx

columns
	- xxxxx

rootsExpanded
	- xxxxx

"
Class {
	#name : #GLMTablePresentation,
	#superclass : #GLMListingPresentation,
	#instVars : [
		'columns',
		'children',
		'rootsExpanded',
		'shouldShowHeader'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMTablePresentation >> addColumn: aColumn [
	self columns add: aColumn
]

{ #category : #validation }
GLMTablePresentation >> allDisplayedDo: aBlock [
	self displayValue do: [ :eachRoot | 
		self withChildrenOf: eachRoot do: aBlock ]
]

{ #category : #accessing }
GLMTablePresentation >> children [
	 
	^ children
]

{ #category : #accessing }
GLMTablePresentation >> children: anObject [ 
	 
	children := anObject
]

{ #category : #accessing }
GLMTablePresentation >> childrenValueOf: anObject [
	^ self children glamourValue: (anObject asGlamorousMultiValue, self entity asGlamorousMultiValue)
]

{ #category : #accessing }
GLMTablePresentation >> childrenValueOf: anObject atLevel: anInteger [
	^ self children glamourValue: (
		anObject asGlamorousMultiValue, 
		self entity asGlamorousMultiValue,
		anInteger asGlamorousMultiValue,
		self asGlamorousMultiValue)
]

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock [
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString; 
		computation: aBlock)
]

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock modified: aModifiedBlock [
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString;
		computation: aBlock;
		modifiedBlock: aModifiedBlock)
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

{ #category : #scripting }
GLMTablePresentation >> column: aBlockOrString evaluated: aBlock width: aNumber tags: anObject sortedBy: aSortingBlock [
	self addColumn: (GLMTableColumn new 
		title: aBlockOrString; 
		computation: aBlock;
		width: aNumber;
		tags: anObject;
		sortBlock: aSortingBlock
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

{ #category : #validation }
GLMTablePresentation >> defaultValidate: anObject on: aPort [
	"we only allow objects that are in the display value"
	(aPort name == #selection) ifFalse: [ ^ true ].
	self entity isNil ifTrue: [ ^ false ].
	self allDisplayedDo: [:each | each = anObject ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'default actions' }
GLMTablePresentation >> exportToCSV [
	FileSystem workingDirectory / 'table-export.csv' writeStreamDo: [ :stream |
		self columns do: [ :column | 
						stream 
							nextPut: $";
							nextPutAll: (self titleValueOfColumn: column);
							nextPut: $" ]
						separatedBy: [ stream nextPut: $, ].
		stream cr.
		self displayValue 
			do: [ :each |
				self columns 
					do: [ :column | 
						stream 
							nextPut: $";
							nextPutAll: (self column: column valueFor: each) asString;
							nextPut: $" ]
					separatedBy: [ stream nextPut: $, ].
				stream cr ]
			displayingProgress: 'Exporting' ]
]

{ #category : #testing }
GLMTablePresentation >> hasTags [

	^ self columns anySatisfy: [ :aColumn | aColumn hasTags ]
]

{ #category : #testing }
GLMTablePresentation >> hasTagsFilter [

	^ self columns anySatisfy: [ :aColumn | aColumn hasTagsFilter ]
]

{ #category : #accessing }
GLMTablePresentation >> hideHeader [
	shouldShowHeader := false
]

{ #category : #initialization }
GLMTablePresentation >> initialize [
	super initialize.
	children := [ #() ]
]

{ #category : #'default actions' }
GLMTablePresentation >> installExportToCSV [
	self 
		act: [ self exportToCSV ]
		entitled: 'Export to CSV'
]

{ #category : #rendering }
GLMTablePresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderTablePresentation: self
]

{ #category : #accessing }
GLMTablePresentation >> shouldRootsExpand [
	^ rootsExpanded ifNil: [false]
]

{ #category : #accessing }
GLMTablePresentation >> shouldRootsExpand: anObject [
	rootsExpanded := anObject
]

{ #category : #accessing }
GLMTablePresentation >> shouldShowHeader [
	^ shouldShowHeader ifNil: [ shouldShowHeader := true ]
]

{ #category : #private }
GLMTablePresentation >> titleValueOfColumn: aColumn [
	^ aColumn title glamourValue: self entity
]

{ #category : #validation }
GLMTablePresentation >> withChildrenOf: anObject do: aBlock [
	aBlock value: anObject.
	(self childrenValueOf: anObject) do: [ :each |
		self withChildrenOf: each do: aBlock ]
]
