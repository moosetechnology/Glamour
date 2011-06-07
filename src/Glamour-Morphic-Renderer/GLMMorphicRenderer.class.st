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
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #opening }
GLMMorphicRenderer >> open: aRenderable [
	window := GLMMorphicWindowRenderer render: aRenderable from: self.
	^ window openInWorld
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderAccordionCompositePresentation: aCompositePresentation [
	^ GLMMorphicAccordionRenderer render: aCompositePresentation from: self
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderAccumulator: aBrowser [ 
	^ GLMMorphicAccumulatorRenderer render: aBrowser from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderActionListPresentation: anActionListPresentation [ 
	| container buttonModel button |
	container := GLMMorphic containerMorph.
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

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderDashboard: aBrowser [ 
	^ GLMMorphicDashboardRenderer render: aBrowser from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderDiffPresentation: aPresentation [
	^ GLMMorphicDiffRenderer render: aPresentation from: self
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

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderDynamicPresentation: aPresentation [
	^ GLMMorphicDynamicRenderer render: aPresentation from: self
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderExpander: aBrowser [ 
	^ GLMMorphicExpanderRenderer render: aBrowser from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderEyeSeePresentation: aPresentation [
	^ GLMMorphicEyeSeeRenderer render: aPresentation from: self
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderFinder: aBrowser [ 
	^ aBrowser hasFixedSizePanes 
		ifTrue: [GLMMorphicFixedPanesFinderRenderer render: aBrowser from: self]
		ifFalse: [GLMMorphicVariablePanesFinderRenderer render: aBrowser from: self]
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderInputPresentation: aPresentation [ 
	
	| morph |
	self flag: 'hook the cuis editor'.
	morph := GLMMorphic containerMorph.
	^ morph
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderLabelPresentation: aLabelPresentation [ 
	| morph | 
	morph := (LabelMorph contents: aLabelPresentation formatedDisplayValue) 
			layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			font: StandardFonts haloFont;
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
	^ GLMMorphicMagritteRenderer render: aMagrittePresentation from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderMondrianPresentation: aPresentation [
	^ GLMMorphicMondrianRenderer render: aPresentation from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderMorphPresentation: aMorphPresentation [ 
	^ aMorphPresentation displayValue vResizing: #spaceFill; hResizing: #spaceFill
]

{ #category : #rendering }
GLMMorphicRenderer >> renderPane: aPane [ 
	^ GLMMorphicPaneRenderer render: aPane from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderStackedVerticallyCompositePresentation: aCompositePresentation [
	^ GLMMorphicVerticallyStackedRenderer render: aCompositePresentation from: self
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderStacker: aBrowser [ 
	^ GLMMorphicStackerRenderer render: aBrowser from: self
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
	^ GLMMorphicTabulatorRenderer render: aBrowser from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTextPresentation: aTextPresentation [ 
	^ GLMMorphicTextRenderer render: aTextPresentation from: self
]

{ #category : #'rendering presentations' }
GLMMorphicRenderer >> renderTreePresentation: aPresentation [ 
	^ GLMMorphicTreeRenderer render: aPresentation from: self
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderValidator: aBrowser [ 

	| tmpValidatorRenderer |
	tmpValidatorRenderer :=  GLMMorphicValidatorRenderer new.
	aBrowser  setSpecificAnnouncementActionsTo: tmpValidatorRenderer.  
	^ tmpValidatorRenderer render: aBrowser from: self
]

{ #category : #'rendering browsers' }
GLMMorphicRenderer >> renderWizard: aGLMWizard [

	|tmpRenderer|
	tmpRenderer :=  GLMMorphicWizardRenderer new.
	aGLMWizard  setSpecificAnnouncementActionsTo: tmpRenderer.  
	^ (tmpRenderer renderer: self) render: aGLMWizard
]

{ #category : #accessing }
GLMMorphicRenderer >> window [
	^ window
]

{ #category : #accessing }
GLMMorphicRenderer >> window: anObject [
	window := anObject
]
