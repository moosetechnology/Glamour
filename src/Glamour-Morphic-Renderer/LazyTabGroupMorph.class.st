Class {
	#name : #LazyTabGroupMorph,
	#superclass : #TabGroupMorph,
	#instVars : [
		'lazyPages',
		'onPageIndexChange',
		'toolbars'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> addLazyPage: aBlock label: aStringOrMorph [
	self addLazyPage: aBlock label: aStringOrMorph toolbar: nil
]

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> addLazyPage: aBlock label: aStringOrMorph toolbar: aToolbar [
	self lazyPages add: aBlock.
	self tabSelectorMorph addTab: aStringOrMorph.
	self toolbars add: aToolbar
]

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> addPage: aMorph [ 
	aMorph
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	^self pages add: aMorph.
]

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> addPage: aMorph at: anIndex [
	aMorph
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	^self pages at: anIndex put: aMorph
]

{ #category : #accessing }
LazyTabGroupMorph >> clear [
	self flag: 'todo'.
"	tabSelectorMorph submorphs do: [:each |
		tabSelectorMorph removeMorph: each ].
	lazyPages := OrderedCollection new.
	pageMorphs := Dictionary new."
]

{ #category : #accessing }
LazyTabGroupMorph >> hasToolbarAt: aNumber [
	^ (self toolbarAt: aNumber) notNil
]

{ #category : #initialization }
LazyTabGroupMorph >> initialize [
	super initialize.
	lazyPages := OrderedCollection new.
	pageMorphs := Dictionary new.
	toolbars := OrderedCollection new. "a collection with a toolbar for each page"
]

{ #category : #accessing }
LazyTabGroupMorph >> lazyPages [

	^lazyPages
]

{ #category : #accessing }
LazyTabGroupMorph >> onPageIndexChange [
	^ onPageIndexChange ifNil: [[:x | ]]
]

{ #category : #accessing }
LazyTabGroupMorph >> onPageIndexChange: anObject [
	onPageIndexChange := anObject
]

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> pageAt: index [
	^self pages at: index ifAbsent: [ self addPage: (self lazyPages at: index) value at: index]
]

{ #category : #accessing }
LazyTabGroupMorph >> toolbarAt: aNumber [
	^ self toolbars at: aNumber ifAbsent: [nil]
]

{ #category : #accessing }
LazyTabGroupMorph >> toolbars [
	^ toolbars
]

{ #category : #accessing }
LazyTabGroupMorph >> toolbars: anObject [
	toolbars := anObject
]

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> updatePageIndex: index [
	"Change to the given page index."

	|p|
	p := self pageMorph.
	p isNil
		ifTrue: [self contentMorph addMorph: (self pageAt: index)]
		ifFalse: [self contentMorph
				replaceSubmorph: p
				by: (self pageAt: index)].
	self pageMorph layoutChanged.
	self adoptPaneColor: (self owner ifNil: [self]) paneColor.
	self onPageIndexChange value: index
]
