"
ClassTree new openOn: Collection

"
Class {
	#name : #GLMTreeMorphModel,
	#superclass : #AbstractHierarchicalList,
	#instVars : [
		'roots',
		'rootClass',
		'glamourPresentation',
		'childrenBlock',
		'onSelection',
		'displayFormat',
		'tagsToFilterBy',
		'announcer'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #callbacks }
GLMTreeMorphModel >> allMenuActions [
	^ self glamourPresentation allActions select: [:action | action hasTitle ]
]

{ #category : #accessing }
GLMTreeMorphModel >> announce: anAnnouncement [
	self announcer announce: anAnnouncement 
]

{ #category : #accessing }
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

{ #category : #accessing }
GLMTreeMorphModel >> glamourPresentation [
	^ glamourPresentation
]

{ #category : #accessing }
GLMTreeMorphModel >> glamourPresentation: anObject [
	glamourPresentation := anObject
]

{ #category : #'as yet unclassified' }
GLMTreeMorphModel >> keyStroke: aCharacter from: aTreeMorph [ 
	self getCurrentSelection
		ifNotNil: [:current | current keyStroke: aCharacter from: aTreeMorph]
]

{ #category : #'as yet unclassified' }
GLMTreeMorphModel >> menu: menu shifted: b [ 
	"Set up the menu to apply to the receiver's, 
	honoring the #shifted boolean"
	self getCurrentSelection ifNotNil: [:current | current menu: menu shifted: b].
	^ menu
]

{ #category : #'as yet unclassified' }
GLMTreeMorphModel >> nodeModelFor: anObject [
	^ (GLMTreeMorphNodeModel with: anObject) containerTree: self; yourself
]

{ #category : #'as yet unclassified' }
GLMTreeMorphModel >> noteNewSelection: x [
	x = currentSelection ifTrue: [^ self].
	super noteNewSelection: x.
	onSelection ifNotNil: [onSelection value: (x isNil ifTrue: [nil] ifFalse: [x item])].
	self changed: #selection.
]

{ #category : #'as yet unclassified' }
GLMTreeMorphModel >> onSelection: aBlock [
	onSelection := aBlock
]

{ #category : #callbacks }
GLMTreeMorphModel >> resetTagsToFilterBy [
	tagsToFilterBy := OrderedCollection new.
	self changed: #roots.
]

{ #category : #accessing }
GLMTreeMorphModel >> roots [
	roots ifNil: [ self roots: self glamourPresentation displayValue ].
	^ roots select: [ :each | each itemHasTags: self tagsToFilterBy ]
]

{ #category : #'as yet unclassified' }
GLMTreeMorphModel >> roots: anObjectOrCollection [
	roots := anObjectOrCollection isCollection 
		ifTrue: [ anObjectOrCollection collect: [:each | self nodeModelFor: each ] ]
		ifFalse: [ OrderedCollection with: (self nodeModelFor: anObjectOrCollection) ]
]

{ #category : #accessing }
GLMTreeMorphModel >> selectItem: anObject [
	self roots do: [:eachRoot |
		eachRoot withContentsDo: [:each |
			each item = anObject ifTrue: [
				self silentNoteNewSelection: each.
				^ self]]]
]

{ #category : #callbacks }
GLMTreeMorphModel >> shouldFilterByTag: aTag [
	^ self tagsToFilterBy includes: aTag 
]

{ #category : #'as yet unclassified' }
GLMTreeMorphModel >> silentNoteNewSelection: x [
	x expandParentPath.
	currentSelection := x.
"	self changed: #getCurrentSelection.
	currentSelection ifNil: [^self].
	currentSelection sendSettingMessageTo: self.
	self changed: #selection."
]

{ #category : #callbacks }
GLMTreeMorphModel >> tagsToFilterBy [
	^ tagsToFilterBy ifNil: [ tagsToFilterBy := OrderedCollection new ]
]

{ #category : #callbacks }
GLMTreeMorphModel >> toggleFilteringByTag: aTag [ 
	(self shouldFilterByTag: aTag) 
		ifTrue: [self tagsToFilterBy remove: aTag ]
		ifFalse: [self tagsToFilterBy add: aTag].
	self changed: #roots
]

{ #category : #announcements }
GLMTreeMorphModel >> when: anAnnouncement do: aBlock [
	self announcer when: anAnnouncement do: aBlock 
]
