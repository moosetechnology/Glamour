"
ClassTree new openOn: Collection

"
Class {
	#name : #GLMTreeMorphModel,
	#superclass : #TreeModel,
	#instVars : [
		'roots',
		'glamourPresentation',
		'childrenBlock',
		'onSelection',
		'displayFormat',
		'tagsToFilterBy',
		'announcer',
		'inputText',
		'amountToFilterBy'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMTreeMorphModel >> allKeystrokeActions [
	^ self glamourPresentation allActions select: [:action | action hasShortcut ]
]

{ #category : #callbacks }
GLMTreeMorphModel >> allMenuActions [
	^ self glamourPresentation allActions select: [:action | action hasTitle ]
]

{ #category : #accessing }
GLMTreeMorphModel >> amountToFilterBy [
	^ amountToFilterBy ifNil: [self glamourPresentation amountToShow]
]

{ #category : #accessing }
GLMTreeMorphModel >> amountToFilterBy: aNumber [ 
	amountToFilterBy := aNumber
]

{ #category : #announcements }
GLMTreeMorphModel >> announce: anAnnouncement [
	self announcer announce: anAnnouncement 
]

{ #category : #announcements }
GLMTreeMorphModel >> announcer [
	^ announcer ifNil: [announcer := Announcer new].
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
	self changed: #roots
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
	self selectedItem ifNotNil: [:current | current menu: menu shifted: b].
	^ menu
]

{ #category : #accessing }
GLMTreeMorphModel >> nodeModelFor: anObject [
	^ (GLMTreeMorphNodeModel with: anObject) containerTree: self; yourself
]

{ #category : #callbacks }
GLMTreeMorphModel >> onSelection: aBlock [
	onSelection := aBlock
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
GLMTreeMorphModel >> selectItem: anObject [
	(self selectedItem notNil and: [ self selectedItem item == anObject ]) ifTrue: [ ^ self ].
	self roots do: [:eachRoot |
		eachRoot withContentsDo: [:each |
			each item = anObject ifTrue: [
				self silentNoteNewSelection: each.
				^ self]]]
]

{ #category : #callbacks }
GLMTreeMorphModel >> selectionPath: path [
	super selectionPath: path.
"	x = self  ifTrue: [^ self]."
	path isNil ifFalse: [
		onSelection ifNotNil: [onSelection value: (path last isNil ifTrue: [nil] ifFalse: [path last item])].
	].
]

{ #category : #callbacks }
GLMTreeMorphModel >> selectionPath: path selectionSet: set [
	super selectionPath: path selectionSet: set.
	path isNil ifFalse: [
		onSelection ifNotNil: [onSelection value: (set flatCollect: #yourself)].
	].
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
GLMTreeMorphModel >> shouldFilterByText [
	^ self glamourPresentation allowsFilter and: [ self inputText notEmpty ]
]

{ #category : #callbacks }
GLMTreeMorphModel >> silentNoteNewSelection: x [
	self flag: 'check this out'.
	x expandParentPath.
"	self selectionPath: x path."
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
	self haltOnce.
	(self shouldFilterByTag: aTag) 
		ifTrue: [self tagsToFilterBy remove: aTag ]
		ifFalse: [self tagsToFilterBy add: aTag].
	self changed: #roots
]

{ #category : #announcements }
GLMTreeMorphModel >> when: anAnnouncement do: aBlock [
	self announcer when: anAnnouncement do: aBlock 
]
