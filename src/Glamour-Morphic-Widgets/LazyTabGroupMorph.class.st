Class {
	#name : #LazyTabGroupMorph,
	#superclass : #TabGroupMorph,
	#instVars : [
		'announcer',
		'toolbarMorph',
		'headerMorph',
		'tabSelectorWidth'
	],
	#category : #'Glamour-Morphic-Widgets'
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
LazyTabGroupMorph >> addLazyPage: aBlock label: aStringOrMorph toolbar: aToolbar action: anActionMorphOrNil [
	| newPage label |
	newPage := LazyTabPage new.
	newPage
		lazyPageMorphCreation: aBlock; 
		labelMorph: aStringOrMorph; 
		toolbar: aToolbar.
	label := self 
			buildLabelFrom: aStringOrMorph 
			withAction: anActionMorphOrNil.
	self 
		addPage: newPage
		label: label
]

{ #category : #adding }
LazyTabGroupMorph >> addLazyPage: aBlock label: aStringOrMorph toolbar: aToolbar collapsable: aBoolean [
	| newPage label |
	newPage := LazyTabPage new.
	newPage
		lazyPageMorphCreation: aBlock; 
		labelMorph: aStringOrMorph; 
		toolbar: aToolbar.
	label := self 
			buildLabelFrom: aStringOrMorph 
			withAction: (aBoolean 
				ifTrue: [UITheme builder
					newCloseControlFor: nil
					action: [self removePage: newPage]
					help: nil]
				ifFalse: [nil]).
	self 
		addPage: newPage
		label: label.
	
]

{ #category : #accessing }
LazyTabGroupMorph >> announcer [
	^ announcer ifNil: [announcer := GLMAnnouncer new]
]

{ #category : #private }
LazyTabGroupMorph >> buildLabelFrom: aStringOrMorph withAction: anActionMorphOrNil [
	| label innerLabel |

	innerLabel := aStringOrMorph isMorph
		ifTrue: [aStringOrMorph]
		ifFalse: [
			|labelMorph|
			labelMorph := GLMButton new disable.
			labelMorph label text: aStringOrMorph.
			labelMorph ].
	label := anActionMorphOrNil
			ifNil: [innerLabel]
			ifNotNil: [  UITheme builder newRow: { 
				innerLabel. anActionMorphOrNil }].
	^ label

]

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> fitLabelsIn: width [
	|delta morphs |
	
	delta := (self measureWidth - width).
	delta < 0 ifTrue: [
		self tabSelectorMorph tabs do: [ :aTabMorph |
			(aTabMorph label isKindOf: GLMButton) ifTrue:[
				aTabMorph label updateLabelTextToFit: aTabMorph label measureWidth ] ].
		^ self ].

	morphs := OrderedCollection new.
	self tabSelectorMorph tabs size > 0 ifTrue: [
		self tabSelectorMorph tabs do: [ :aTabMorph |
			(aTabMorph label isKindOf: GLMButton) ifTrue: [
				morphs add: aTabMorph label ] ] ].

	GLMButton shrinkButtons: morphs by: delta.
]

{ #category : #accessing }
LazyTabGroupMorph >> headerMorph [
	^ headerMorph
]

{ #category : #accessing }
LazyTabGroupMorph >> headerMorph: anObject [
	headerMorph := anObject.
	
	headerMorph clipSubmorphs: true.
]

{ #category : #initialization }
LazyTabGroupMorph >> initialize [
	"Initialize the receiver."

	super initialize.
	self removeMorph: self contentMorph;
		removeMorph: self tabSelectorMorph;  
		toolbarMorph: self newToolbarMorph;
		headerMorph: self newHeaderMorph;
		addMorph: self headerMorph;
		addMorph: self contentMorph.
	
"	self
		borderWidth: 0;
		changeTableLayout;
		cellPositioning: #topLeft;
		cellInset: 0 @ -1;
		reverseTableCells: true;
		pageMorphs: OrderedCollection new;
		tabSelectorMorph: self newTabSelectorMorph;
		contentMorph: self newContentMorph;
		addMorph: self tabSelectorMorph;
		addMorph: self contentMorph.
	self tabSelectorMorph addDependent: self"
]

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> layoutChanged [
	super layoutChanged.
	
	self headerMorph ifNotNil: [
		|newWidth|
		newWidth := self width.
		tabSelectorWidth = newWidth ifFalse: [
			tabSelectorWidth := newWidth.
			"the difference between TabSelectorMorph and the summ of widths of all tabs is 40. I don't know why"
			self fitLabelsIn: tabSelectorWidth - self toolbarMorph width - 40.
		].
	].
]

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> measureWidth [
	|width|
	
	width := 0.
	self tabSelectorMorph tabs do: [ :each |
		(each label isKindOf: GLMButton) 
			ifTrue:[
	 			width := width + each label measureWidth + each layoutInset left + each layoutInset right ]
			ifFalse: [ 
				width := width + each width ] ].

	self headerMorph ifNotNil: [
		self headerMorph submorphs do: [ :each |
			(each = self tabSelectorMorph) not ifTrue: [ 
				width := width + each width.
			] ] ].

	^ width.
]

{ #category : #private }
LazyTabGroupMorph >> newHeaderMorph [
	^ (self theme 
			newRowIn: self theme
			for: {self tabSelectorMorph . self toolbarMorph}) cellInset: 0; cellPositioning: #bottomCenter; borderWidth: 0
]

{ #category : #private }
LazyTabGroupMorph >> newToolbarMorph [
	^ PanelMorph new
		fillStyle: (SolidFillStyle color: Color transparent);
		borderStyle: (BorderStyle width: 0);
		vResizing: #spaceFill;
		hResizing: #shrinkWrap;
		cellPositioning: #center;
		changeTableLayout;
		cellInset: 0;
		yourself 
]

{ #category : #private }
LazyTabGroupMorph >> pageAt: index [
	^ (self pages at: index ) actualPageMorph
]

{ #category : #private }
LazyTabGroupMorph >> removePage: aPage [
	| removedPageIndex |
	removedPageIndex := self pages indexOf: aPage.
	self announcer suspendAllWhile: [ super removePage: aPage ].
	self announcer announce: 
		(LazyTabPageRemoved new 
			tabs: self; 
			page: aPage; 
			pageIndex: removedPageIndex;
			newIndex: self tabSelectorMorph selectedIndex).
	self pages isEmpty 
		ifTrue: [ self contentMorph removeAllMorphs ]
]

{ #category : #private }
LazyTabGroupMorph >> removePageIndex: anInteger [
	self removePage: (self pages at: anInteger)
]

{ #category : #accessing }
LazyTabGroupMorph >> toolbarMorph [
	^ toolbarMorph
]

{ #category : #accessing }
LazyTabGroupMorph >> toolbarMorph: anObject [
	toolbarMorph := anObject.
]

{ #category : #'as yet unclassified' }
LazyTabGroupMorph >> updatePageAtIndex: anInteger withLabel: aStringOrMorph toolbar: aToolbar action: anActionMorph [
	
	(self pages at: anInteger)
			toolbar: aToolbar.
	self 
		relabelPage: (self pages at: anInteger)
		with: (self 
			buildLabelFrom: aStringOrMorph 
			withAction: anActionMorph).
	self updatePageIndex: anInteger.

]

{ #category : #private }
LazyTabGroupMorph >> updatePageIndex: index [
	"Change to the given page index, update the toolbar and send the announcement"

	| p oldPage |
	
	index = 0 ifTrue: [^ self].
	oldPage := self tabSelectorMorph selectedTab.
	p := self pageMorph.
	p isNil
		ifTrue: [self contentMorph addMorph: (self pageAt: index)]
		ifFalse: [self contentMorph replaceSubmorph: p by: (self pageAt: index)].
		
	((self pages at: index) toolbar notNil and: [(self pages at: index) toolbar hasSubmorphs])
		ifTrue: [
			self toolbarMorph hasSubmorphs
				ifFalse: [self toolbarMorph addMorph: (self pages at: index) toolbar ]
				ifTrue: [self toolbarMorph 
								replaceSubmorph: self toolbarMorph submorphs first 
								by: (self pages at: index) toolbar ]]
		ifFalse: [self toolbarMorph removeAllMorphs ].
		
	self headerMorph layoutChanged.
	self pageMorph layoutChanged.
	self adoptPaneColor: (self owner ifNil: [self]) paneColor.
	self announcer announce: (LazyTabPageChanged new tabs: self; page: (self pages at: index); oldPage: oldPage; pageIndex: index)
]
