Class {
	#name : #SGLTreeModel,
	#superclass : #SGLWidgetModel,
	#instVars : [
		'roots',
		'filteredRoots',
		'tagsToFilterBy',
		'amountToFilterBy',
		'stepSize',
		'shouldRootsExpand',
		'shouldAllExpand',
		'selection',
		'renderedNodes'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'instance creation' }
SGLTreeModel class >> for: aPresentation [
	|model|
	model := self new glamourPresentation: aPresentation.
	
	"When the morph changes, we want to update the glamour model"
	model announcer on: GLMTreeMorphSelectionChanged do: [ :ann | 
		aPresentation announcer suspendAllWhile: [
			aPresentation selection: ann selectionValue.
			aPresentation selectionPath: ann selectionPathValue] ].
	"aPresentationModel announcer on: GLMTreeMorphStrongSelectionChanged do: [ :ann | 
		aPresentation strongSelection: ann strongSelectionValue ]."
	
	^model
]

{ #category : #accessing }
SGLTreeModel >> allRoots [
	^ filteredRoots ifNil: [ self roots. filteredRoots ] 
]

{ #category : #'search and filtering' }
SGLTreeModel >> amountToFilterBy [
	^ amountToFilterBy ifNil: [ amountToFilterBy := self stepSize]
]

{ #category : #'search and filtering' }
SGLTreeModel >> amountToFilterBy: anInteger [
	amountToFilterBy := anInteger 
]

{ #category : #callbacks }
SGLTreeModel >> explicitSelection: anObject [ 
	"anObject is a domain object, not a Glamour related object"
	self glamourPresentation isMultiple 
		ifTrue: [ self explicitlySelectMultipleItems: anObject ]
		ifFalse: [ self explicitlySelectItem: anObject ]
]

{ #category : #selection }
SGLTreeModel >> explicitlySelectItem: anObject [ 
	(self selectedItem isNil and: [ anObject isNil ]) ifTrue: [ ^ self ].
	anObject isNil ifTrue: [self selection: nil].
	self roots do: [:eachRoot |
		eachRoot withContentsDo: [:each |
			each item = anObject ifTrue: [
				"each expandParentPath."
				self selectNodePath: each path.
				^ self]]]
]

{ #category : #selection }
SGLTreeModel >> explicitlySelectMultipleItems: aCollection [
	| newSelection collection|
	aCollection isNil ifTrue: [^ self].
	collection := aCollection isCollection ifTrue: [aCollection] ifFalse: [aCollection asOrderedCollection ].
	newSelection := OrderedCollection new.
	self roots do: [:eachRoot |
		eachRoot withContentsDo: [:each |
			(collection includes: each item) ifTrue: [
				newSelection add: each path ]]].
	(newSelection isEmpty) ifFalse: [
		self selectAllNodePaths: newSelection ]
]

{ #category : #initialization }
SGLTreeModel >> initialize [
	super initialize.
	renderedNodes := IdentityDictionary new
]

{ #category : #accessing }
SGLTreeModel >> isNodeRendered: aNode [
	^ renderedNodes at: aNode ifAbsentPut: [false]
]

{ #category : #accessing }
SGLTreeModel >> markAllNodesAsNotRenderer [
	renderedNodes := IdentityDictionary new
]

{ #category : #accessing }
SGLTreeModel >> markNodeAsRendered: aNode [
	renderedNodes at: aNode put: true
]

{ #category : #accessing }
SGLTreeModel >> nodeModelFor: anObject [
	^ (SGLTreeNodeModel with: anObject) containerTree: self; yourself
]

{ #category : #accessing }
SGLTreeModel >> roots [
	roots ifNil: [ self roots: self glamourPresentation displayValue ].
	filteredRoots ifNil: [filteredRoots := roots select: [ :each | each shouldBeDisplayed ] ].
	((self shouldFilterByAmount and: [
		self amountToFilterBy < filteredRoots size]) and: [
			filteredRoots notEmpty]) ifTrue: [
		^ filteredRoots first: self amountToFilterBy ].
	^ filteredRoots
]

{ #category : #accessing }
SGLTreeModel >> roots: anObjectOrCollection [
	anObjectOrCollection isCollection 
		ifTrue: [ |items|
			items := OrderedCollection new.
			anObjectOrCollection do: [:each | items add: (self nodeModelFor: each) ].
			roots := items ]
		ifFalse: [ roots := OrderedCollection with: (self nodeModelFor: anObjectOrCollection) ]
]

{ #category : #selection }
SGLTreeModel >> selectAllNodePaths: aCollectionOfNodePath [
	(self shouldDeselect: aCollectionOfNodePath) ifTrue: [
		 self glamourPresentation allowsDeselection 
			ifTrue: [ 
				self selection: (MorphTreeMorphMultipleSelection new selectedNodePathList: OrderedCollection new).
				^ self ]
			ifFalse: [
				^ self "If the selection is the same don't do anything"] ].
	self selection: (MorphTreeMorphMultipleSelection new selectedNodePathList: aCollectionOfNodePath)
]

{ #category : #selection }
SGLTreeModel >> selectNodePath: aNodePath [
	(self shouldDeselect: aNodePath last)  ifTrue: [
			self glamourPresentation allowsDeselection 
				ifTrue: [ 
					self selection: (MorphTreeMorphSingleSelection new selectedNodePath: nil).
					^ self ]
				ifFalse: [
					^ self "If the selection is the same don't do anything"] ].
	self selection: (MorphTreeMorphSingleSelection new selectedNodePath: aNodePath)
]

{ #category : #selection }
SGLTreeModel >> selectedItem [
	^ self selectedNode ifNotNil: [:node | node item]
]

{ #category : #selection }
SGLTreeModel >> selectedNode [
	^ self selectedNodePath ifNotNil: [:path | path ifEmpty: [nil] ifNotEmpty: [path last]]
]

{ #category : #selection }
SGLTreeModel >> selectedNodePath [
	^ selection ifNotNil: [selection lastSelectedNodePath]
]

{ #category : #accessing }
SGLTreeModel >> selection [ 
	^ selection
]

{ #category : #callbacks }
SGLTreeModel >> selection: aSelection [ 
	self selection = aSelection ifTrue: [ ^ self ].
	selection := aSelection.
	self announcer announce: (
			GLMTreeMorphSelectionChanged new 
				selectionValue: (aSelection ifNotNil: [aSelection selectedItemOrItemsOrNil]);
				selectionPathValue: self selectionPathItems;
				yourself)
]

{ #category : #selection }
SGLTreeModel >> selectionPathItems [
	^ self selectedNodePath isNil ifTrue: [nil] ifFalse: [self selectedNodePath collect: [:each | each item]]
]

{ #category : #accessing }
SGLTreeModel >> shouldAllExpand [
	^ shouldAllExpand ifNil: [shouldAllExpand := false]
]

{ #category : #accessing }
SGLTreeModel >> shouldAllExpand: anObject [
	shouldAllExpand := anObject
]

{ #category : #selection }
SGLTreeModel >> shouldDeselect: aNodeOrACollectionOfPaths [
	self selection ifNil: [^ false].
	self glamourPresentation isMultiple 
		ifTrue: [
			^ self selection selectedNodePathList = aNodeOrACollectionOfPaths ] 
		ifFalse: [
			^ self selection lastSelectedNode = aNodeOrACollectionOfPaths ]
]

{ #category : #'search and filtering' }
SGLTreeModel >> shouldFilterByAmount [
	^ self amountToFilterBy notNil and: [self amountToFilterBy isZero not]
]

{ #category : #'search and filtering' }
SGLTreeModel >> shouldFilterByTag: aTag [
	^ self tagsToFilterBy includes: aTag 
]

{ #category : #accessing }
SGLTreeModel >> shouldRootsExpand [
	^ shouldRootsExpand ifNil: [shouldRootsExpand := false]
]

{ #category : #accessing }
SGLTreeModel >> shouldRootsExpand: anObject [
	shouldRootsExpand := anObject
]

{ #category : #accessing }
SGLTreeModel >> stepSize [
	^ stepSize ifNil: [ stepSize := self glamourPresentation amountToShow ifNil: [0] ]
]

{ #category : #accessing }
SGLTreeModel >> stepSize: anObject [
	stepSize := anObject
]

{ #category : #'search and filtering' }
SGLTreeModel >> tagsToFilterBy [
	^ tagsToFilterBy ifNil: [ tagsToFilterBy := OrderedCollection new ]
]

{ #category : #'search and filtering' }
SGLTreeModel >> toggleFilteringByTag: aTag [ 
	(self shouldFilterByTag: aTag) 
		ifTrue: [self tagsToFilterBy remove: aTag ]
		ifFalse: [self tagsToFilterBy add: aTag].
	self updateRoots 
]

{ #category : #selection }
SGLTreeModel >> updateModelSelection [
	|aSelection|
	self announcer suspendAllWhile: [
		selection := nil.
		aSelection := self glamourPresentation selection.
		self explicitSelection: aSelection ]
]

{ #category : #accessing }
SGLTreeModel >> updateRoots [
	"amountToShow := nil."
	filteredRoots := nil.
	self roots
]
