"
self openOn: #browse
"
Class {
	#name : #GLMClassicChaser,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMClassicChaser >> buildBrowser [
	"self openOn: #buildBrowser"
	| finder |
	finder := GLMFinder new.
	finder tree
		title: 'Implementors';
		display: [ :each | 
			self systemNavigation allImplementorsOf: ((each isKindOf: MethodReference) ifTrue: [each selector ] ifFalse: [ each ]) ];
		format: [:each | 
			(each isKindOf: MethodReference) ifTrue: [each classSymbol, '>>', each selector ] ifFalse: [ each ]];
		children: [ :each | 
			(each isKindOf: MethodReference) ifTrue: [each compiledMethod messages] ifFalse: [OrderedCollection new]].
	finder tree
		title: 'Senders';
		display: [ :each | 
			self systemNavigation allSendersOf:	((each isKindOf: MethodReference) ifTrue: [each selector ] ifFalse: [ each ]) ];
		format: [:each | 
			(each isKindOf: MethodReference) ifTrue: [each classSymbol, '>>', each selector ] ifFalse: [ each ]];
		children: [ :each | 
			(each isKindOf: MethodReference) ifTrue: [each compiledMethod messages] ifFalse: [OrderedCollection new]].
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
