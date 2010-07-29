Class {
	#name : #SGLTreeModel,
	#superclass : #Object,
	#instVars : [
		'roots',
		'filteredRoots',
		'glamourPresentation',
		'amountToShow',
		'amountShown',
		'tagsToFilterBy',
		'shouldRootsExpand',
		'shouldAllExpand',
		'announcer',
		'selection'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
SGLTreeModel >> amountShown [
	^ amountShown ifNil: [amountShown := 0]
]

{ #category : #accessing }
SGLTreeModel >> amountShown: anInteger [
	amountShown := anInteger 
]

{ #category : #accessing }
SGLTreeModel >> amountToShow [ 
	amountToShow ifNil: [
		amountToShow := self glamourPresentation  amountToShow ifNil: [self roots size] ].
	(amountToShow + self amountShown ) > self roots size
		ifTrue: [amountToShow := self roots size - self amountShown ].
	^ amountToShow 
	
]

{ #category : #announcements }
SGLTreeModel >> announce: anAnnouncement [
	self announcer announce: anAnnouncement 
]

{ #category : #accessing }
SGLTreeModel >> announcer [
	^ announcer ifNil: [announcer := GLMAnnouncer new]
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
	self selectAllNodePaths: newSelection
]

{ #category : #accessing }
SGLTreeModel >> glamourPresentation [
	^ glamourPresentation 
]

{ #category : #accessing }
SGLTreeModel >> glamourPresentation: anObject [
	glamourPresentation := anObject 
]

{ #category : #accessing }
SGLTreeModel >> nodeModelFor: anObject [
	^ (SGLTreeNodeModel with: anObject) containerTree: self; yourself
]

{ #category : #accessing }
SGLTreeModel >> roots [
	roots ifNil: [ self roots: self glamourPresentation displayValue ].
	filteredRoots ifNil: [filteredRoots := roots select: [ :each | each shouldBeDisplayed ] ].
	^ filteredRoots.
]

{ #category : #accessing }
SGLTreeModel >> roots: anObjectOrCollection [
	roots := anObjectOrCollection isCollection 
		ifTrue: [ anObjectOrCollection collect: [:each | self nodeModelFor: each ] ]
		ifFalse: [ OrderedCollection with: (self nodeModelFor: anObjectOrCollection) ]
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

{ #category : #callbacks }
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
SGLTreeModel >> tagsToFilterBy [
	^ tagsToFilterBy ifNil: [ tagsToFilterBy := OrderedCollection new ]
]

{ #category : #callbacks }
SGLTreeModel >> toggleFilteringByTag: aTag [ 
	(self shouldFilterByTag: aTag) 
		ifTrue: [self tagsToFilterBy remove: aTag ]
		ifFalse: [self tagsToFilterBy add: aTag].
	self updateRoots 
]

{ #category : #accessing }
SGLTreeModel >> updateRoots [
	amountToShow := nil.
	filteredRoots := nil.
	self roots
]
