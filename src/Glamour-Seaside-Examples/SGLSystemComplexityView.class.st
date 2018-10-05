Class {
	#name : #SGLSystemComplexityView,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLSystemComplexityView class >> initialize [
	self registerAsApplication: 'glamour/development/roassal/systemComplexity'
]

{ #category : #accessing }
SGLSystemComplexityView >> browser [
	"self new browser openOn: self new model"	
	| browser |
	browser := GLMTabulator new.
	browser row: #main.

	#RTMondrian asClassIfPresent: [ :viewClass |
		browser transmit to: #main; andShow: [ :a |
			a roassal2 
				initializeView: [ viewClass new ];
				painting: [ :view :classes |
					view shape rectangle
						width: #numberOfVariables;
						height: #numberOfMethods.
					view nodes: classes.
					view edges connectToAll: #subclasses.
					view normalizer normalizeColor: #numberOfLinesOfCode using: (Array with: Color green with: Color red) using: #ln.
					view layout tree.
					view build.
					view ]  ] ].
		
	^browser

]

{ #category : #accessing }
SGLSystemComplexityView >> model [

	^ RTObject  withAllSubclasses.
]
