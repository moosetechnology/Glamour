Class {
	#name : #GLMMorphicListingRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'treeMorph',
		'treeModel'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicListingRenderer >> actOnContextChanged: anAnnouncement [ 
	anAnnouncement property = #selection ifTrue: [ 
		treeModel announcer suspendAllWhile: [
			treeMorph model explicitSelection: anAnnouncement value ] ] 
]

{ #category : #rendering }
GLMMorphicListingRenderer >> actOnUpdatedPresentation: anAnnouncement [
	treeMorph model updateRoots
]

{ #category : #rendering }
GLMMorphicListingRenderer >> render: aPresentation [
	| container textInput |
	treeModel := GLMTreeMorphModel new glamourPresentation: aPresentation.
	container := GLMMorphic containerMorph.
	treeMorph := self treeMorphFor: treeModel and: aPresentation.
	aPresentation allowsInput ifTrue: [
		textInput := self textInputFor: treeModel withHelpMessage: aPresentation helpMessage.
		treeMorph layoutFrame bottomOffset: -24.
		container addMorphBack: textInput ].
	container addMorphBack: treeMorph.
	self installActionsOnUI: treeModel fromPresentation: aPresentation.

	"When the morph changes, we want to update the glamour model"
	treeModel announcer on: GLMTreeMorphSelectionChanged do: [ :ann | 
		aPresentation announcer suspendAllWhile: [
			aPresentation selection: ann selectionValue.
			aPresentation selectionPath: ann selectionPathValue] ].
	treeModel announcer on: GLMTreeMorphStrongSelectionChanged do: [ :ann | 
		aPresentation strongSelection: ann strongSelectionValue ].
	
	"When the glamour model changes, we want to update the morph"
	aPresentation on: GLMContextChanged send: #actOnContextChanged: to: self.
	aPresentation on: GLMPresentationUpdated send: #actOnUpdatedPresentation: to: self.

	^ container
]

{ #category : #private }
GLMMorphicListingRenderer >> textInputFor:  aTreeModel withHelpMessage: helpStringMessage [
	| textInput |
	textInput := self theme 
			newTextEntryIn: nil
			for: aTreeModel
			get: #inputText
			set: #inputText:
			class: String
			getEnabled: #inputTextEnabled
			help: helpStringMessage.
	textInput askBeforeDiscardingEdits: false.
	textInput layoutFrame: (LayoutFrame 
				fractions: (0 @ 1 corner: 1 @ 1)
				offsets: (0 @ -24 corner: 0 @ 0)).
	^ textInput
]

{ #category : #private }
GLMMorphicListingRenderer >> treeMorphFor: tmpTreeModel and: aPresentation [
	| tmpTreeMorph columns |
	tmpTreeMorph := MorphTreeMorph new.
	tmpTreeMorph
		makeLastColumnUnbounded;
		doubleClickSelector: #onDoubleClick;
		getMenuSelector: #menu:shifted:;
		keystrokeActionSelector: #keyStroke:from:;
		cornerStyle: tmpTreeMorph preferredCornerStyle;
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
					font: StandardFonts menuFont 
					target: nil 
					actionSelector: nil 
					arguments: #(); 
					yourself ].
		].
	tmpTreeMorph
		preferedPaneColor: Color white;	
		model: tmpTreeModel;
		nodeListSelector: #roots;
		columns: columns.
	aPresentation isMultiple 
		ifTrue: [tmpTreeMorph beMultiple] 
		ifFalse: [tmpTreeMorph beSingle].
	tmpTreeModel chunkSize: aPresentation amountToShow.
	tmpTreeMorph vShowScrollBar.
	^ tmpTreeMorph buildContents
]
