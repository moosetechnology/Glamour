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

{ #category : #private }
GLMMorphicRenderer >> installActionsOnUI: aMorphicModel fromPresentation: aPresentation [	 
	aPresentation actions 
		do: 
			[:action |  
			"menu actions"
			aMorphicModel when: GLMMenuItemSelected do: [:ann | ann action actOn: aPresentation].
			action hasTitle ifTrue: [aMorphicModel addMenuAction: action].
			
			"keystroke actions"
			aMorphicModel when: GLMKeyStroke do: [:ann | ann action actOn: aPresentation].			
			action hasShortcut ifTrue: [aMorphicModel addKeystrokeAction: action]]
]

{ #category : #opening }
GLMMorphicRenderer >> open: aRenderable [ 
	
	| window |
	window := GlamorousSystemWindow openOn: (self render: aRenderable).
	window actions: (
		(aRenderable actions select: [:each | each hasShortcut]) collect: [ :action | 
			action title -> [ action actOn: aRenderable ] ]).
	window setLabel: aRenderable titleValue.
]

{ #category : #private }
GLMMorphicRenderer >> renderCustomColumn: aCell ofPane: aPane inUI: aUIContainer inBrowser: aBrowser [ 
	 
	| panes pane glamourPane totalSpans currentSpanPosition | 
	totalSpans := aCell children inject: 0 into: [ :sum :each | sum + each span ]. 
	currentSpanPosition := 0. 
	panes := aCell children collectWithIndex: [:each :index |  
			each hasId ifFalse: [
				pane := RectangleMorph new. 
				self renderCustomRow: each ofPane: aPane inUI: pane inBrowser: aBrowser] 
			ifTrue: [
				glamourPane := aBrowser paneNamed: each id. 
				pane := glamourPane renderGlamorouslyOn: self.
				"glamourPane onPortValueChange: [:announcement | aPane portValueAt: announcement portName put: announcement portValue]."
			]. 
			aUIContainer addMorphBack: pane. 
			"pane 
				frame: 
					(FractionalFrame 
						fractionLeft: 0 
						right: 1 
						top: currentSpanPosition / totalSpans 
						bottom: (currentSpanPosition + each span) / totalSpans). "
			currentSpanPosition := currentSpanPosition + each span. 
			pane]. 
		
	"1 
		to: panes size - 1 
		do: 
			[:index |  
			topPane := panes at: index. 
			splitter := ResizingSplitter new. 
			splitter 
				frame: 
					((FractionalFrame 
						fractionLeft: 0 
						right: 1 
						top: topPane frame bottomFraction 
						bottom: topPane frame bottomFraction) setOffsetLeft: 0 top: -2 right: 
							0 bottom: 2). 
			splitter beHorizontal. 
			splitter topWidgets: (OrderedCollection with: (panes at: index) id). 
			splitter 
				bottomWidgets: (OrderedCollection with: (panes at: index + 1) id). 
			aUIContainer addComponent: splitter]"
]

{ #category : #private }
GLMMorphicRenderer >> renderCustomRow: aCell ofPane: aPane inUI: aUIContainer inBrowser: aBrowser [ 
	| panes pane glamourPane totalSpans currentSpanPosition | 
	
	totalSpans := aCell children inject: 0 into: [ :sum :each | sum + each span ]. 
	currentSpanPosition := 0.
	panes := aCell children 
		collectWithIndex: 
			[:each :index |  
			each hasId 
				ifFalse: 
					[pane := RectangleMorph new. 
					pane 
						layoutPolicy: TableLayout new;
						listDirection: #leftToRight;
						cellPositioning: #topLeft;
						borderWidth: 0;
						hResizing: #spaceFill;
						vResizing: #spaceFill;		
						wrapCentering: #center;
						rubberBandCells: false;
						layoutInset: 2;
						cellInset: 2;
						color: Color white.	
					self renderCustomColumn: each ofPane: aPane inUI: pane inBrowser: aBrowser] 
				ifTrue: 
					[glamourPane := aBrowser paneNamed: each id. 
					pane := glamourPane renderGlamorouslyOn: self.
					"glamourPane onPortValueChange: [:announcement | aPane portValueAt: announcement portName put: announcement portValue]"
					]. 
			aUIContainer addMorphBack: pane. 
			pane]. 
"	1 
		to: panes size - 1 
		do: 
			[:index |  
			leftPane := panes at: index. 
			splitter := BorderedSubpaneDividerMorph new. 

			splitter vertical. 
			
			aUIContainer addMorph: splitter]"
		
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
		do: [ :ann | container pushPane: (ann pane renderGlamorouslyOn: self).].
	aBrowser panes do: [ :each | container pushPane: (each renderGlamorouslyOn: self) ].
	^ container
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderListPresentation: aListPresentation [ 
	| items list toShow listModel container search searchButton | 

	toShow := aListPresentation displayValue. 
	items := toShow isCollection ifTrue: [ toShow ] ifFalse: [ Array with: toShow ]. 

	listModel := GLMListModel new 
				items: (items ifNil: [OrderedCollection new]); 
				displaySelector: aListPresentation format;
				searchBlock: aListPresentation searchStrategy;
				yourself.
	
	container := RectangleMorph new
		borderWidth: 0;
		color: Color transparent;
		layoutPolicy: TableLayout new;
		cellPositioning: #topLeft;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		yourself.
	
	list := aListPresentation isMultiple ifFalse: [
		PluggableListMorph
			on: listModel 
			list: #items 
			selected: #singleSelection 
			changeSelected: #singleSelection:
			menu: #menu:
			keystroke: #keystroke:from:.
	] ifTrue: [	
		"MorphicToolBuilder new buildPluggableMultiSelectionList: (PluggableMultiSelectionListSpec new
			model: listModel;
			list: #items;
			menu: #menu;
			getIndex: #selection;
			setIndex: #selection:;
			getSelectionList: #listSelectionAt:;
			setSelectionList: #listSelectionAt:put:;
			yourself)."
		PluggableListMorphOfMany
			on: listModel 
			list: #items 
			primarySelection: #selection 
			changePrimarySelection: #selection: 
			listSelection: #listSelectionAt:
			changeListSelection: #listSelectionAt:put:
			menu: #menu
			keystroke: #keystroke:from:.
	].
	list	
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		getListElementSelector: #displayListAt:;
		getListSizeSelector: #listSize;
		borderWidth: 1;
		autoDeselect: false.
	self installActionsOnUI: listModel fromPresentation: aListPresentation.
	listModel onSelection: [:selection | aListPresentation selection: selection]. 
"	aListPresentation whenContextChanged: [:ann | 
		ann property = #selection ifTrue: [ list selection: ann value ] ].
"
	list vShowScrollBar.
	aListPresentation isSearchable ifTrue: [
		search := UITheme current 
			newTextEntryIn: nil 
			for: listModel
			get: #searchText
			set: #searchText:
			class: nil  
			getEnabled: #searchEnabled 	
			help: 'Search bar'.
	
		searchButton := UITheme current
				newButtonIn: nil 
				for: listModel 
				getState: #search 
				action: #doSearch
				arguments: nil
				getEnabled: #searchEnabled 
				label: 'Search' 
				help: 'Search'.
		container addMorph: searchButton.
		container addMorph: search.
	].
	container addMorph: list.
	
	^container
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
	scrollPane := ScrollPane new.
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
	 
	| container inspectButton label | 
	container := RectangleMorph new. 
	container
		layoutPolicy: TableLayout new;
		listDirection: #leftToRight;
		cellPositioning: #topLeft;
		borderWidth: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill;		
		wrapCentering: #center;
		rubberBandCells: false;
		layoutInset: 2;
		cellInset: 2;
		color: Color white.

	(aPane matchingPresentations anySatisfy: [:each | each isInspectable]) ifTrue: [
		label := PluggableTextMorph new. 
		label layoutInset: 2. 
		label setText: (aPane port: #entity) value displayString. 
		inspectButton := PluggableButtonMorph new. 
		inspectButton label: (aPane port: #entity) value displayString.
		container addMorphBack: inspectButton ].
	
	container addMorph: (self renderPresentationsOf: aPane).
	aPane whenMatchingPresentationsChanged: [:ann |  
		container removeAllMorphs.
		container addMorph: (self renderPresentationsOf: aPane) ].
	^ container
]

{ #category : #private }
GLMMorphicRenderer >> renderPresentationsOf: aPane [ 
	 
	| presentations tabs | 
	presentations := OrderedCollection new. 
	aPane matchingPresentations do: [:each |  
		(each renderGlamorouslyOn: self) ifNotNil: [:ui | 
			presentations addLast: each titleValue -> ui]]. 
	presentations size < 1 ifTrue: [
		^RectangleMorph new width: 1; height: 1; cellPositioning: #topLeft; yourself]. 
	presentations size = 1 ifTrue: [
		^presentations first value cellPositioning: #topLeft; yourself]. 

	tabs := TabGroupMorph new. 
	tabs 
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: #rounded;
		borderWidth: 0;
		cellPositioning: #topLeft.
	presentations do: [:each |  | label |
		label := each key ifNil: ['unnamed'].
		tabs 
			addPage: each value 
			label: ((LabelMorph contents: label) hResizing: #spaceFill)]. 
	tabs selectedPageIndex: 1. 
	^tabs
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderTableLayoutBrowser: aBrowser [ 
	 
	| container | 
	container := RectangleMorph new. 
	container 
		layoutPolicy: TableLayout new;
		borderWidth: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill;		
		wrapCentering: #center;
		rubberBandCells: false;
		layoutInset: 2;
		cellInset: 2;
		color: Color white;
		yourself.	
	aBrowser cell isRow 
		ifTrue: 
			[container listDirection: #leftToRight.
			self 
				renderCustomRow: aBrowser cell 
				ofPane: aBrowser pane 
				inUI: container 
				inBrowser: aBrowser] 
		ifFalse: 
			[container listDirection: #topToBottom. 
			self
				renderCustomColumn: aBrowser cell 
				ofPane: aBrowser pane 
				inUI: container 
				inBrowser: aBrowser].
	^container
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTextPresentation: aTextPresentation [ 
	 
	| textMorph toShow textModel | 
	toShow := aTextPresentation formatedDisplayValue. 
	textModel := GLMTextModel new text: toShow.
	textModel onTextChanged: [:text | aTextPresentation text: text].
	
	textMorph := (PluggableTextMorph 
		on: textModel
		text: #text
		accept: #accept:notifying:
		readSelection: #selection
		menu: #menu:shifted:)
			font: Preferences standardCodeFont;
			onKeyStrokeSend: #keystroke:from: to: textModel;
			acceptOnCR: true;
			height: Preferences standardCodeFont height * 1.2;
			borderWidth: 0;
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			cellPositioning: #topLeft;
			yourself.
	self installActionsOnUI: textModel fromPresentation: aTextPresentation.
	textMorph vShowScrollBar.
"	text 
		when: ValueChanged 
		do: [:ann | aTextPresentation text: ann newValue]. "
	^textMorph
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTreePresentation: aTreePresentation [	 
	| toShow treeMorph treeModel | 
	
	toShow := aTreePresentation displayValue. 
	treeModel := GLMTreeModel new roots: toShow; yourself.
	treeModel 
			childrenBlock: aTreePresentation children;
			displaySelector: aTreePresentation format.
	
	treeMorph := PluggableTreeMorph new
		model: treeModel;
		getLabelSelector: #getLabelOf:;		
		getSelectedPathSelector: #getSelectionPath;				
		getChildrenSelector: #getChildrenOf:;
		hasChildrenSelector: #hasChildren:;
		setSelectedSelector: #selection:;					
		getRootsSelector: #roots;
		keystrokeActionSelector: #keystroke:from:;		
		vResizing: #spaceFill;
		hResizing: #spaceFill;		
		borderWidth: 1;
		autoDeselect: false;
		yourself.
	self installActionsOnUI: treeModel fromPresentation: aTreePresentation.
	
	treeModel onSelection: [:selection | aTreePresentation selection: selection]. 
	treeMorph vShowScrollBar.	
	^treeMorph
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderWorkspacePresentation: aWorkspacePresentation [ 
	 
	^ self renderTextPresentation: aWorkspacePresentation
]
