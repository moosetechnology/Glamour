Class {
	#name : #LazyTabGroupMorph,
	#superclass : #TabGroupMorph,
	#instVars : [
		'onPageIndexChange'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #adding }
LazyTabGroupMorph >> addLazyPage: aBlock label: aStringOrMorph [
	self addLazyPage: aBlock label: aStringOrMorph toolbar: nil
]

{ #category : #adding }
LazyTabGroupMorph >> addLazyPage: aBlock label: aStringOrMorph toolbar: aToolbar [
	self addLazyPage: aBlock label: aStringOrMorph toolbar: aToolbar collapsable: false
]

{ #category : #adding }
LazyTabGroupMorph >> addLazyPage: aBlock label: aStringOrMorph toolbar: aToolbar collapsable: aBoolean [
	| newPage label innerLabel |
	newPage := LazyTabPage new.
	newPage
		lazyPageMorphCreation: aBlock; 
		labelMorph: aStringOrMorph; 
		toolbar: aToolbar.
	innerLabel := aStringOrMorph isMorph
		ifTrue: [aStringOrMorph]
		ifFalse: [(self theme buttonLabelForText: aStringOrMorph)
					font: self font;
					vResizing: #shrinkWrap;
					hResizing: #shrinkWrap].
	label := aBoolean 
			ifTrue: [UITheme builder newRow: { 
				innerLabel .
				UITheme builder
					newCloseControlFor: nil
					action: [self removePage: newPage]
					help: nil}]
			ifFalse: [innerLabel].
	self 
		addPage: newPage
		label: label
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
	^ (self pages at: index ) actualPageMorph
]

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> updatePageIndex: index [
	"Change to the given page index."

	|p|
	index = 0 ifTrue: [^ self].
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
