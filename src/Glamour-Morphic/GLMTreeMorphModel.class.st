"
ClassTree new openOn: Collection

"
Class {
	#name : #GLMTreeMorphModel,
	#superclass : #MorphTreeModel,
	#instVars : [
		'roots',
		'glamourPresentation',
		'childrenBlock',
		'onSelection',
		'displayFormat',
		'tagsToFilterBy',
		'announcer',
		'inputText',
		'amountToFilterBy',
		'defaultPageSize'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMTreeMorphModel >> allKeystrokeActions [
	^ self glamourPresentation allActions select: [:action | action hasShortcut ]
]

{ #category : #accessing }
GLMTreeMorphModel >> allMenuActions [
	^ self glamourPresentation allActions select: [:action | action hasTitle ]
]

{ #category : #accessing }
GLMTreeMorphModel >> amountToFilterBy [
	^ nil "amountToFilterBy ifNil: [self glamourPresentation amountToShow]"
]

{ #category : #accessing }
GLMTreeMorphModel >> amountToFilterBy: aNumber [ 
	amountToFilterBy := aNumber
]

{ #category : #announcements }
GLMTreeMorphModel >> announce: anAnnouncement [
	self announcer announce: anAnnouncement 
]

{ #category : #accessing }
GLMTreeMorphModel >> announcer [
	^ announcer ifNil: [announcer := GLMAnnouncer new]
]

{ #category : #accessing }
GLMTreeMorphModel >> childrenBlock [
	^ childrenBlock ifNil: [ childrenBlock := self glamourPresentation children isNil 
		ifFalse: [self glamourPresentation children] ifTrue: [OrderedCollection new] ]
]

{ #category : #accessing }
GLMTreeMorphModel >> childrenBlock: aBlock [
	childrenBlock := aBlock 
]

{ #category : #accessing }
GLMTreeMorphModel >> defaultPageSize [
	^ defaultPageSize
]

{ #category : #accessing }
GLMTreeMorphModel >> defaultPageSize: anInteger [
	defaultPageSize := anInteger
]

{ #category : #accessing }
GLMTreeMorphModel >> displayFormat [
	^ displayFormat ifNil: [displayFormat := self glamourPresentation format]
]

{ #category : #accessing }
GLMTreeMorphModel >> displayFormat: aBlock [ 
	displayFormat := aBlock 
]

{ #category : #'search and filtering' }
GLMTreeMorphModel >> doSearchOrFilter [
	inputText isEmptyOrNil
		ifTrue: [ self resetInput ]
		ifFalse:[ 
			self glamourPresentation allowsFilter 
				ifTrue: [ self executeFilter ]
				ifFalse: [ self executeSearch ] ].

]

{ #category : #'search and filtering' }
GLMTreeMorphModel >> executeFilter [
	self changed: #roots
]

{ #category : #'search and filtering' }
GLMTreeMorphModel >> executeSearch [
	| newSelection check |
	newSelection := OrderedCollection new.
	roots do: [ :each | 
		check := self glamourPresentation searchStrategy value: self inputText value: each item.
		check ifTrue: [newSelection add: each path]].
	newSelection isEmpty ifFalse: [
		self selection: (MorphTreeMorphMultipleSelection new selectedNodePathList: newSelection) ]
]

{ #category : #callbacks }
GLMTreeMorphModel >> explicitSelection: anObject [ 
	"anObject is a domain object, not a Glamour related object"
	self glamourPresentation isMultiple 
		ifTrue: [ self explicitlySelectMultipleItems: anObject ]
		ifFalse: [ self explicitlySelectItem: anObject ]
]

{ #category : #'private selecting' }
GLMTreeMorphModel >> explicitlySelectItem: anObject [ 
	(self selectedItem notNil and: [self selectedItem = anObject]) ifTrue: [ ^ self ].
	(self selectedItem isNil and: [ anObject isNil ]) ifTrue: [ ^ self ].
	anObject isNil ifTrue: [self selection: nil].
	self roots do: [:eachRoot |
		eachRoot withContentsDo: [:each |
			each item = anObject ifTrue: [
				each expandParentPath.
				self selectNodePath: each path.
				^ self]]]
]

{ #category : #'private selecting' }
GLMTreeMorphModel >> explicitlySelectMultipleItems: aCollection [ 
	| newSelection collection|
	aCollection isNil ifTrue: [^ self].
	collection := aCollection isCollection ifTrue: [aCollection] ifFalse: [aCollection asOrderedCollection ].
	(self selection notNil and: [
		self selection selectedItemOrItemsOrNil = collection asOrderedCollection ]) ifTrue: [ ^ self ].
	newSelection := OrderedCollection new.
	self roots do: [:eachRoot |
		eachRoot withContentsDo: [:each |
			(collection includes: each item) ifTrue: [
				newSelection add: each path ]]].
	self selectAllNodePaths: newSelection
]

{ #category : #accessing }
GLMTreeMorphModel >> filteredRoots [
	| filtered |
	roots ifNil: [ self roots: self glamourPresentation displayValue ].
	filtered := roots select: [ :each | each shouldBeDisplayed ].
	^ filtered
]

{ #category : #accessing }
GLMTreeMorphModel >> glamourPresentation [
	^ glamourPresentation
]

{ #category : #accessing }
GLMTreeMorphModel >> glamourPresentation: anObject [
	glamourPresentation := anObject
]

{ #category : #accessing }
GLMTreeMorphModel >> inputText [
	^ inputText ifNil: [inputText := '']
]

{ #category : #accessing }
GLMTreeMorphModel >> inputText: anObject [
	inputText := anObject.
	self doSearchOrFilter
]

{ #category : #accessing }
GLMTreeMorphModel >> inputTextEnabled [
	^ true
]

{ #category : #callbacks }
GLMTreeMorphModel >> keyStroke: aCharacter from: aTreeMorph [ 
	| action |
	action := self allKeystrokeActions detect: [:a | a shortcut = aCharacter] ifNone: [nil].
	action ifNotNil: [ self announce: (GLMKeyStroke action: action) ]
]

{ #category : #callbacks }
GLMTreeMorphModel >> menu: menu shifted: b [ 
	"Set up the menu to apply to the receiver's, honoring the #shifted boolean"
	self selectedNode ifNotNil: [:current | current menu: menu shifted: b].
	^ menu
]

{ #category : #accessing }
GLMTreeMorphModel >> nodeModelFor: anObject [
	^ (GLMTreeMorphNodeModel with: anObject) containerTree: self; yourself
]

{ #category : #callbacks }
GLMTreeMorphModel >> onDoubleClick [
	self announcer announce: (GLMTreeMorphStrongSelectionChanged new strongSelectionValue: 
		(self selection ifNotNil: [self selection selectedItemOrItemsOrNil]))
]

{ #category : #'search and filtering' }
GLMTreeMorphModel >> resetInput [

]

{ #category : #callbacks }
GLMTreeMorphModel >> resetTagsToFilterBy [
	tagsToFilterBy := OrderedCollection new.
	self changed: #roots.
]

{ #category : #accessing }
GLMTreeMorphModel >> roots [
	| filtered |
	roots ifNil: [ self roots: self glamourPresentation displayValue ].
	filtered := roots select: [ :each | each shouldBeDisplayed ].
	((self shouldFilterByAmount and: [
		self amountToFilterBy < filtered size]) and: [
			filtered notEmpty]) ifTrue: [
		filtered := filtered first: self amountToFilterBy ].
	^ filtered
]

{ #category : #accessing }
GLMTreeMorphModel >> roots: anObjectOrCollection [
	roots := anObjectOrCollection isCollection 
		ifTrue: [ anObjectOrCollection collect: [:each | self nodeModelFor: each ] ]
		ifFalse: [ OrderedCollection with: (self nodeModelFor: anObjectOrCollection) ]
]

{ #category : #callbacks }
GLMTreeMorphModel >> selection: aSelection [ 
	self selection = aSelection ifTrue: [ ^ self ].
	super selection: aSelection.
	self announcer announce: (
			GLMTreeMorphSelectionChanged new 
				selectionValue: (aSelection ifNotNil: [aSelection selectedItemOrItemsOrNil]);
				selectionPathValue: self selectionPathItems;
				yourself)
]

{ #category : #accessing }
GLMTreeMorphModel >> selectionPathItems [
	^ self selectedNodePath isNil ifTrue: [nil] ifFalse: [self selectedNodePath collect: [:each | each item]]
]

{ #category : #'search and filtering' }
GLMTreeMorphModel >> shouldFilterByAmount [
	^ self amountToFilterBy notNil and: [self amountToFilterBy isZero not]
]

{ #category : #callbacks }
GLMTreeMorphModel >> shouldFilterByTag: aTag [
	^ self tagsToFilterBy includes: aTag 
]

{ #category : #'search and filtering' }
GLMTreeMorphModel >> shouldFilterByTextInput [
	^ self glamourPresentation allowsFilter and: [ self inputText notEmpty ]
]

{ #category : #callbacks }
GLMTreeMorphModel >> tagsToFilterBy [
	^ tagsToFilterBy ifNil: [ tagsToFilterBy := OrderedCollection new ]
]

{ #category : #accessing }
GLMTreeMorphModel >> toggleAmountToFilterBy [
	self amountToFilterBy notNil ifTrue: 
		[ self amountToFilterBy isZero 
			ifTrue: [ amountToFilterBy := self glamourPresentation amountToShow ]
			ifFalse: [ amountToFilterBy := 0 ].
		self changed: #roots ]
]

{ #category : #callbacks }
GLMTreeMorphModel >> toggleFilteringByTag: aTag [ 
	(self shouldFilterByTag: aTag) 
		ifTrue: [self tagsToFilterBy remove: aTag ]
		ifFalse: [self tagsToFilterBy add: aTag].
	self changed: #roots
]

{ #category : #accessing }
GLMTreeMorphModel >> updateRoots [
	roots := nil.
	self changed: #roots
]

{ #category : #announcements }
GLMTreeMorphModel >> when: anAnnouncement do: aBlock [
	self announcer when: anAnnouncement do: aBlock 
]
