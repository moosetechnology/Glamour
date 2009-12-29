"
self openOn: Collection withAllSubclasses
"
Class {
	#name : #GLMDiffer,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMDiffer >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Glamorous Diff Browser'.
	browser
		row: [:r | r column: #left; column: #right ];
		row: #diff.
	browser showOn: #left; using: [browser custom: GLMSimpleClassesBrowser new browser ].
	browser showOn: #right; using: [browser custom: GLMSimpleClassesBrowser new browser ].
	browser showOn: #diff; 
		from: #left->#selectedClass; from: #left->#selectedMethod;
		from: #right->#selectedClass; from: #right->#selectedMethod;
		using: [
		browser diff
			display: [:leftClass :leftMethod :rightClass :rightMethod | 
				Array with: (leftClass sourceCodeAt: leftMethod) with: (rightClass sourceCodeAt: rightMethod)
			]
		].
	^ browser
]
