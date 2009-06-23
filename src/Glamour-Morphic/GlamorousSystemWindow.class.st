Class {
	#name : #GlamorousSystemWindow,
	#superclass : #SystemWindow,
	#category : #'Glamour-Morphic'
}

{ #category : #building }
GlamorousSystemWindow >> buildWindowMenu [
	^ self model actions isEmpty
		ifTrue: [ super buildWindowMenu ]
		ifFalse: [
			self model actions
				inject: (super buildWindowMenu
					addLine;
					yourself)
				into: [ :menu :action |
					menu
						add: action title target: action selector: #actOn: argument: self model;
						yourself ] ]
]
