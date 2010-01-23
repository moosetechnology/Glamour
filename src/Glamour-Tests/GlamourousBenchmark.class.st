Class {
	#name : #GlamourousBenchmark,
	#superclass : #Object,
	#instVars : [
		'progressBarSize',
		'progress'
	],
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GlamourousBenchmark >> defaultBrowser [ 
	| browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.

	browser showOn: #one; using: [
		browser list
			display: [:x | 1 to: x * 3] ].
	browser showOn: #two; from: #one; using: [
		browser list
			display: [:x | 1 to: x * 3] ].
	browser showOn: #one; from: #two; using: [
		browser list
			display: [:x | 1 to: x * 3] ].

	^ browser
]

{ #category : #'as yet unclassified' }
GlamourousBenchmark >> defaultFinderBrowser [ 
	"
	self new defaultFinderBrowser openOn: 10
	"
	| finder |
	finder := GLMFinder new.
	finder list
		title: 'title';
		display: [:each | 1 to: each ];
		showOnly: 50.

	^ finder
]

{ #category : #'as yet unclassified' }
GlamourousBenchmark >> measureOpeningTime [
	| browser numberOfOpenings time |
	numberOfOpenings := 15.

	browser := self defaultBrowser.
	time := Time millisecondsToRun: [ numberOfOpenings timesRepeat: [(browser openOn: 10) delete] ].
	^ {numberOfOpenings . time}
]

{ #category : #'as yet unclassified' }
GlamourousBenchmark >> measureSelectionTime [
	"
	self new measureSelectionTime 
	"
	^ self measureSelectionTimeForSize: 1000
]

{ #category : #'as yet unclassified' }
GlamourousBenchmark >> measureSelectionTimeForSize: size [
	"
	self new measureSelectionTime 
	"
	| browser numberOfSelections time port window |
	numberOfSelections := 15.

	browser := self defaultBrowser.
	window := browser openOn: size.
	port := browser panes first ports second.
	time := Time millisecondsToRun: [ (size - numberOfSelections) to: size do: [:i | port value: i ] ].
	window delete.
	^ {size . time}
]

{ #category : #'as yet unclassified' }
GlamourousBenchmark >> measureSelectionTimeInFinderForSize: size [
	"
	self new measureSelectionTimeInFinderForSize: 20 
	"
	| browser numberOfSelections time port window |

	browser := self defaultFinderBrowser.
	window := browser openOn: size.
	
	time := Time millisecondsToRun: 
			[size timesRepeat: [ (window model panes last port: #selection) value: size].].
		
	window delete.
	^ {size . time}
]

{ #category : #'as yet unclassified' }
GlamourousBenchmark >> showOnlyBrowser [ 
	| browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.

	browser showOn: #one; using: [
		browser list
			display: [:x | 1 to: x * 3];
			showOnly: 50].
	browser showOn: #two; from: #one; using: [
		browser list
			display: [:x | 1 to: x * 3];
			showOnly: 50].
	browser showOn: #one; from: #two; using: [
		browser list
			display: [:x | 1 to: x * 3];
			showOnly: 50].

	^ browser
]

{ #category : #'as yet unclassified' }
GlamourousBenchmark >> showOnlyFinderBrowser [ 
	"
	self new showOnlyFinderBrowser openOn: 10
	"
	| finder |
	finder := GLMFinder new.
	finder list
		title: 'title';
		display: [:each | 1 to: each ];
		showOnly: 50.

	^ finder
]
