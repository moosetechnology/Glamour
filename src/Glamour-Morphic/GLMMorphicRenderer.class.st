"
This is the class responsible for the binding to Morphic.

| browser |
browser := GLMTabulator new.
browser column: #one; column: #two.

browser transmit to: #one; andShow: [:a | a list.].
browser transmit to: #two; from: #one; andShow: [ :a |
	a text.].
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
			pressed: false
			style: #default.
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

{ #category : #private }
GLMMorphicRenderer >> menuIn: aMenuMorph for: aPresentation [
	| subMenus targetMenuMorph subMenu |
	subMenus := Dictionary new.
	(aPresentation allActions select: [:action | action hasTitle ]) do: [ :action |
		targetMenuMorph := action category notNil 
			ifTrue: [ subMenus at: action category ifAbsentPut: [ 
					subMenu :=  MenuMorph new.
					aMenuMorph add: action category subMenu: subMenu.
					subMenu ] ]
			ifFalse: [ aMenuMorph ].
		targetMenuMorph 
			add: action title
			target: action
			selector: #actOn:
			argument: aPresentation ].
	^ aMenuMorph
]

{ #category : #private }
GLMMorphicRenderer >> mondrianCanvasFor: aPresentation in: aScrollPane [ 
	| canvas view |
	view := aPresentation view.
	view root interaction menu: [ :x | self menuIn: MenuMorph new for: aPresentation ].
	aPresentation renderOn: view.
	canvas := MOCanvas new.
	canvas root: view root.
	canvas initializeHanders.
	canvas announcer
			when: MOFigureSelection
			do: [ :ann | aPresentation selection: ann element model ].
	canvas announcer
			when: MOMouseEnter
			do: [ :ann | aPresentation status: ann element model ].
	canvas announcer
			when: MOMouseLeave
			do: [ :ann | aPresentation status: nil ].
	aPresentation when: GLMPresentationUpdated do: [:ann |
		aPresentation view: MOViewRenderer new.
		aScrollPane scroller removeMorph: aScrollPane scroller submorphs first.
		self mondrianCanvasFor: aPresentation in: aScrollPane ].
	aPresentation when: GLMContextChanged do: [ :ann | 
			ann property = #selection ifTrue: [ 
				canvas selected: (canvas root deepFindNodeWithEntity: ann value) ] ].
	aScrollPane scroller addMorph: canvas.	

	^ canvas
]

{ #category : #private }
GLMMorphicRenderer >> moreToolbarActions: noIconActions on: aBrowser [
	| menuMorph |
	menuMorph := MenuMorph new.
	noIconActions do: [ :each | 
		menuMorph 
				add: each title
				target: each
				selector: #actOn:
				argument: aBrowser ].
	^ menuMorph
]

{ #category : #private }
GLMMorphicRenderer >> morph: aMorph withTitleOf: aPresentation [
	| container |
	container := self theme 
		newGroupboxIn: GLMMorphic emptyMorph 
		label: (self titleOrIconOf: aPresentation in: GLMMorphic emptyMorph).
	container addContentMorph: aMorph.
	^ container
]

{ #category : #private }
GLMMorphicRenderer >> morph: aMorph withTitleOrNilOf: aPresentation [
	| container empty |
	(aPresentation hasTitle or: [aPresentation hasTitleIcon]) ifFalse: [^ aMorph ].
	empty := GLMMorphic emptyMorph.
	container := self theme 
		newGroupboxIn: empty
		label: (self titleOrIconOrNilOf: aPresentation in: empty).
	container contentMorph cellInset: 2.
	container addContentMorph: aMorph.
	^ container
]

{ #category : #opening }
GLMMorphicRenderer >> open: aRenderable [
	^ ( self windowFor: aRenderable ) openInWorld
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderAccordionCompositePresentation: aCompositePresentation [
	^ GLMMorphicAccordionRenderer render: aCompositePresentation from: self
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderAccumulator: aBrowser [ 
	| tabs |
	aBrowser panes isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
"	presentations size = 1 ifTrue: [ 
		^ self morph: (self render: presentations first) withTitleOrNilOf: aCompositePresentation ].
"	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (self theme tabGroupCornerStyleIn: nil);
		font: self theme labelFont;
		onPageIndexChange: [ :i | 
			aBrowser activeEntity: ((aBrowser panes at: i) port: #entity) value ].
	aBrowser panes do: [ :each | 
		tabs 
			addLazyPage: [ self renderPaneWithoutTitle: each ]
			label: (self titleOrIconOf: each presentations in: tabs) ].
	aBrowser 
		when: GLMPaneSelected
		do: [ :ann | 
			tabs selectedPageIndex: ann position ].
	aBrowser 
		when: GLMPaneAdded
		do: [ :ann | 
			tabs addLazyPage: (self renderPaneWithoutTitle: ann pane) label: (self titleOrIconOf: ann pane presentations in: tabs).
			tabs selectedPageIndex: tabs lazyPages size ].
	tabs selectedPageIndex: tabs lazyPages size.
	^ tabs
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderActionListPresentation: anActionListPresentation [ 
	| container buttonModel button |
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
GLMMorphicRenderer >> renderDiffPresentation: aDiffPresentation [
	| textMorph |
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

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderDropDownListPresentation: aDropListPresentation [
	| listModel |

	listModel:= GLMDropListModel new glamourPresentation: aDropListPresentation.
	"When the morph changes, we want to update the glamour model"
	listModel announcer on: GLMDropDownListMorphSelectionChanged do: [ :ann | 	
		aDropListPresentation selection: ann selectionValue ].
	
	^(MorphDropListMorph
			on: listModel
			list: #list
			selected: #selectionIndex
			changeSelected: #selectionIndex:
			useIndex: true )
		hResizing: #spaceFill;
		vResizing: #shrinkWrap
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
	aBrowser 
		when: GLMPaneReplaced
		do: [ :ann | 
			container popAndReplacePane: (self render: ann newPane) ].
	aBrowser panes
		do: [ :each | container pushPane: (self render: each) ].
	^ container
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderInputPresentation: aPresentation [ 
	
	| morph |
	self flag: 'hook the cuis editor'.
	morph := GLMMorphic emptyMorph.
	^ morph
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderLabelPresentation: aLabelPresentation [ 
	| morph | 
	morph := (LabelMorph contents: aLabelPresentation formatedDisplayValue) 
			layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			yourself.
	^morph
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderListPresentation: aListPresentation [ 
	^ GLMMorphicListRenderer render: aListPresentation from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderListingPresentation: aPresentation [ 
	^ GLMMorphicListingRenderer render: aPresentation from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderMagrittePresentation: aMagrittePresentation [ 
	| toShow description magritteMorph scrollPane |
	toShow := aMagrittePresentation displayValue.
	description := (aMagrittePresentation magritteDescription glamourValue: toShow) copy.
	description morphClass: MASilentContainerMorph.
	magritteMorph := (description asMorphOn: toShow)
		addButtons;
		morph.
	scrollPane := GLMScrollPaneForHResize new.
	scrollPane scroller
		addMorph: magritteMorph
		";
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		layoutChanged".
	scrollPane layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1) offsets: (0 @ 25 corner: 0 @ 0)).

	aMagrittePresentation when: GLMPresentationUpdated do: [:ann |
		scrollPane scroller removeMorph: scrollPane scroller submorphs first.
		toShow := aMagrittePresentation displayValue.
		description := (aMagrittePresentation magritteDescription glamourValue: toShow) copy.
		description morphClass: MASilentContainerMorph.
		magritteMorph := (description asMorphOn: toShow)
			addButtons;
			morph.
		scrollPane scroller addMorph: magritteMorph].

	^ scrollPane
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderMondrianPresentation: aPresentation [
	| canvasScrollPane |
	canvasScrollPane := ScrollPane new.
	self mondrianCanvasFor: aPresentation  in: canvasScrollPane.
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
	aPane when: GLMMatchingPresentationsChanged do: [ :ann | 
		container
			removeAllMorphs;
			addMorph: (self renderWithTitleOrNil: aPane presentations)
			fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			adoptPaneColor: container paneColor.
		window fullBounds.
		window refreshHorizontalScollbars ].
	container
		addMorph: (self renderWithTitleOrNil: aPane presentations)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		adoptPaneColor: container paneColor.
	^ container
]

{ #category : #rendering }
GLMMorphicRenderer >> renderPaneWithoutTitle: aPane [ 
	| container |
	container := GLMMorphic emptyMorph.
	aPane when: GLMMatchingPresentationsChanged do: [ :ann | 
		container
			removeAllMorphs;
			addMorph: (self render: aPane presentations)
			fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			adoptPaneColor: container paneColor.
		window fullBounds.
		window refreshHorizontalScollbars ].
	container
		addMorph: (self render: aPane presentations)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		adoptPaneColor: container paneColor.
	^ container
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderStackedVerticallyCompositePresentation: aCompositePresentation [
	^ GLMMorphicVerticallyStackedRenderer render: aCompositePresentation from: self
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderStacker: aBrowser [ 
	| tabs |
	aBrowser panes isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (self theme tabGroupCornerStyleIn: nil);
		font: self theme labelFont.
	aBrowser panes do: [ :each | 
		tabs 
			addLazyPage: [ self renderPaneWithoutTitle: each ]
			label: (self titleOrIconOf: each presentations in: tabs) ].
	tabs selectedPageIndex: 1.
	^ tabs
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTabbedCompositePresentation: aCompositePresentation [
	^ GLMMorphicTabbedRenderer render: aCompositePresentation from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTablePresentation: aPresentation [ 
	^ GLMMorphicTableRenderer render: aPresentation from: self
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderTabulator: aBrowser [ 
	^ GLMTabulatorRenderer render: aBrowser from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTextPresentation: aTextPresentation [ 
	^ GLMMorphicTextRenderer render: aTextPresentation from: self
]

{ #category : #private }
GLMMorphicRenderer >> renderToolbarForBrowser: aBrowser inWindow: aWin [
	| dock tools buttons noIconActions |
	dock := aWin newToolDockingBar.
	buttons := (aBrowser allActions select: [:each | each hasIcon]) collect: [:each |
		aWin
			newButtonFor: each
			getState: nil
			action: #actOn:
			arguments: {aBrowser}
			getEnabled: nil
			labelForm: each icon
			help: each title ].
	noIconActions := aBrowser allActions select: [:each | each hasTitle and: [each hasIcon not]].
	tools := aWin newToolbar: buttons.
	noIconActions isEmpty ifFalse: [ 
		dock 
			add: 'Menu' translated
			font: aWin theme menuBarFont
			icon: nil
			help: 'Browser actions' translated
			subMenu: (self menuIn: MenuMorph new for: aBrowser).
		dock addMorphBack: tools ]
		ifTrue: [ dock addAllMorphs: buttons ].
	^ dock
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTreePresentation: aPresentation [ 
	^ GLMMorphicTreeRenderer render: aPresentation from: self
]

{ #category : #private }
GLMMorphicRenderer >> renderWithTitle: aPresentation [
	| morph |
	morph := self render: aPresentation.
	^ self morph: morph withTitleOf: aPresentation
]

{ #category : #private }
GLMMorphicRenderer >> renderWithTitleOrNil: aPresentation [
	| morph |
	morph := self render: aPresentation.
	^ self morph: morph withTitleOrNilOf: aPresentation
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
GLMMorphicRenderer >> titleOrIconOf: aPresentation in: container [
	^ aPresentation hasTitleIcon 
		ifTrue: [
			self theme 
					newImageIn: container
					form: aPresentation titleIconValue ]
		ifFalse: [ aPresentation titleValue ifNil: [''] ].
]

{ #category : #private }
GLMMorphicRenderer >> titleOrIconOrNilOf: aPresentation in: container [
	^ aPresentation hasTitleIcon 
		ifTrue: [
			self theme 
					newImageIn: container
					form: aPresentation titleIconValue ]
		ifFalse: [ 
			aPresentation hasTitle 
				ifTrue: [ aPresentation titleValue ]
				ifFalse: [ nil ] ]
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
		cornerStyle: treeMorph preferredCornerStyle;
		borderStyle: (BorderStyle inset width: 1);
		autoDeselection: aPresentation allowsDeselection;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1)).
	columns := aPresentation columns isEmpty 
		ifTrue: [ OrderedCollection with: (MorphTreeColumn new rowMorphGetSelector: #elementColumn)]
		ifFalse: [
			aPresentation columns collect: [:each | 
				GLMMorphTreeColumn new 
					glamourColumn: each; 
					headerButtonLabel: (aPresentation titleValueOfColumn: each) 
					font: Preferences standardMenuFont 
					target: nil 
					actionSelector: nil 
					arguments: #(); 
					yourself ].
		].
	treeMorph
		preferedPaneColor: Color white;	
		model: treeModel;
		nodeListSelector: #roots;
		columns: columns.
	aPresentation isMultiple 
		ifTrue: [treeMorph beMultiple] 
		ifFalse: [treeMorph beSingle].
	treeModel chunkSize: aPresentation amountToShow.
	treeMorph vShowScrollBar.
	^ treeMorph buildContents
]

{ #category : #opening }
GLMMorphicRenderer >> windowFor: aRenderable [ 
	| dock offset bottomOffset statusbarMorph |
	window := GLMSystemWindow new.
	window
		model: aRenderable;
		setLabel: (aRenderable titleValue ifNil: ['Glamorous Browser']).
	offset := 0.
	bottomOffset := 0.
	aRenderable allActions notEmpty ifTrue: [
		dock := self 
			renderToolbarForBrowser: aRenderable
			inWindow: window.
		offset := dock minExtent y.
		window 
			addMorph: dock
			fullFrame: (LayoutFrame 
					fractions: (0 @ 0 corner: 1 @ 0)
					offsets: (0 @ 0 corner: 0 @ offset)) ].
	aRenderable hasStatusbar ifTrue: [
		statusbarMorph := self renderPaneWithoutTitle: aRenderable statusbarPane.
		bottomOffset := 0 - ((LabelMorph contents: 'XXX') minHeight)*1.2.
		window 
				addMorph: statusbarMorph
				fullFrame: (LayoutFrame 
					fractions: (0 @ 1 corner: 1 @ 1)
					offsets: (2 @ bottomOffset corner: -2 @ 0)) ].
	window 
		addMorph: (self render: aRenderable)
		fullFrame: (LayoutFrame 
				fractions: (0 @ 0 corner: 1 @ 1)
				offsets: (0 @ offset corner: 0 @ bottomOffset)).
	(self theme isKindOf: UIThemeWatery) ifFalse: [
		aRenderable colorValue ifNotNil: [ window paneColor: aRenderable colorValue ] ].
	^ window
]
