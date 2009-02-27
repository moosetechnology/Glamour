Class {
	#name : #GlamorousSystemWindow,
	#superclass : #SystemWindow,
	#category : #'Glamour-Squeak'
}

{ #category : #'instance creation' }
GlamorousSystemWindow class >> openOn: aMorph [
	^(self labelled: 'Glamour') addMorph: aMorph frame: (0 @ 0 extent: 1 @ 1); openAsIs
]
