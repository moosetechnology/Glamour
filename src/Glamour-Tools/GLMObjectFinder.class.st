"
self openOn: Smalltalk
"
Class {
	#name : #GLMObjectFinder,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMObjectFinder >> buildBrowser [
	browser := GLMFinder new.
	browser list
		title: [ :anObject | self printObjectAsAnItem: anObject ];
		display: 
			[ :anObject | 
			anObject class allInstVarNames collect: [ :iv | iv -> (anObject instVarNamed: iv) ] ];
		format: [ :assoc | assoc key asString , ' : ' , (assoc value printString copyFrom: 1 to: ((50 min: assoc value printString size) max: 0)) ];
		send: #value.
	browser list
		title: 'Collection';
		when: [ :each | each isCollection ].
	browser text
		forSmalltalk;
		display: [ :entity | 'self' ];
		title: 'Evaluator';
		update: #selection
			on: $o
			entitled: 'Open (o)'
			with: 
				[ :text :entity | 
				Compiler 
					evaluate: text selectedText
					for: entity
					logged: false ];
		act: 
				[ :text :entity | 
				(Compiler 
					evaluate: text selectedText
					for: entity
					logged: false) inspect ]
			on: $/
			entitled: 'Inspect (/)'.
	^ browser
]

{ #category : #private }
GLMObjectFinder >> printObjectAsAnItem: anObject [ 
	| title stream |
	stream := String new writeStream.
	title := anObject class name.
	stream
		nextPutAll: (title first isVowel 
				ifTrue: [ 'an ' ]
				ifFalse: [ 'a ' ]);
		nextPutAll: title.
	^ stream contents
]
