Class {
	#name : #GlamorousSystemWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'actions'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'instance creation' }
GlamorousSystemWindow class >> openOn: aMorph [
	^(self labelled: 'Glamour') addMorph: aMorph frame: (0 @ 0 extent: 1 @ 1); openAsIs
]

{ #category : #'as yet unclassified' }
GlamorousSystemWindow >> actions [
	^ actions ifNil: [actions := OrderedCollection new]
]

{ #category : #'as yet unclassified' }
GlamorousSystemWindow >> actions: aCollection [
	actions := aCollection
]

{ #category : #'as yet unclassified' }
GlamorousSystemWindow >> buildWindowMenu [
	"Build and answer the window menu."
	
	| aMenu |
	aMenu := self theme newMenuIn: self for: self.
	self actions do: [:association | 
		aMenu add: association key target: association value selector: #value.
	].
	^aMenu
]
