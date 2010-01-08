Class {
	#name : #GLMCompositePresentationMorphicTest,
	#superclass : #TestCase,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #'as yet unclassified' }
GLMCompositePresentationMorphicTest >> testAccordion [
	| browser window compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; showing: [ :a | 
		a accordionArrangement.
		a list title: 'List'.
		a text title: 'Text'].
	window := browser openOn: 42.
	window delete.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph submorphs first class = ExpanderMorph.
	self assert: compositeMorph submorphs last class = ExpanderMorph.
	self assert: compositeMorph class = PanelMorph
]

{ #category : #'as yet unclassified' }
GLMCompositePresentationMorphicTest >> testStackedVertically [
	| browser window compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; showing: [ :a | 
		a stackedVerticallyArrangement.
		a list.
		a text ].
	window := browser openOn: 42.
	window delete.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class == PanelMorph.
	self assert: compositeMorph submorphs first class == GroupboxMorph.
]

{ #category : #'as yet unclassified' }
GLMCompositePresentationMorphicTest >> testTabs [
	| browser window compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; showing: [ :a | 
		a list.
		a text ].
	window := browser openOn: 42.
	window delete.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class == LazyTabGroupMorph.
]
