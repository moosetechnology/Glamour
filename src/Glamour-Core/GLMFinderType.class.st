Class {
	#name : #GLMFinderType,
	#superclass : #GLMBrowserType,
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMFinderType >> addPanelFor: aContext in: container [

	| component |
	component := aContext asDisplayObject.
	container addMorph: component.
	aContext onSelectionChange: [:selectionChanged |
		self halt.
		"container remmoveAllChildrenAfter: component"
		self addPanelFor: (aContext copy entity: selectionChanged context selectedItem) in: container.
	]
]

{ #category : #'as yet unclassified' }
GLMFinderType >> glamorousValue: aContext [

	| container |
	container := self newContainer.
	self addPanelFor: aContext copy in: container.
	^ container
]

{ #category : #'as yet unclassified' }
GLMFinderType >> newContainer [

	^ RectangleMorph new
]
