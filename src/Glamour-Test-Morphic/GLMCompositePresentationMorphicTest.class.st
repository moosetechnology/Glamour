Class {
	#name : #GLMCompositePresentationMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #'as yet unclassified' }
GLMCompositePresentationMorphicTest >> testAccordion [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; showing: [ :a | 
		a accordionArrangement.
		a list title: 'List'.
		a text title: 'Text'].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph submorphs first class = ExpanderMorph.
	self assert: compositeMorph submorphs last class = ExpanderMorph.
	self assert: compositeMorph class = PanelMorph
]

{ #category : #'as yet unclassified' }
GLMCompositePresentationMorphicTest >> testAccordionExpanded [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; showing: [ :a | 
		a accordionArrangement.
		a list title: 'List'.
		a text title: 'Text'].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph submorphs first expanded
]

{ #category : #'as yet unclassified' }
GLMCompositePresentationMorphicTest >> testStackedVertically [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; showing: [ :a | 
		a stackedVerticallyArrangement.
		a list.
		a text ].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class = PanelMorph.
	self assert: compositeMorph submorphs notEmpty.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph submorphs first class = GroupboxMorph.
]

{ #category : #'as yet unclassified' }
GLMCompositePresentationMorphicTest >> testTabs [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; showing: [ :a | 
		a list.
		a text ].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class == LazyTabGroupMorph.
	self assert: compositeMorph lazyPages size = 2.
]
