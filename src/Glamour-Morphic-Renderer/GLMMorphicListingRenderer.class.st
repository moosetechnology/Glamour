Class {
	#name : #GLMMorphicListingRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicListingRenderer >> render: aPresentation [
	| treeModel container treeMorph textInput |
	treeModel := GLMTreeMorphModel new glamourPresentation: aPresentation.
	container := GLMMorphic emptyMorph.
	treeMorph := self treeMorphFor: treeModel and: aPresentation.
	aPresentation allowsInput ifTrue: [
		textInput := self textInputFor: treeModel.
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
	aPresentation when: GLMContextChanged do: [ :ann | 
			ann property = #selection ifTrue: [ 
				treeModel announcer suspendAllWhile: [
					treeMorph model explicitSelection: ann value ] ] ].
	aPresentation when: GLMPresentationUpdated do: [ :ann |
		treeMorph model updateRoots ].

	^ container
]

{ #category : #private }
GLMMorphicListingRenderer >> textInputFor: treeModel [
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

{ #category : #private }
GLMMorphicListingRenderer >> treeMorphFor: treeModel and: aPresentation [
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
					font: StandardFonts menuFont 
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
