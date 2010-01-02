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
	#instVars : [
		'window'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #private }
GLMMorphicRenderer >> amountFilteringButtonFor: treeModel [
	| amountFilteringButton |
	amountFilteringButton := GLMMorphic 
			togglingButtonLabelled: 'There are hidden elements'
			pressed: false.
	amountFilteringButton layoutFrame: (LayoutFrame 
				fractions: (0 @ 0 corner: 1 @ 0)
				offsets: (0 @ 0 corner: 0 @ 24)).
	amountFilteringButton
			target: treeModel;
			actionSelector: #toggleAmountToFilterBy.
	^ amountFilteringButton
]

{ #category : #private }
GLMMorphicRenderer >> installActionsOnUI: aMorphicModel fromPresentation: aPresentation [	 
	aMorphicModel when: GLMMenuItemSelected do: [ :ann | ann action actOn: aPresentation ].
	aMorphicModel when: GLMKeyStroke do: [ :ann | ann action actOn: aPresentation ].
]

{ #category : #opening }
GLMMorphicRenderer >> open: aRenderable [
	^ ( self windowFor: aRenderable ) openInWorld
]

{ #category : #accessing }
GLMMorphicRenderer >> postBuildActions [
	^ postBuildActions ifNil: [postBuildActions := OrderedCollection new]
]

{ #category : #accessing }
GLMMorphicRenderer >> postBuildActions: anObject [
	postBuildActions := anObject
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderActionListPresentation: anActionListPresentation [ 
	| items list toShow container button buttonModel |
	toShow := anActionListPresentation displayValue.
	items := toShow isCollection 
		ifTrue: [ toShow ]
		ifFalse: [ OrderedCollection with: toShow ].
	container := GLMMorphic emptyMorph.
	anActionListPresentation allActions withIndexDo: 
		[ :each :index | 
		buttonModel := GLMButtonModel new.
		buttonModel glamourPresentation: anActionListPresentation.
		buttonModel glamourAction: each.
		button := PluggableButtonMorph 
			on: buttonModel
			getState: nil
			action: #execute
			label: #buttonLabel.
		container 
			addMorph: button
			fullFrame: (LayoutFrame 
					fractions: (0 @ 0 corner: 1 @ 0)
					offsets: (0 @ ((index - 1) * 24) corner: 0 @ (index * 24))) ].
	^ container
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderCompositePresentation: aCompositePresentation [
	self flag: 'implement me'
]

{ #category : #private }
GLMMorphicRenderer >> renderCustomColumn: aCell ofPane: aPane inUI: aMorph inBrowser: aBrowser [ 
	| pane totalSpans currentSpanPosition currentOffset |
	totalSpans := aCell children 
		inject: 0
		into: [ :sum :each | sum + each span ].
	currentSpanPosition := 0.
	currentOffset := 0.
	aCell children keysAndValuesDo: 
		[ :index :each | 
		each hasId 
			ifTrue: [ pane := self render: (aBrowser paneNamed: each id) ]
			ifFalse: 
				[ self 
					renderCustomRow: each
					ofPane: aPane
					inUI: (pane := GLMMorphic emptyMorph)
					inBrowser: aBrowser.
				pane addPaneSplitters ].
		pane layoutFrame: (LayoutFrame new
				topFraction: currentSpanPosition / totalSpans
					offset: currentOffset;
				leftFraction: 0
					offset: 0;
				bottomFraction: (currentSpanPosition + each span) / totalSpans
					offset: currentOffset + each size;
				rightFraction: 1
					offset: 0;
				yourself).
		aMorph addMorphBack: pane.
		currentSpanPosition := currentSpanPosition + each span.
		currentOffset := currentOffset + each size ].
	aMorph addPaneSplitters
]

{ #category : #private }
GLMMorphicRenderer >> renderCustomRow: aCell ofPane: aPane inUI: aMorph inBrowser: aBrowser [ 
	| pane totalSpans currentSpanPosition currentOffset |
	totalSpans := aCell children 
		inject: 0
		into: [ :sum :each | sum + each span ].
	currentSpanPosition := 0.
	currentOffset := 0.
	aCell children keysAndValuesDo: 
		[ :index :each | 
		each hasId 
			ifTrue: [ pane := self render: (aBrowser paneNamed: each id) ]
			ifFalse: 
				[ self 
					renderCustomColumn: each
					ofPane: aPane
					inUI: (pane := GLMMorphic emptyMorph)
					inBrowser: aBrowser.
				pane addPaneSplitters ].
		pane layoutFrame: (LayoutFrame new
				topFraction: 0
					offset: 0;
				leftFraction: currentSpanPosition / totalSpans
					offset: currentOffset;
				bottomFraction: 1
					offset: 0;
				rightFraction: (currentSpanPosition + each span) / totalSpans
					offset: currentOffset + each size;
				yourself).
		aMorph addMorphBack: pane.
		currentSpanPosition := currentSpanPosition + each span.
		currentOffset := currentOffset + each size ].
	aMorph addPaneSplitters
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderDiffPresentation: aDiffPresentation [ 
	| textMorph textModel |  
	textMorph := (DiffMorph from: aDiffPresentation displayValue first to: aDiffPresentation displayValue last)
"			onKeyStrokeSend: #keystroke:from: to: textModel;
"			layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			color: Color white;
			yourself.
"	self installActionsOnUI: textModel fromPresentation: aTextPresentation.
	aTextPresentation selectedTextBlock: [ textMorph textMorph editor selection ].
	aTextPresentation textBlock: [ textMorph textMorph editor text ].
"	^textMorph
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
	^ self renderTreePresentation: aListPresentation
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
	scrollPane := GLMScrollPaneForHResize new.
	scrollPane scroller
		addMorph: magritteMorph;
		layoutChanged.
	magritteMorph width: scrollPane width.
	^ scrollPane
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderMondrianPresentation: aMondrianPresentation [ 
	 
	| canvas view canvasScrollPane | 
	view := MOViewRenderer new.
	aMondrianPresentation renderOn: view. 
	canvas := MOCanvas new.
	canvas root: view root.
	canvas initializeHanders.
	canvas announcer
			when: MOFigureSelection
			do: [ :ann | aMondrianPresentation selection: ann element model ].
	self postBuildActions add: [:window | 
		view setDefaultHandlerForWindow: window ].
	canvasScrollPane := ScrollPane new.
	canvasScrollPane scroller addMorph: canvas.	
	canvasScrollPane
		color: Color white;
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	^ canvasScrollPane
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderMorphPresentation: aMorphPresentation [ 
	^ aMorphPresentation displayValue
]

{ #category : #rendering }
GLMMorphicRenderer >> renderPane: aPane [ 
	| container |
	container := GLMMorphic emptyMorph.
	aPane whenMatchingPresentationsChanged: [ :ann | 
		container
			removeAllMorphs;
			addMorph: (self renderPresentationsOf: aPane)
			fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			adoptPaneColor: container paneColor.
		window fullBounds.
		window refreshHorizontalScollbars ].
	container
		addMorph: (self renderPresentationsOf: aPane)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		adoptPaneColor: container paneColor.
	^ container
]

{ #category : #private }
GLMMorphicRenderer >> renderPresentationsOf: aPane [ 
	| presentations tabs title index |
	presentations := aPane matchingPresentations.
	presentations isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
	presentations size = 1 ifTrue: [ ^ self render: presentations first ].
	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (self theme tabGroupCornerStyleIn: nil);
		font: self theme labelFont;
		onPageIndexChange: [ :i | 
			aPane lastActivePresentation: (aPane matchingPresentations at: i) ].
	presentations do: [ :each | 
		title := each hasTitleIcon ifTrue: [
			self theme 
					newImageIn: tabs
					form: each titleIconValue ]
			ifFalse: [ each titleValue ].
		tabs 
			addLazyPage: [ self render: each ]
			label: title ].
	index := 1.
	presentations withIndexDo: [ :each :i | 
		aPane lastActivePresentation notNil and: [ 
			each title = aPane lastActivePresentation title ifTrue: [ index := i ] ] ].
	tabs selectedPageIndex: index.
	^ tabs
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderTableLayoutBrowser: aBrowser [ 
	| container |
	container := GLMMorphic emptyMorph.
	aBrowser cell isRow 
		ifTrue: 
			[ self 
				renderCustomRow: aBrowser cell
				ofPane: aBrowser pane
				inUI: container
				inBrowser: aBrowser ]
		ifFalse: 
			[ self 
				renderCustomColumn: aBrowser cell
				ofPane: aBrowser pane
				inUI: container
				inBrowser: aBrowser ].
	^ container
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTablePresentation: aPresentation [ 
	^ self renderTreePresentation: aPresentation
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
	"this is a horrible hack: 
	because we cannot get the update of when the text changes from the morph,
	we get the reference to the mutable text object :) :)"
	textModel text: textMorph textMorph asText. 
	self installActionsOnUI: textModel fromPresentation: aTextPresentation.
	aTextPresentation selectedTextBlock: [ textMorph textMorph editor selection ].
	aTextPresentation textBlock: [ textMorph textMorph editor text ].
	^textMorph
]

{ #category : #private }
GLMMorphicRenderer >> renderToolbarForBrowser: aBrowser inWindow: aWin [
	| dock tools |
	dock := aWin newToolDockingBar.
	tools := aWin newToolbar: ((aBrowser allActions select: [:each | each hasIcon]) collect: [:each |
		aWin
			newButtonFor: each
			getState: nil
			action: #actOn:
			arguments: {aBrowser}
			getEnabled: nil
			labelForm: each icon
			help: each title ]).
	dock addMorphBack: tools.
	^ dock
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTreePresentation: aPresentation [ 
	| treeMorph treeModel textInput container amountFilteringButton |
	treeModel := GLMTreeMorphModel new glamourPresentation: aPresentation.
	container := GLMMorphic emptyMorph.
	treeMorph := self treeMorphFor: treeModel and: aPresentation.
	aPresentation allowsInput ifTrue: [
		textInput := self textInputFor: treeModel.
		treeMorph layoutFrame bottomOffset: -24.
		container addMorphBack: textInput ].
	aPresentation limitsAmount ifTrue: [
		amountFilteringButton := self amountFilteringButtonFor: treeModel.
		treeMorph layoutFrame topOffset: 24.
		container addMorphBack: amountFilteringButton ].
	container addMorphBack: treeMorph.
	self installActionsOnUI: treeModel fromPresentation: aPresentation.

	treeModel announcer on: GLMTreeMorphSelectionChanged do: [ :ann | 
		aPresentation selection: ann selectionValue.
		aPresentation selectionPath: ann selectionPathValue ].
	treeModel announcer on: GLMTreeMorphStrongSelectionChanged do: [ :ann | 
		aPresentation strongSelection: ann strongSelectionValue ].
		
	aPresentation when: GLMContextChanged do: [ :ann | 
		ann property = #selection ifTrue: [ treeModel explicitSelection: ann value ] ].
	aPresentation when: GLMPresentationUpdated do: [:ann |
		treeModel updateRoots].
	^ container
]

{ #category : #opening }
GLMMorphicRenderer >> simulate: aRenderable [
	^ ( self windowFor: aRenderable ) 
		newBounds: (0@0 extent: 800@600);
		layoutChanged
]

{ #category : #private }
GLMMorphicRenderer >> textInputFor: treeModel [
	| textInput |
	textInput := self theme 
			newTextEntryIn: nil
			for: treeModel
			get: #inputText
			set: #inputText:
			class: String
			getEnabled: #inputTextEnabled
			help: 'Search Input'.
	textInput layoutFrame: (LayoutFrame 
				fractions: (0 @ 1 corner: 1 @ 1)
				offsets: (0 @ -24 corner: 0 @ 0)).
	^ textInput
]

{ #category : #factory }
GLMMorphicRenderer >> theme [
	^ UITheme current
]

{ #category : #private }
GLMMorphicRenderer >> treeMorphFor: treeModel and: aPresentation [
	| treeMorph columns |
	treeMorph := LazyMorphTreeMorph new.
	treeMorph
		makeLastColumnUnbounded;
		doubleClickSelector: #onDoubleClick;
		getMenuSelector: #menu:shifted:;
		keystrokeActionSelector: #keyStroke:from:;
		cornerStyle: #square;
		borderStyle: (BorderStyle inset width: 1);
		autoDeselect: aPresentation allowsDeselection;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		yourself.
	columns := OrderedCollection with: (MorphTreeColumn new rowMorphGetSelector: #elementColumn).
	self flag: 'Please refactor this part'.
	aPresentation columns notEmpty ifTrue: [
		columns last 
			headerButtonLabel: aPresentation title 
			font: Preferences standardMenuFont 
			target: nil 
			actionSelector: nil 
			arguments: #()].
	aPresentation columns do: [:each | 
		columns add: (GLMMorphTreeColumn new 
			glamourColumn: each; 
			headerButtonLabel: each title 
			font: Preferences standardMenuFont 
			target: nil 
			actionSelector: nil 
			arguments: #(); 
			yourself)].
	treeMorph
		on: treeModel
		list: #roots
		multiSelection: aPresentation isMultiple
		columns: columns.
	treeMorph vShowScrollBar.
	^ treeMorph
]

{ #category : #opening }
GLMMorphicRenderer >> windowFor: aRenderable [ 
	| dock offset |
	window := GLMSystemWindow new.
	window
		model: aRenderable;
		setLabel: aRenderable titleValue.
	aRenderable allActions notEmpty ifTrue: 
		[ dock := self 
			renderToolbarForBrowser: aRenderable
			inWindow: window.
		offset := dock minExtent y.
		window 
			addMorph: dock
			fullFrame: (LayoutFrame 
					fractions: (0 @ 0 corner: 1 @ 0)
					offsets: (0 @ 0 corner: 0 @ offset)) ].
	window 
		addMorph: (self render: aRenderable)
		fullFrame: (LayoutFrame 
				fractions: (0 @ 0 corner: 1 @ 1)
				offsets: (0 @ offset corner: 0 @ 0)).
	(self theme isKindOf: UIThemeWatery) ifFalse: 
		[ aRenderable colorValue ifNotNil: [ window paneColor: aRenderable colorValue ] ].
	self postBuildActions do: [:each |
		each value: window ].
	^ window
]
