Class {
	#name : #GLMTableMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMTableMorphicTest >> testColumnBlockTakesEntity [

	| browser receivedEntity |
	browser := GLMFinder new.
	receivedEntity := nil.
	browser table
		column: 'Even' evaluated: [:each :entity | receivedEntity := entity. 'x'].
	window := browser openOn: (1 to: 5).
	World doOneCycle.
	self repeatAssert: [receivedEntity] equals: (1 to: 5).

]

{ #category : #tests }
GLMTableMorphicTest >> testColumnLabel [
	| browser tableMorphOne tableMorphTwo |
	browser := GLMTabulator new.
	browser
		column: #one;
		column: #two.
	(browser transmit)
		to: #one;
		andShow: [ :a | 
					(a table)
						display: [ :x | x - 3 to: x ];
						column: 'Column' evaluated: [ :x | x asString ] ].
	(browser transmit)
		to: #two;
		from: #one;
		andShow: [ :a | 
					(a table)
						display: [ :x | x * 10 to: x * 10 + 2 ];
						column: [ :x | 'Number ' , x asString ] evaluated: #asString ].
	window := browser openOn: 4.
	tableMorphOne := window submorphs last submorphs second submorphs first submorphs first.
	self assert: (tableMorphOne model roots collect: #item) equals: #(1 2 3 4).
	self assert: tableMorphOne columns first header label equals: 'Column'.
	((browser paneNamed: #one) port: #selection) value: 2.
	tableMorphTwo := window submorphs last submorphs last submorphs first submorphs first.
	self assert: (tableMorphTwo model roots collect: #item) equals: #(20 21 22).
	self assert: tableMorphTwo columns first header label equals: 'Number 2'
]
