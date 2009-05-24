Class {
	#name : #GlamorousSystemWindow,
	#superclass : #SystemWindow,
	#category : #'Glamour-Morphic'
}

{ #category : #'instance creation' }
GlamorousSystemWindow class >> openOn: aMorph [
	^(self labelled: 'Glamour') addMorph: aMorph frame: (0 @ 0 extent: 1 @ 1); openAsIs
]

{ #category : #'as yet unclassified' }
GlamorousSystemWindow >> buildWindowMenu [
	"Build and answer the window menu."
	
	| aMenu |
	aMenu := self theme newMenuIn: self for: self.
	aMenu addToggle: 'some action' target: [Transcript show: 'something'] selector: #value.
	^aMenu
]
