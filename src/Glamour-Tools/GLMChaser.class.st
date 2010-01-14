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
	"self openOn: #buildBrowser"
	browser := GLMFinder new.
	browser title: [:each | 'Chasing Browser of #', each].
	browser custom: self methodSourceBrowser.
	^ browser
]

{ #category : #building }
GLMChaser >> methodSourceBrowser [
	| browser |
	browser := GLMTabulator new.
	browser row: #methods; row: #source.
	browser transmit to: #methods; andShow: [ :a | 
		a tree
			title: 'Senders';
			display: [ :each | 
				self systemNavigation allSendersOf:	((each isKindOf: MethodReference) ifTrue: [each selector ] ifFalse: [ each ]) ];
			format: [:each | 
				(each isKindOf: MethodReference) ifTrue: [each classSymbol, '>>', each selector ] ifFalse: [ each ]]";
			children: [ :each | 
				(each isKindOf: MethodReference) ifTrue: [each compiledMethod messages] ifFalse: [OrderedCollection new]]" ].
	browser transmit from: #methods; to: #source; andShow: [:a |
		a text
			forSmalltalk: [:reference | reference actualClass ];
			display: [:reference | reference sourceCode ];
			whenKindOf: MethodReference ].
	browser transmit from: #methods; to: #outer->#selection.
	^ browser
]
