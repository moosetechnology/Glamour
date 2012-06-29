Class {
	#name : #GLMMorphicDropDownRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#instVars : [
		'tabs'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicDropDownRenderer >> render: aDropListPresentation [
	| listModel |

	listModel:= GLMDropListModel new glamourPresentation: aDropListPresentation.
	"When the morph changes, we want to update the glamour model"
	listModel announcer on: GLMDropDownListMorphSelectionChanged do: [ :ann | 	
		aDropListPresentation selection: ann selectionValue ].
	listModel selectionIndex: aDropListPresentation selectedIndex.
	^(MorphDropListMorph
			on: listModel
			list: #list
			selected: #selectionIndex
			changeSelected: #selectionIndex:
			useIndex: true )
		hResizing: #spaceFill;
		vResizing: #shrinkWrap
]
