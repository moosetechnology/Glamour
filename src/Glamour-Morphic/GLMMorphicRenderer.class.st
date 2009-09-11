"
This is the class responsible for the binding to Morphic.

| browser |
browser := GLMTableLayoutBrowser new.
browser column: #one; column: #two.

browser showOn: #one; using: [browser list.].
browser showOn: #two; from: #one; using: [
	browser text.].
browser openOn: #(a b c d)
"
Class {
	#name : #GLMMorphicRenderer,
	#superclass : #GLMRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #factory }
GLMMorphicRenderer >> emptyMorph [
	^ RectangleMorph new
		layoutPolicy: ProportionalLayout new;
		color: Color transparent;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		borderWidth: 0;
		yourself
]

{ #category : #private }
GLMMorphicRenderer >> installActionsOnUI: aMorphicModel fromPresentation: aPresentation [	 
	aMorphicModel when: GLMMenuItemSelected do: [ :ann | ann action actOn: aPresentation ].
	aMorphicModel when: GLMKeyStroke do: [ :ann | ann action actOn: aPresentation ].
]

{ #category : #opening }
GLMMorphicRenderer >> open: aRenderable [
	| window |
	window := GlamorousSystemWindow new.
	window model: aRenderable; setLabel: aRenderable titleValue.
	window 
		addMorph: (self render: aRenderable)
		fullFrame: (LayoutFrame new
				leftFraction: 0;
				rightFraction: 1;
				topFraction: 0;
				bottomFraction: 1).
	^ window openInWorld
]

{ #category : #private }
GLMMorphicRenderer >> renderCustomColumn: aCell ofPane: aPane inUI: aMorph inBrowser: aBrowser [ 
	| pane totalSpans currentSpanPosition |
	totalSpans := aCell children
		inject: 0
		into: [ :sum :each | sum + each span ].
	currentSpanPosition := 0.
	aCell children keysAndValuesDo: [ :index :each | 
		each hasId
			ifTrue: [ pane := self render: (aBrowser paneNamed: each id) ]
			ifFalse: [
				self
					renderCustomRow: each
					ofPane: aPane
					inUI: (pane := self emptyMorph)
					inBrowser: aBrowser.
				pane addPaneSplitters ].
		pane 
			layoutFrame: (LayoutFrame new
				topFraction: currentSpanPosition / totalSpans offset: 0;
				leftFraction: 0 offset: 0;
				bottomFraction: currentSpanPosition + each span / totalSpans offset: 0;
				rightFraction: 1 offset: 0;
				yourself).
		aMorph addMorphBack: pane.
		currentSpanPosition := currentSpanPosition + each span ].
	aMorph addPaneSplitters
]

{ #category : #private }
GLMMorphicRenderer >> renderCustomRow: aCell ofPane: aPane inUI: aMorph inBrowser: aBrowser [ 
	| pane totalSpans currentSpanPosition |
	totalSpans := aCell children
		inject: 0
		into: [ :sum :each | sum + each span ].
	currentSpanPosition := 0.
	aCell children keysAndValuesDo: [ :index :each | 
		each hasId
			ifTrue: [ pane := self render: (aBrowser paneNamed: each id) ]
			ifFalse: [
				self
					renderCustomColumn: each
					ofPane: aPane
					inUI: (pane := self emptyMorph)
					inBrowser: aBrowser.
				pane addPaneSplitters ].
		pane
			layoutFrame: (LayoutFrame new 
				topFraction: 0 offset: 0;
				leftFraction: currentSpanPosition / totalSpans offset: 0;
				bottomFraction: 1 offset: 0;
				rightFraction: currentSpanPosition + each span / totalSpans offset: 0;
				yourself).
		aMorph addMorphBack: pane.
		currentSpanPosition := currentSpanPosition + each span ].
	aMorph addPaneSplitters
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderFinder: aBrowser [ 
	| container |
	container := GLMPaneScroller new
		name: 'scroller';
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		yourself.
	aBrowser 
		when: GLMPaneRemoved
		do: [ :ann | container popPane.].
	aBrowser 
		when: GLMPaneAdded
		do: [ :ann | container pushPane: (self render: ann pane) ].
	aBrowser panes
		do: [ :each | container pushPane: (self render: each) ].
	^ container
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderListPresentation: aListPresentation [ 
	| items list toShow listModel container search |
	toShow := aListPresentation displayValue.
	items := toShow isCollection
				ifTrue: [toShow]
				ifFalse: [OrderedCollection with: toShow].
	listModel := (aListPresentation isMultiple ifTrue: [GLMMultiListModel new] ifFalse: [GLMListModel new])
				glamourPresentation: aListPresentation;
				items: items;
				displaySelector: aListPresentation format;
				searchBlock: aListPresentation searchStrategy;
				filterBlock: aListPresentation filterStrategy;
				yourself.
	container := self emptyMorph.
	list := aListPresentation isMultiple
				ifTrue: [
					PluggableListMorphOfMany
						on: listModel
						list: #displayedItems
						primarySelection: #selection
						changePrimarySelection: #selection:
						listSelection: #listSelectionAt:
						changeListSelection: #listSelectionAt:put:
						menu: #menu
						keystroke: #keystroke:from:]
				ifFalse: [
					PluggableListMorph
						on: listModel 
						list: #displayedItems 
						selected: #singleSelection 
						changeSelected: #singleSelection: 
						menu: #menu
						keystroke: #keystroke:from: ].
	list
		color: Color white;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		getMenuSelector: #menu:;
		alwaysShowScrollBars: false;
		keystrokeActionSelector: #keystroke:from:;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1)).
	self installActionsOnUI: listModel fromPresentation: aListPresentation.
	listModel onSelection: [:selection | aListPresentation selection: selection].
	aListPresentation allowsInput ifTrue: [
		search := UITheme current
			newTextEntryIn: nil
			for: listModel
			get: #searchText
			set: #searchText:
			class: String
			getEnabled: #searchEnabled
			help: 'Search Input'.
		search layoutFrame: (LayoutFrame
			fractions: (0 @ 1 corner: 1 @ 1) 
			offsets: (0 @ -24 corner: 0 @ 0)).
		list layoutFrame bottomOffset: -24.
		container addMorphBack: search ].
	container addMorphBack: list.
	aListPresentation when: GLMContextChanged do: [:ann | 
		ann property = #selection ifTrue: [listModel selectItem: ann value ]].
	^ container
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderMagrittePresentation: anAsMorphPresentation [ 
	| toShow description magritteMorph scrollPane |
	
	toShow := anAsMorphPresentation displayValue.
	description := (anAsMorphPresentation magritteDescription glamourValue: toShow) copy.
	description morphClass: MASilentContainerMorph.
	magritteMorph := (description asMorphOn: toShow) 
		addButtons;
		morph.
	magritteMorph
			layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			vResizing: #spaceFill;
			hResizing: #spaceFill.
	scrollPane := ScrollPane new.
	scrollPane
			layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			vResizing: #spaceFill;
			hResizing: #spaceFill.
	scrollPane scroller addMorph: magritteMorph.
	^ scrollPane

]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderMondrianPresentation: aMondrianPresentation [ 
	 
	| canvas view canvasScrollPane | 
	view := MOViewRenderer new.
	aMondrianPresentation renderOn: view. 
	canvas := MOCanvas new. 
	canvas root: view root.
	canvas announcer
		when: MOFigureSelection
		do: [ :ann | aMondrianPresentation selection: ann element model ].
	canvasScrollPane := ScrollPane new.
	canvasScrollPane scroller addMorph: canvas.	
	canvasScrollPane
		color: Color white;
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	^ canvasScrollPane
	

"	aMondrianPresentation 
		whenContextChanged: 
			[:ann |  
			ann property = #selection 
				ifTrue: 
					[canvas artist drawing deepNodeFigures do: [:each | each deselect]. 
					(canvas artist drawing deepFindNodeWithEntity: ann value) 
						ifNotNil: [:figure | figure fixedSelect]]]. 

	scrollPane := GeneralScrollPane new
		scrollTarget: canvas;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	scrollPane
		minWidth: (canvas width min: Display width // 2) + scrollPane scrollBarThickness;
		minHeight: (canvas height min: Display height // 2).
	canvas width > scrollPane minWidth
		ifTrue: [scrollPane minHeight: scrollPane minHeight + scrollPane scrollBarThickness].

	scrollPane updateScrollbars.
	^ scrollPane
"
]

{ #category : #rendering }
GLMMorphicRenderer >> renderPane: aPane [ 
	| container |
	container := self emptyMorph.
	aPane whenMatchingPresentationsChanged: [:ann |
		container removeAllMorphs;
				addMorph: (self renderPresentationsOf: aPane)
				fullFrame: (LayoutFrame fractions: (0@0 corner: 1@1));
				adoptPaneColor: container paneColor].
	container
		addMorph: (self renderPresentationsOf: aPane)
		fullFrame: (LayoutFrame fractions: (0@0 corner: 1@1));
		 adoptPaneColor: container paneColor.
	^ container
]

{ #category : #private }
GLMMorphicRenderer >> renderPresentationsOf: aPane [
	| presentations tabs | 
	presentations := aPane matchingPresentations.
	presentations isEmpty
		ifTrue: [ ^ self emptyMorph ].
	presentations size = 1
		ifTrue: [ ^ self render: presentations first ].
	tabs := LazyTabGroupMorph new. 
	tabs vResizing: #spaceFill; hResizing: #spaceFill.
	tabs cornerStyle: (self theme tabGroupCornerStyleIn: nil).
	tabs font: self theme labelFont.
	presentations do: [ :each | 
		tabs
			addLazyPage: [ self render: each ]
			label: (each titleValue ifNil: [ each printString ]) ].
	tabs selectedPageIndex: 1.
	^ tabs
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderTableLayoutBrowser: aBrowser [ 
	| container |
	container := self emptyMorph.
	aBrowser cell isRow
		ifTrue: [
			self
				renderCustomRow: aBrowser cell
				ofPane: aBrowser pane
				inUI: container
				inBrowser: aBrowser ]
		ifFalse: [
			self
				renderCustomColumn: aBrowser cell
				ofPane: aBrowser pane
				inUI: container
				inBrowser: aBrowser ].
	^ container
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTextPresentation: aTextPresentation [ 
	| textMorph toShow textModel | 
	toShow := aTextPresentation formatedDisplayValue. 
	textModel := GLMTextModel new
			text: toShow;
			glamourPresentation: aTextPresentation;
			highlightSmalltalk: aTextPresentation highlightSmalltalk;
			highlightSmalltalkContext: aTextPresentation highlightSmalltalkContext.
	textMorph := (PluggableShoutMorph
		on: textModel
		text: #text
		accept: #accept:notifying:
		readSelection: #selection
		menu: #menu:shifted:)
			onKeyStrokeSend: #keystroke:from: to: textModel;
			layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			color: Color white;
			yourself.
	self installActionsOnUI: textModel fromPresentation: aTextPresentation.
	aTextPresentation selectedTextBlock: [ textMorph textMorph editor selection ].
	^textMorph
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTreePresentation: aTreePresentation [	 
	| treeMorph treeModel |
	treeModel := GLMTreeMorphModel new
		glamourPresentation: aTreePresentation;
		roots: aTreePresentation displayValue;
		childrenBlock: aTreePresentation children;
		displayFormat: aTreePresentation format;
		yourself.
	treeMorph := (MorphTreeMorph new)
			 	on: treeModel 
				list: #roots
				selected: #getCurrentSelection
				changeSelected: #noteNewSelection:
				menu: #menu:shifted:
				keystroke: #keyStroke:from:;
				cornerStyle: #square;
				borderStyle: (BorderStyle inset width: 1);
				hResizing: #spaceFill;
				vResizing: #spaceFill;
				autoDeselect: true;
				yourself.
	self installActionsOnUI: treeModel fromPresentation: aTreePresentation.	
	treeModel onSelection: [:selection | aTreePresentation selection: selection]. 
	treeMorph vShowScrollBar.	
	aTreePresentation when: GLMContextChanged do: [:ann | 
		ann property = #selection ifTrue: [ treeModel selectItem: ann value ]].
	^treeMorph
]

{ #category : #factory }
GLMMorphicRenderer >> theme [
	^ UITheme current
]
