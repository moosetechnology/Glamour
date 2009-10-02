Class {
	#name : #GlamorousSystemWindow,
	#superclass : #StandardWindow,
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

{ #category : #building }
GlamorousSystemWindow >> extent: aPoint [ 
	super extent: aPoint.
	self fullBounds.
	self allMorphsDo: 
		[ :morph | 
		(morph isKindOf: GLMScrollPaneForHResize) ifTrue: [ morph scroller submorphs anyOne width: morph scroller width - 20 ] ]
]
