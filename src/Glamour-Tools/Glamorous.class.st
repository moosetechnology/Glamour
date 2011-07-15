"
A Glamorous is just a library of browsers stored as methods on the class side.
"
Class {
	#name : #Glamorous,
	#superclass : #Object,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
Glamorous class >> editor [
	"self editor openOn: '| browser |'"
	| browser |
	browser := GLMTabulator new.
	browser row: #browser; row: #source.
	browser title: 'Glamorous Editor'.
	browser transmit to: #source; andShow: [ :a |
		a text
			title: 'Editor';
			forSmalltalk;
			populate: #selection on: $s entitled: 'Open (o)' with: [:text | text text]].
	browser transmit to: #browser; from: #source; andShow: [ :a |
		a dynamic
			title: 'Preview';
			display: [:source | 
				(Compiler evaluate: source logged: false)]].
	^ browser
]
