Class {
	#name : #GLMCompositePresentationMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMCompositePresentationMorphicTest >> testAccordion [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a accordionArrangement.
		a list title: 'List'.
		a text title: 'Text'].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class = PanelMorph.
	self assert: compositeMorph submorphs notEmpty.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph submorphs first class = ExpanderMorph.
	self assert: compositeMorph submorphs last class = ExpanderMorph.
]

{ #category : #tests }
GLMCompositePresentationMorphicTest >> testAccordionExpanded [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a accordionArrangement.
		a list title: 'List'.
		a text title: 'Text'].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph submorphs first expanded.
	self assert: compositeMorph submorphs last expanded not.
]

{ #category : #tests }
GLMCompositePresentationMorphicTest >> testAccordionWithTitle [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a accordionArrangement.
		a title: 'title'.
		a list.
		a text ].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class = LazyTabGroupMorph.
	self assert: compositeMorph submorphs notEmpty.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph contentMorph class = PanelMorph.
	self assert: compositeMorph contentMorph submorphs first submorphs size = 2.
	self assert: compositeMorph contentMorph submorphs first submorphs first class = ExpanderMorph
]

{ #category : #tests }
GLMCompositePresentationMorphicTest >> testFinder [
	| finder |
	finder := GLMFinder new.
	finder show: [:a |
		a title: 'something'.
		a stackedArrangement.
		a list.
		a text].
	self assert: finder presentations size = 2.
	self assert: (finder presentations arrangement isKindOf: GLMStackedVerticallyArrangement).
	window := finder openOn: (1 to: 42).
	self assert: (window submorphs last submorphs first submorphs first submorphs first isKindOf: LazyTabGroupMorph) 
]

{ #category : #tests }
GLMCompositePresentationMorphicTest >> testOneStackedVerticallyWithTitle [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a stackedVerticallyArrangement.
		a title: 'title'.
		a list ].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class = LazyTabGroupMorph.
	self assert: compositeMorph submorphs notEmpty.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph contentMorph class = PanelMorph.
	self assert: compositeMorph contentMorph submorphs size = 1.
	self assert: compositeMorph contentMorph submorphs first class = PanelMorph.
	self assert: compositeMorph contentMorph submorphs first submorphs size = 1.
	self assert: compositeMorph contentMorph submorphs first submorphs first class = LazyTabGroupMorph
]

{ #category : #tests }
GLMCompositePresentationMorphicTest >> testStackedVertically [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a stackedVerticallyArrangement.
		a list title: 'list'.
		a text title: 'text'].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class = PanelMorph.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph submorphs first class = LazyTabGroupMorph.
]

{ #category : #tests }
GLMCompositePresentationMorphicTest >> testStackedVerticallyWithTitle [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a stackedVerticallyArrangement.
		a title: 'title'.
		a list title: 'list'.
		a text title: 'text'].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class = LazyTabGroupMorph.
	self assert: compositeMorph submorphs notEmpty.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph contentMorph class = PanelMorph.
	self assert: compositeMorph contentMorph submorphs size = 1.
	self assert: compositeMorph contentMorph submorphs first class = PanelMorph.
	self assert: compositeMorph contentMorph submorphs first submorphs size = 2.
	self assert: compositeMorph contentMorph submorphs first submorphs first class = LazyTabGroupMorph
]

{ #category : #tests }
GLMCompositePresentationMorphicTest >> testTabs [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a list.
		a text ].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class = LazyTabGroupMorph.
	self assert: compositeMorph pages size = 2.
]

{ #category : #tests }
GLMCompositePresentationMorphicTest >> testTabsWithTitle [
	| browser compositeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a title: 'title'.
		a list.
		a text ].
	window := browser openOn: 42.
	compositeMorph := window submorphs last submorphs last submorphs last.
	self assert: compositeMorph class = LazyTabGroupMorph.
	self assert: compositeMorph submorphs size = 2.
	self assert: compositeMorph submorphs first class = PanelMorph.
	self assert: compositeMorph submorphs first submorphs size = 1.
	self assert: compositeMorph submorphs first submorphs first class = LazyTabGroupMorph.
	self assert: compositeMorph submorphs first submorphs first pages size = 2.
]
