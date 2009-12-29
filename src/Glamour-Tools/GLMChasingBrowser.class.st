"
self openOn: #buildBrowser
"
Class {
	#name : #GLMChasingBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMChasingBrowser >> buildBrowser [
	| finder |
	finder := GLMFinder new.
	finder tree
		display: [ :each | self systemNavigation allImplementorsOf:	each ];
		format: [:each | 
			(each isKindOf: MethodReference) ifTrue: [each classSymbol, '>>', each selector ] ifFalse: [ each ]];
		children: [ :each | 
			(each isKindOf: MethodReference) ifTrue: [each compiledMethod messages] ifFalse: [OrderedCollection new]];
		whenKindOf: String.
	browser := GLMTabulator new.
	browser title: [:each | 'Chasing Browser of ', each].
	browser row: #finder; row: #details.
	browser showOn: #finder; using: [browser custom: finder].
	browser showOn: #details; from: #finder; using: [
		browser text
			forSmalltalk: [:reference | reference actualClass ];
			display: [:reference | reference sourceCode ];
			whenKindOf: MethodReference ].
	^ browser
]
