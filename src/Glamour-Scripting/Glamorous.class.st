"
A Glamorous is just a library of browsers stored as methods on the class side.
"
Class {
	#name : #Glamorous,
	#superclass : #Object,
	#category : #'Glamour-Scripting'
}

{ #category : #'as yet unclassified' }
Glamorous class >> editor [
	| browser |
	browser := GLMTabulator new.
	browser row: #browser; row: #source.
	browser title: 'Glamorous Editor'.
	browser showOn: #source; using: [
		browser text
			forSmalltalk;
			populate: #selection on: $o entitled: 'Open (o)' with: [:text | text text]].
	browser showOn: #browser; from: #source; using: [
		browser dynamic
			display: [:source | 
				(Compiler evaluate: source logged: false)]].
	browser openOn: '| browser |
	'
]
