Class {
	#name : #GLMMorphicListingRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMMorphicListingRenderer >> render: aPresentation [
	| treeModel container treeMorph textInput |
	treeModel := GLMTreeMorphModel new glamourPresentation: aPresentation.
	container := GLMMorphic emptyMorph.
	treeMorph := renderer treeMorphFor: treeModel and: aPresentation.
	aPresentation allowsInput ifTrue: [
		textInput := renderer textInputFor: treeModel.
		treeMorph layoutFrame bottomOffset: -24.
		container addMorphBack: textInput ].
	container addMorphBack: treeMorph.
	renderer installActionsOnUI: treeModel fromPresentation: aPresentation.

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
