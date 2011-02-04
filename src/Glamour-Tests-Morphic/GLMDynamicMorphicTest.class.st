Class {
	#name : #GLMDynamicMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMDynamicMorphicTest >> testSurroundingPanel [
	| browser dynamicContainerMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | a dynamic presentation: [:some :object | some text ]].
	window := browser openOn: 4.

	dynamicContainerMorph := window submorphs last submorphs first submorphs first.
	self assert: (dynamicContainerMorph isKindOf: PanelMorph).
	self assert: (dynamicContainerMorph submorphs first isKindOf: PluggableTextMorph)
]

{ #category : #tests }
GLMDynamicMorphicTest >> testUpdate [
	| browser dynamicContainerMorph presentationObject |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a dynamic presentation: [:some :object | 
			some custom: presentationObject ]].
	presentationObject := GLMTextPresentation new.
	window := browser openOn: 42.
	dynamicContainerMorph := window submorphs last submorphs first submorphs first.
	self assert: (dynamicContainerMorph isKindOf: PanelMorph).
	self assert: (dynamicContainerMorph submorphs first isKindOf: PluggableTextMorph).
	presentationObject := GLMListPresentation new.
	browser update.
	dynamicContainerMorph := window submorphs last submorphs first submorphs first.
	self assert: (dynamicContainerMorph isKindOf: PanelMorph).
	self assert: (dynamicContainerMorph submorphs first submorphs first isKindOf: LazyMorphTreeMorph)
]
