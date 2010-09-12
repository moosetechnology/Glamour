"
This is a helper class that is supposed to be subclassed for each rendering logic of a specific morph. For example, there will be a TreeRenderer, a TextRenderer etc
"
Class {
	#name : #GLMMorphicWidgetRenderer,
	#superclass : #Object,
	#instVars : [
		'renderer'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'instance creation' }
GLMMorphicWidgetRenderer class >> render: aPresentation from: aRenderer [
	^ self new 
		renderer: aRenderer;
		render: aPresentation
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
	| tabs |
	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (self theme tabGroupCornerStyleIn: nil);
		font: self theme labelFont.
	tabs 
			addLazyPage: [aMorph]
			label: (self titleOrIconOf: aPresentation in: tabs).
	tabs selectedPageIndex: 1.
	^ tabs
]

{ #category : #private }
GLMMorphicWidgetRenderer >> morph: aMorph withTitleOrNilOf: aPresentation [
	(aPresentation hasTitle or: [aPresentation hasTitleIcon]) ifFalse: [^ aMorph ].
	^ self morph: aMorph withTitleOf: aPresentation
]

{ #category : #rendering }
GLMMorphicWidgetRenderer >> render: aPresentation [
	^ self subclassResponsibility 
]

{ #category : #private }
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
		(aWin
			newButtonFor: each
			getState: nil
			action: #actOn:
			arguments: {aBrowser}
			getEnabled: nil
			labelForm: each icon
			help: each title)
			valueOfProperty: #noBorder ifAbsentPut: [true];
			valueOfProperty: #noFill ifAbsentPut: [true];
			yourself ].
	noIconActions := aBrowser allActions select: [:each | each hasTitle and: [each hasIcon not]].
	tools := aWin newToolbar: buttons.
	noIconActions isEmpty ifFalse: [ 
		dock 
			add: '...' translated
			font: aWin theme menuBarFont
			icon: nil
			help: 'Browser actions' translated
			subMenu: (self menuIn: MenuMorph new for: aBrowser).
		buttons isEmpty ifFalse: [dock addMorphBack: tools] ]
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
