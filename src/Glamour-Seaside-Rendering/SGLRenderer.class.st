Class {
	#name : #SGLRenderer,
	#superclass : #Object,
	#instVars : [
		'component',
		'html',
		'uuid',
		'scripts'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'instance-creation' }
SGLRenderer class >> in: aComponent on: aCanvas [
	^ self basicNew initializeIn: aComponent on: aCanvas
]

{ #category : #accessing }
SGLRenderer >> html [
	^ html
]

{ #category : #accessing }
SGLRenderer >> html: aCanvas [
	html := aCanvas
]

{ #category : #initialization }
SGLRenderer >> initialize [
	super initialize.
	uuid := IdentityDictionary new.
	scripts := GRSmallDictionary new
]

{ #category : #initialization }
SGLRenderer >> initializeIn: aComponent on: aCanvas [
	self initialize.
	component := aComponent.
	html := aCanvas
]

{ #category : #rendering }
SGLRenderer >> render: aRenderable [
	aRenderable renderGlamorouslyOn: self
]

{ #category : #rendering }
SGLRenderer >> render: aRenderable on: aCanvas [
	html := aCanvas.
	aRenderable renderGlamorouslyOn: self
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderAccordionCompositePresentation: aCompositePresentation [
	html render: (SGLAccordionCompositePresenter for: aCompositePresentation from: self)
]

{ #category : #'rendering browsers' }
SGLRenderer >> renderAccumulator: aBrowser [
	html render: (SGLAccumulatorPresenter for: aBrowser from: self)
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderActionListPresentation: anActionListPresentation [ 
	self flag: 'To implement'.
	self renderEmptyPresentation 
]

{ #category : #'rendering browsers' }
SGLRenderer >> renderDashboard: aBrowser [
	html render: (SGLDashboardPresenter for: aBrowser from: self)

]

{ #category : #rendering }
SGLRenderer >> renderDynamicPresentation: aPresentation [
	html render: (SGLDynamicPresenter for: aPresentation from: self)
]

{ #category : #rendering }
SGLRenderer >> renderEmptyPresentation [
	self flag: 'to delete'.
	html div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all';
		class: 'glm-empty-presentation'
]

{ #category : #'rendering browsers' }
SGLRenderer >> renderExpander: aBrowser [
	html render: (SGLExpanderPresenter for: aBrowser from: self)
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderEyeSeePresentation: aPresentation [
	html render: (SGLEyeSeePresenter for: aPresentation from: self)
]

{ #category : #'rendering browsers' }
SGLRenderer >> renderFinder: aBrowser [
	html render: (SGLFinderPresenter for: aBrowser from: self)
	
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderLabelPresentation: aLabelPresentation [ 
	self flag: 'To implement'.
	self renderEmptyPresentation
	
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderListPresentation: aPresentation [
	| listPresenter |
	listPresenter := (SGLTreePresenter for: aPresentation from: self).
	listPresenter htmlId: (self uuidFor: aPresentation).
	html render: listPresenter
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderMagrittePresentation: aPresentation [
	| form |
	form := aPresentation displayValue asComponent
		addValidatedForm;
		onAnswer: [ :answer | aPresentation selection: answer ].
	html div
		class: 'magritte';
		with: form
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderMondrianPresentation: aPresentation [
	html render: (SGLMondrianPresenter for: aPresentation from: self)

	
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderMorphPresentation: aMorphPresentation [ 
	self flag: 'To implement'.
	self renderEmptyPresentation.
]

{ #category : #rendering }
SGLRenderer >> renderPane: aPane [
	html render: (SGLPanePresenter for: aPane from: self)
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderStackedVerticallyCompositePresentation: aCompositePresentation [
	html render: (SGLStackedVerticallyCompositePresenter for: aCompositePresentation from: self)
]

{ #category : #'rendering browsers' }
SGLRenderer >> renderStacker: aBrowser [ 
	html render: (SGLStackerPresenter for: aBrowser from: self)
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderTabbedCompositePresentation: aCompositePresentation [
	html render: (SGLTabbedCompositePresenter for: aCompositePresentation from: self)
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderTablePresentation: aPresentation [
	self flag: 'To implement'.
	self renderEmptyPresentation.

]

{ #category : #'rendering browsers' }
SGLRenderer >> renderTabulator: aBrowser [
	html render: (SGLTabulatorPresenter for: aBrowser from: self)

]

{ #category : #'rendering presentations' }
SGLRenderer >> renderTextPresentation: aTextPresentation [
	| textPresenter |
	textPresenter := (SGLTextPresenter for: aTextPresentation from: self).
	textPresenter htmlId: (self uuidFor: aTextPresentation).
	html render: textPresenter
	
	
]

{ #category : #'rendering presentations' }
SGLRenderer >> renderTreePresentation: aPresentation [
	| treePresenter |
	treePresenter := (SGLTreePresenter for: aPresentation from: self).
	treePresenter htmlId: (self uuidFor: aPresentation).
	treePresenter model shouldRootsExpand: aPresentation shouldRootsExpand.
	treePresenter model shouldAllExpand: aPresentation shouldAllExpand.
	html render: treePresenter
]

{ #category : #'rendering browsers' }
SGLRenderer >> renderValidator: aBrowser [
	html render: (SGLValidatorPresenter for: aBrowser from: self)

]

{ #category : #'rendering browsers' }
SGLRenderer >> renderWizard: aBrowser [
	html render: (SGLWizardPresenter for: aBrowser from: self)

]

{ #category : #'rendering presentations' }
SGLRenderer >> renderWorkspacePresentation: aWorkspacePresentation [
	self renderTextPresentation: aWorkspacePresentation
]

{ #category : #script }
SGLRenderer >> scriptFor: anObject add: aScript [
	(scripts at: (self uuidFor: anObject) ifAbsentPut: [ JSScript new ]) , aScript
]

{ #category : #script }
SGLRenderer >> scriptFor: anObject put: aScript [
	scripts at: (self uuidFor: anObject) put: aScript
]

{ #category : #script }
SGLRenderer >> updateScript: aScript [
	aScript addAll: scripts values.
	"aScript add: (JSStream on: 'Glamour.resize()')."
	scripts := GRSmallDictionary new
]

{ #category : #script }
SGLRenderer >> uuidFor: anObject [
	^ uuid at: anObject ifAbsentPut: [ html nextId ]
]
