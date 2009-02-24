Class {
	#name : #GLTableLayoutTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLTableLayoutTest >> testComplex [
	
	| layout |
	layout := GLTableLayoutBrowser new.
	layout
		addColumn:
			[:column | 
			column addRow: #second.
			column addRow: #third.
			column addRow: #fourth.
			column
				addRow:
					[:row | 
					row addColumn: #fifth.
					row addColumn: #sixth]].
	layout addColumn: #first.
	self assert: layout cell children size = 2.
	self assert: layout cell children first children size = 4.
	self assert: layout cell children first children last children size = 2
]

{ #category : #tests }
GLTableLayoutTest >> testOneSimpleColumnAndOneNested [
	
	| layout |
	layout := GLTableLayoutBrowser new.
	layout
		addColumn:
			[:column | 
			column addRow: #second.
			column addRow: #third.
			column addRow: #fourth].
	layout addColumn: #first.
	self assert: layout cell children size = 2.
	self assert: layout cell children first children size = 3
]

{ #category : #tests }
GLTableLayoutTest >> testOneSimpleRowAndOneNested [
	
	| layout |
	layout := GLTableLayoutBrowser new.
	layout addRow: #first.
	layout
		addRow:
			[:row | 
			row addColumn: #second.
			row addColumn: #third.
			row addColumn: #fourth].
	self assert: layout cell children size = 2.
	self assert: layout cell children last children size = 3
]

{ #category : #tests }
GLTableLayoutTest >> testSimpleColumns [
	
	| layout |
	layout := GLTableLayoutBrowser new.
	layout addColumn: #first.
	layout addColumn: #second.
	self assert: layout cell children size = 2
]

{ #category : #tests }
GLTableLayoutTest >> testSimpleRows [
	
	| layout |
	layout := GLTableLayoutBrowser new.
	layout addRow: #first.
	layout addRow: #second.
	self assert: layout cell children size = 2.
	self assert: layout cell isColumn.
	self assert: layout cell children first isRow
]
