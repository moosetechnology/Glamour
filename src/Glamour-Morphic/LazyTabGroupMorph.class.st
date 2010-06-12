Class {
	#name : #LazyTabGroupMorph,
	#superclass : #TabGroupMorph,
	#instVars : [
		'lazyPages',
		'onPageIndexChange'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> addLazyPage: aBlock label: aStringOrMorph [
	self lazyPages add: aBlock.
	self tabSelectorMorph addTab: aStringOrMorph
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

{ #category : #initialization }
LazyTabGroupMorph >> initialize [
	super initialize.
	lazyPages := OrderedCollection new.
	pageMorphs := Dictionary new.

]

{ #category : #'as yet unclassified' }
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
