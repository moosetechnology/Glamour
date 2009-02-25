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

	^aUI openInWorld
]

{ #category : #private }
GLMMorphicRenderer >> fixedFinderRenderHelper [ 
	 
	^fixedFinderRenderHelper 
		ifNil: 
			[fixedFinderRenderHelper := FixedFinderRenderHelper new renderer: self]
]

{ #category : #private }
GLMMorphicRenderer >> installActionsOnUI: text fromPresentation: aTextPresentation [ 
	 
	aTextPresentation actions 
		do: 
			[:each |  
			text keymap 
				map: (Keystroke ctrl: each shortcut) 
				to: (#action , each shortcut asSymbol) asSymbol. 
			text 
				addAction: 
					(Action 
						id: (#action , each shortcut asSymbol) asSymbol 
						action: [each actOn: aTextPresentation pane])]
]

{ #category : #private }
GLMMorphicRenderer >> renderCustomColumn: aCell ofPane: aPane inUI: aUIContainer inBrowser: aBrowser [ 
	 
	| panes pane glamourPane totalSpans currentSpanPosition | 
	totalSpans := aCell children sum: #span. 
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
					pane := glamourPane renderGlamorouslyOn: self	"glamourPane onPortValueChange: [:announcement | aPane portValueAt: announcement portName put: announcement portValue]."]. 
			aUIContainer addMorph: pane. 
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
					self renderCustomColumn: each ofPane: aPane inUI: pane inBrowser: 
							aBrowser] 
				ifTrue: 
					[glamourPane := aBrowser paneNamed: each id. 
					pane := glamourPane renderGlamorouslyOn: self	"glamourPane onPortValueChange: [:announcement | aPane portValueAt: announcement portName put: announcement portValue] "]. 
			aUIContainer addMorph: pane. 
			"pane 
				frame: 
					(FractionalFrame 
						fractionLeft: currentSpanPosition / totalSpans 
						right: (currentSpanPosition + each span) / totalSpans 
						top: 0 
						bottom: 1). "
			currentSpanPosition := currentSpanPosition + each span. 
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
	 
	| items list toShow | 
	toShow := aListPresentation displayValue. 
	items := toShow isCollection 
		ifTrue: [toShow] 
		ifFalse: [Array with: toShow]. 
	list := PluggableListMorph on: (GLMListModel new items: ((items ifNil: [OrderedCollection new]) collect: [:e | e perform: aListPresentation format])) list: #items selected: #selection changeSelected: #selection:.
		list		color: Color white;
			borderInset;
			vResizing: #spaceFill;
			hResizing: #rigid;
			width: 150.
	self installActionsOnUI: list fromPresentation: aListPresentation. 
	"list 
		when: SelectionChanged 
		do: [:ann | aListPresentation selection: ann pane selection]. "
	aListPresentation 
		whenContextChanged: 
			[:ann | ann property = #selection ifTrue: [list selection: ann value]]. 
	"list verticalScrollbar: true. "
	^list
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderMondrianPresentation: aMondrianPresentation [ 
	 
	| canvas view form | 
	view := aMondrianPresentation renderView. 
	canvas := MondrianCanvas new. 
	canvas frame: FractionalFrame fullyAttached. 
	canvas renderer: view. 
	canvas 
		when: SelectionChanged 
		do: [:ann | aMondrianPresentation selection: canvas selection]. 
	form := MooseForm new. 
	form addComponent: canvas. 
	form frame: FractionalFrame fullyAttached. 
	aMondrianPresentation 
		whenContextChanged: 
			[:ann |  
			ann property = #selection 
				ifTrue: 
					[canvas artist drawing deepNodeFigures do: [:each | each deselect]. 
					(canvas artist drawing deepFindNodeWithEntity: ann value) 
						ifNotNil: [:figure | figure fixedSelect]]]. 
	^form
]

{ #category : #rendering }
GLMMorphicRenderer >> renderPane: aPane [ 
	 
	| container topOffset inspectButton label | 
	container := RectangleMorph new. container color: Color red.
	"container frame: FractionalFrame fullyAttached." 
	topOffset := 0. 
	(aPane matchingPresentations anySatisfy: [:each | each isInspectable]) 
		ifTrue: 
			[topOffset := 28. 
			label := PluggableTextMorph new. 
			label layoutInset: 2. 
			label setText: (aPane port: #entity) value displayString. 
			inspectButton := PluggableButtonMorph new. 
			inspectButton 
				frame: 
					(LayoutFrame new 
						leftFraction: 0; 
						topFraction: 0; 
						rightFraction: 1; 
						bottomFraction: 0; 
						bottomOffset: 24;
						yourself). 
			inspectButton addComponent: label. 
			"inspectButton 
				when: Clicked 
				do: [(aPane port: #entity) value inspect]. "
			container addComponent: inspectButton]. 
	container addMorph: (self renderPresentationsOf: aPane).	
	aPane 
		whenMatchingPresentationsChanged: 
			[:announcement |  
			container removeAllComponents. 
			container addComponent: (self renderPresentationsOf: aPane)]. 
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
	 
	| presentations form | 
	presentations := OrderedCollection new. 
	aPane matchingPresentations 
		do: 
			[:each |  
			(each renderGlamorouslyOn: self) 
				ifNotNil: [:ui | presentations addLast: each title -> ui]]. 
	presentations size < 1 ifTrue: [^RectangleMorph new]. 
	presentations size = 1 ifTrue: [^presentations first value]. 
	"tabs := TabControl new. 
	tabs frame: FractionalFrame fullyAttached. 
	presentations 
		do: 
			[:each |  
			form := RectangleMorph new. 
			each value frame: FractionalFrame fullyAttached. 
			form addComponent: each value. 
			tabs 
				addPage: form 
				label: each key]. 
	tabs showPage: 1. 
	^tabs"
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderTableLayoutBrowser: aBrowser [ 
	 
	| container | 
	container := RectangleMorph new. 
	"container frame: FractionalFrame fullyAttached. "
	aBrowser cell isRow 
		ifTrue: 
			[self 
				renderCustomRow: aBrowser cell 
				ofPane: aBrowser pane 
				inUI: container 
				inBrowser: aBrowser] 
		ifFalse: 
			[self
				renderCustomColumn: aBrowser cell 
				ofPane: aBrowser pane 
				inUI: container 
				inBrowser: aBrowser].
	^container
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTextPresentation: aTextPresentation [ 
	 
	| text toShow | 
	toShow := aTextPresentation formatedDisplayValue. 
	text := TextEdit new. 
	text frame: FractionalFrame fullyAttached. 
	text model value: (UIText fromString: toShow).	"(toShow ifNil: [''])." 
	text horizontalScrollbar: true. 
	text verticalScrollbar: true. 
	self installActionsOnUI: text fromPresentation: aTextPresentation. 
	text 
		when: ValueChanged 
		do: [:ann | aTextPresentation text: ann newValue]. 
	^text
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTreePresentation: aTreePresentation [ 
	 
	| list toShow | 
	toShow := aTreePresentation displayValue. 
	list := TreeView new. 
	list frame: FractionalFrame fullyAttached. 
	list 
		tree: 
			(Tree 
				on: toShow 
				childrenBlock: aTreePresentation children) expandRoot. 
	list displaySelector: aTreePresentation format. 
	list 
		when: SelectionChanged 
		do: [:ann | aTreePresentation selection: ann pane selection]. 
	list verticalScrollbar: true. 
	^list
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
