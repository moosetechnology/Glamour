"
self open
"
Class {
	#name : #GLMMondrianExamples,
	#superclass : #GLMExamples,
	#category : #'Glamour-Mondrian-Presentations'
}

{ #category : #others }
GLMMondrianExamples >> mondrianPainting [
	<glmBrowser: 'Mondrian painting' input: '42'>
	"self new mondrianPainting openOn: 42"
	| browser items |
	browser := GLMTabulator withStatusbar.
	items := 50.
	browser act: [:b | 
		items := 10.
		(b paneNamed: #one) presentations first update ] entitled: 'Update'.
	browser act: [:b | 
		(b paneNamed: #one) inspect ] entitled: 'Inspect'.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a |
		a mondrian 
			title: 'Numbers in Mondrian tree';
			painting: [:view :number | 
			view shape label.
			view nodes: (1 to: items ).
			view edgesFrom: [:x | x // 3 ].
			view horizontalTreeLayout ]].
	browser transmit to: #two; from: #one; andShow: [ :a |
		a mondrian 
			title: 'Numbers in Mondrian list';
			painting: [:view :number |
				view shape rectangle width: 20; text: #printString; withoutBorder.
				view nodes: (1 to: number).
				view gridLayout ]].
	^ browser
]
