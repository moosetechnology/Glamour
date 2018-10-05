Class {
	#name : #GLMTableMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #'as yet unclassified' }
GLMTableMorphicTest >> testColumnLabel [
	| browser  tableMorphOne tableMorphTwo |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [:a | 
		a table 
			display: [:x | (x - 3 to: x) ];
			column: 'Column' evaluated: [:x | x asString]].
	browser transmit to: #two; from: #one; andShow: [:a |
		a table 
			display: [:x | x * 10 to: (x * 10 + 2)];
			column: [:x | 'Number ', x asString] evaluated: #asString].
	window := browser openOn: 4.

	tableMorphOne := window submorphs last submorphs second submorphs first submorphs first.
	self assert: (tableMorphOne model roots collect: #item) = #(1 2 3 4).
	self assert: (tableMorphOne columns first header label = 'Column' ).
	((browser paneNamed: #one) port: #selection) value: 2.
	tableMorphTwo := window submorphs last submorphs last submorphs first submorphs first.
	self assert: (tableMorphTwo model roots collect: #item) = #(20 21 22).
	self assert: (tableMorphTwo columns first header label = 'Number 2' ).
]
