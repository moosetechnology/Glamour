"
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
	#instVars : [
		'fixedFinderRenderHelper'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #opening }
GLMMorphicRenderer >> doOpen: aUI [ 

	^GlamorousSystemWindow openOn: aUI
]

{ #category : #private }
GLMMorphicRenderer >> fixedFinderRenderHelper [ 
	 
	^fixedFinderRenderHelper 
		ifNil: 
			[fixedFinderRenderHelper := FixedFinderRenderHelper new renderer: self]
]

{ #category : #private }
GLMMorphicRenderer >> installActionsOnUI: text fromPresentation: aTextPresentation [ 
	 
	"aTextPresentation actions 
		do: 
			[:each |  
			text keymap 
				map: (Keystroke ctrl: each shortcut) 
				to: (#action , each shortcut asSymbol) asSymbol. 
			text 
				addAction: 
					(Action 
						id: (#action , each shortcut asSymbol) asSymbol 
						action: [each actOn: aTextPresentation pane])]"
]

{ #category : #private }
GLMMorphicRenderer >> renderCustomColumn: aCell ofPane: aPane inUI: aUIContainer inBrowser: aBrowser [ 
	 
	| panes pane glamourPane totalSpans currentSpanPosition | 
	totalSpans := aCell children inject: 0 into: [ :sum :each | sum + each span ]. 
	currentSpanPosition := 0. 
	panes := aCell children 
		collectWithIndex: 
			[:each :index |  
			each hasId 
				ifFalse: 
					[pane := RectangleMorph new. 
					self renderCustomRow: each ofPane: aPane inUI: pane inBrowser: 
							aBrowser] 
				ifTrue: 
					[glamourPane := aBrowser paneNamed: each id. 
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
	container := Form new. 
	container 
		frame: (FractionalFrame fractionLeft: 0 right: 1 top: 0 bottom: 1). 
	container horizontalScrollbar: true. 
	aBrowser 
		when: PaneRemoved 
		do: [:ann | container removeComponent: container components last]. 
	aBrowser 
		when: PaneAdded 
		do: 
			[:ann |  
			self 
				renderPane: ann pane 
				inFinder: container. 
			container 
				contentsExtent: 
					(container components last frame windowRelativeBounds right + 10) @ 400. 
			container 
				scrollHorizontally: 
					container components last frame windowRelativeBounds right + 10]. 
	aBrowser panes do: [:each | self renderPane: each inFinder: container]. 
	^container
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderFixedFinder: aBrowser [ 
	 
	^self fixedFinderRenderHelper render: aBrowser	" 
	| container uiPane | 
	container := Widgetry.Form new. 
	container frame: Widgetry.FractionalFrame fullyAttached. 
	 
	aBrowser onPaneRemoved: [ :ann | 
		container removeComponent: container components last. 
	]. 
	aBrowser onPaneAdded: [ :ann | 
		uiPane := (ann pane renderGlamorouslyOn: self). 
		container components size > 1 ifTrue: [ 
			container removeComponent: container components first. 
			container components last frame: (Widgetry.FractionalFrame fractionLeft: 0 top: 0 right: 0.5 bottom: 1).		 
		]. 
		uiPane frame: (Widgetry.FractionalFrame fractionLeft: 0.5 top: 0 right: 1 bottom: 1).	 
		container addComponent: uiPane. 
	]. 
	aBrowser panes doWithIndex: [:each :index | 
		uiPane := (each renderGlamorouslyOn: self).		 
		uiPane frame: (Widgetry.FractionalFrame fractionLeft: (index - 1) * 0.5 top: 0 right: index * 0.5 bottom: 1). 
		container addComponent: uiPane. 
	]. 
	^container 
"
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderListPresentation: aListPresentation [ 
	 
	| items list toShow listModel | 
	toShow := aListPresentation displayValue. 
	items := toShow isCollection 
		ifTrue: [toShow] 
		ifFalse: [Array with: toShow]. 
		
	listModel := GLMListModel new 
				items: (items ifNil: [OrderedCollection new]); 
				displaySelector: aListPresentation format;
				yourself.	
	list := PluggableListMorph on: listModel list: #items selected: #selection changeSelected: #selection:.
	list	
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		getListElementSelector: #listAt:;
		getListSizeSelector: #listSize;
		borderWidth: 1;
		autoDeselect: false.
	self installActionsOnUI: list fromPresentation: aListPresentation.
	listModel onSelection: [:selection | aListPresentation selection: selection]. 
	aListPresentation 
		whenContextChanged: 
			[:ann | ann property = #selection ifTrue: [list selection: ann value]]. 
	list vShowScrollBar.	
	^list
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderMondrianPresentation: aMondrianPresentation [ 
	 
	| canvas view | 
	view := MOViewRenderer new.
	aMondrianPresentation renderOn: view. 
	canvas := MOCanvas new. 
	canvas root: view root. 
"	canvas 
		when: SelectionChanged 
		do: [:ann | aMondrianPresentation selection: canvas selection]. 
"
"	aMondrianPresentation 
		whenContextChanged: 
			[:ann |  
			ann property = #selection 
				ifTrue: 
					[canvas artist drawing deepNodeFigures do: [:each | each deselect]. 
					(canvas artist drawing deepFindNodeWithEntity: ann value) 
						ifNotNil: [:figure | figure fixedSelect]]]. 
"	^canvas
]

{ #category : #rendering }
GLMMorphicRenderer >> renderPane: aPane [ 
	 
	| container topOffset inspectButton label | 
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

	topOffset := 0. 
	(aPane matchingPresentations anySatisfy: [:each | each isInspectable]) 
		ifTrue: 
			[topOffset := 28.  
			label := PluggableTextMorph new. 
			label layoutInset: 2. 
			label setText: (aPane port: #entity) value displayString. 
			inspectButton := PluggableButtonMorph new. 
			"inspectButton 
				frame: 
					(LayoutFrame new 
						leftFraction: 0; 
						topFraction: 0; 
						rightFraction: 1; 
						bottomFraction: 0; 
						bottomOffset: 24;
						yourself). "
			inspectButton label: (aPane port: #entity) value displayString.
			"inspectButton 
				when: Clicked 
				do: [(aPane port: #entity) value inspect]. "
			container addMorphBack: inspectButton]. 
	container addMorphBack: (self renderPresentationsOf: aPane).	
	aPane 
		whenMatchingPresentationsChanged: 
			[:announcement |  
			container removeAllMorphs. 
			container addMorph: (self renderPresentationsOf: aPane)]. 
	^container
]

{ #category : #'private-finder' }
GLMMorphicRenderer >> renderPane: aPane inFinder: container [ 
	 
	| uiPane | 
	uiPane := aPane renderGlamorouslyOn: self. 
	container components isEmpty 
		ifFalse: 
			[uiPane 
				frame: 
					(InsetExtentFrame 
						inset: 
							(container components last frame windowRelativeBounds right + 4) @ 0 
						extent: 390 @ 500)	"				((FractionalFrame fractionLeft: 0 right: 0 top: 0 bottom: 1)  
					leftOffset: (container components last frame rightOffset + 4); 
					rightOffset: (container components last frame rightOffset + 4) + 500) 
"] 
		ifTrue: 
			[uiPane 
				frame: 
					(InsetExtentFrame 
						inset: 4 @ 0 
						extent: 390 @ 500)	"					((FractionalFrame fractionLeft: 0 right: 0 top: 0 bottom: 1) rightOffset: 500) 
"]. 
	container addComponent: uiPane
]

{ #category : #private }
GLMMorphicRenderer >> renderPresentationsOf: aPane [ 
	 
	| presentations tabs | 
	presentations := OrderedCollection new. 
	aPane matchingPresentations 
		do: 
			[:each |  
			(each renderGlamorouslyOn: self) 
				ifNotNil: [:ui | presentations addLast: each title -> ui]]. 
	presentations size < 1 ifTrue: [^RectangleMorph new width: 1; height: 1; cellPositioning: #topLeft; yourself]. 
	presentations size = 1 ifTrue: [^presentations first value]. 
	
	
	tabs := TabGroupMorph new. 
	tabs 
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: #rounded;
		borderWidth: 0;
		cellPositioning: #topLeft.
	presentations 
		do: 
			[:each |  
			tabs 
				addPage: each value 
				label: ((LabelMorph contents: each key) hResizing: #spaceFill)]. 
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
			hideScrollBarsIndefinitely;
			acceptOnCR: true;
			height: Preferences standardCodeFont height * 1.2;
			borderWidth: 0;
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			borderWidth: 1;
			cellPositioning: #topLeft;
			yourself.
	self installActionsOnUI: textMorph fromPresentation: aTextPresentation.
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
	treeModel childrenBlock: aTreePresentation children.
	
	treeMorph := PluggableTreeMorph new
		model: treeModel;
		getLabelSelector: #getLabelOf:;		
		getSelectedPathSelector: #getSelectionPath;				
		getChildrenSelector: #getChildrenOf:;
		hasChildrenSelector: #hasChildren:;
		setSelectedSelector: #selection:;					
		getRootsSelector: #roots;
		vResizing: #spaceFill;
		hResizing: #spaceFill;		
		borderWidth: 1;
		autoDeselect: false;
		yourself.

	treeModel onSelection: [:selection | aTreePresentation selection: selection]. 
	treeMorph vShowScrollBar.	
	^treeMorph
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderWorkspacePresentation: aWorkspacePresentation [ 
	 
	| pane result textToInsert position anObject | 
	anObject := aWorkspacePresentation pane input. 
	pane := TextEdit new. 
	pane keymap 
		map: (Keystroke ctrl: $o) 
		to: #doItAndSelect. 
	pane 
		addAction: 
			(Action 
				id: #doItAndSelect 
				action: 
					[result := self workspaceEvaluateSelectionFrom: anObject for: pane. 
					pane announce: (SelectionChanged new newValue: result)]). 
	pane keymap 
		map: (Keystroke ctrl: $q) 
		to: #doItAndInspect. 
	pane 
		addAction: 
			(Action 
				id: #doItAndInspect 
				action: 
					[result := self workspaceEvaluateSelectionFrom: anObject for: pane. 
					result inspect]). 
	pane keymap 
		map: (Keystroke ctrl: $d) 
		to: #doIt. 
	pane 
		addAction: 
			(Action 
				id: #doIt 
				action: 
					[result := self workspaceEvaluateSelectionFrom: anObject for: pane]). 
	pane keymap 
		map: (Keystroke ctrl: $p) 
		to: #doItAndPrint. 
	pane 
		addAction: 
			(Action 
				id: #doItAndPrint 
				action: 
					[result := self workspaceEvaluateSelectionFrom: anObject for: pane. 
					textToInsert := result printString. 
					position := pane agent insertionPosition. 
					pane insertAtCurrentPosition: textToInsert. 
					pane setInsertionPointAt: position. 
					pane extendSelectionByCharacters: textToInsert size]). 
	pane verticalScrollbar: true. 
	pane wordWrapped: true. 
	^pane
]

{ #category : #private }
GLMMorphicRenderer >> workspaceEvaluateSelectionFrom: anObject for: pane [ 
	 
	| bindings result namespaces text | 
	namespaces := Root allNameSpaces copyWithout: Undeclared. 
	bindings := NameSpace new 
		importsObjects: 
			(namespaces 
				collect: [:each | GeneralNameSpaceImport pathString: each fullName]). 
	bindings simpleAddBinding: (VariableBinding key: #entity value: anObject). 
	pane selection isEmpty 
		ifTrue: 
			[pane agent setInsertionPointToBeginningOfLine. 
			pane selectCurrentLine]. 
	text := pane selection. 
	result := Compiler evaluate: text for: nil in: bindings notifying: nil 
		logged: false. 
	^result
]
