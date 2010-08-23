"
This is a helper class that is supposed to be subclassed for each rendering logic of a specific morph. For example, there will be a TreeRenderer, a TextRenderer etc
"
Class {
	#name : #GLMMorphicWidgetRenderer,
	#superclass : #Object,
	#instVars : [
		'renderer'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMorphicWidgetRenderer class >> render: aPresentation from: aRenderer [
	^ self new 
		renderer: aRenderer;
		render: aPresentation
]

{ #category : #private }
GLMMorphicWidgetRenderer >> amountFilteringButtonFor: treeModel [
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
GLMMorphicWidgetRenderer >> installActionsOnUI: aMorphicModel fromPresentation: aPresentation [	 
	aMorphicModel when: GLMMenuItemSelected do: [ :ann | ann action actOn: aPresentation ].
	aMorphicModel when: GLMKeyStroke do: [ :ann | ann action actOn: aPresentation ].
]

{ #category : #private }
GLMMorphicWidgetRenderer >> menuIn: aMenuMorph for: aPresentation [
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
GLMMorphicWidgetRenderer >> mondrianCanvasFor: aPresentation in: aScrollPane [ 
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
GLMMorphicWidgetRenderer >> moreToolbarActions: noIconActions on: aBrowser [
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
GLMMorphicWidgetRenderer >> morph: aMorph withTitleOf: aPresentation [
	| container |
	container := self theme 
		newGroupboxIn: GLMMorphic emptyMorph 
		label: (self titleOrIconOf: aPresentation in: GLMMorphic emptyMorph).
	container addContentMorph: aMorph.
	^ container
]

{ #category : #private }
GLMMorphicWidgetRenderer >> morph: aMorph withTitleOrNilOf: aPresentation [
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

{ #category : #rendering }
GLMMorphicWidgetRenderer >> render: aPresentation [
	^ self subclassResponsibility 
]

{ #category : #x }
GLMMorphicWidgetRenderer >> renderObject: anObject [
	^ renderer render: anObject 
]

{ #category : #rendering }
GLMMorphicWidgetRenderer >> renderPaneWithoutTitle: aPane [ 
	| container |
	container := GLMMorphic emptyMorph.
	aPane when: GLMMatchingPresentationsChanged do: [ :ann | 
		container
			removeAllMorphs;
			addMorph: (self renderObject: aPane presentations)
			fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			adoptPaneColor: container paneColor.
		renderer window fullBounds.
		renderer window refreshHorizontalScollbars ].
	container
		addMorph: (self renderObject: aPane presentations)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		adoptPaneColor: container paneColor.
	^ container
]

{ #category : #private }
GLMMorphicWidgetRenderer >> renderToolbarForBrowser: aBrowser inWindow: aWin [
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

{ #category : #private }
GLMMorphicWidgetRenderer >> renderWithTitle: aPresentation [
	| morph |
	morph := self renderObject: aPresentation.
	^ self morph: morph withTitleOf: aPresentation
]

{ #category : #private }
GLMMorphicWidgetRenderer >> renderWithTitleOrNil: aPresentation [
	| morph |
	morph := self renderObject: aPresentation.
	^ self morph: morph withTitleOrNilOf: aPresentation
]

{ #category : #accessing }
GLMMorphicWidgetRenderer >> renderer [
	^ renderer
]

{ #category : #accessing }
GLMMorphicWidgetRenderer >> renderer: anObject [
	renderer := anObject
]

{ #category : #private }
GLMMorphicWidgetRenderer >> textInputFor: treeModel [
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
GLMMorphicWidgetRenderer >> theme [
	^ UITheme current
]

{ #category : #private }
GLMMorphicWidgetRenderer >> titleOrIconOf: aPresentation in: container [
	^ aPresentation hasTitleIcon 
		ifTrue: [
			self theme 
					newImageIn: container
					form: aPresentation titleIconValue ]
		ifFalse: [ aPresentation titleValue ifNil: [''] ].
]

{ #category : #private }
GLMMorphicWidgetRenderer >> titleOrIconOrNilOf: aPresentation in: container [
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
GLMMorphicWidgetRenderer >> treeMorphFor: treeModel and: aPresentation [
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
