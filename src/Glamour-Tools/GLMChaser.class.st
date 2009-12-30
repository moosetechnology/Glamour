"
self openOn: #buildBrowser
"
Class {
	#name : #GLMChaser,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #building }
GLMChaser >> buildBrowser [
	| finder |
	finder := GLMFinder new.
	finder tree
		title: 'Implementors';
		display: [ :each | self systemNavigation allImplementorsOf:	each ];
		format: [:each | 
			(each isKindOf: MethodReference) ifTrue: [each classSymbol, '>>', each selector ] ifFalse: [ each ]];
		children: [ :each | 
			(each isKindOf: MethodReference) ifTrue: [each compiledMethod messages] ifFalse: [OrderedCollection new]];
		whenKindOf: String.
	finder tree
		title: 'Senders';
		display: [ :each | self systemNavigation allSendersOf:	each ];
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
