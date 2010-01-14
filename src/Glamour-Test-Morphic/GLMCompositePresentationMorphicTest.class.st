Class {
	#name : #GLMCompositePresentationMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #testing }
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

{ #category : #testing }
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

{ #category : #testing }
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
	self assert: compositeMorph class = GroupboxMorph.
	self assert: compositeMorph submorphs size = 1.
	self assert: compositeMorph submorphs first class = PanelMorph.
	self assert: compositeMorph submorphs first submorphs size = 2.
	self assert: compositeMorph submorphs first submorphs first class = GroupboxMorph.
]

{ #category : #testing }
GLMCompositePresentationMorphicTest >> testStackedVerticallyWithTitle [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; showing: [ :a | 
		a stackedVerticallyArrangement.
		a title: 'title'.
		a list.
		a text ].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class = GroupboxMorph.
	self assert: compositeMorph submorphs notEmpty.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph submorphs first class = PanelMorph.
	self assert: compositeMorph submorphs first submorphs size = 2.
	self assert: compositeMorph submorphs first submorphs first class = GroupboxMorph
]

{ #category : #testing }
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
