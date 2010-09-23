Class {
	#name : #GLMSystemWindow,
	#superclass : #StandardWindow,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #building }
GLMSystemWindow >> buildWindowMenu [
	| actions aMenu |
	actions := self model allActions select: [:each | each hasTitle and: [each hasIcon not]].
	^ actions isEmpty
		ifTrue: [ super buildWindowMenu ]
		ifFalse: [
			aMenu := self theme newMenuIn: self for: self.
			actions
				inject: aMenu
				into: [ :menu :action |
					menu
						add: action title target: action selector: #actOn: argument: self model;
						yourself ] ]
]

{ #category : #'as yet unclassified' }
GLMSystemWindow >> delete [
	self model unregisterFromAllAnnouncements.
	super delete
]

{ #category : #building }
GLMSystemWindow >> extent: aPoint [ 
	super extent: aPoint.
	self fullBounds.
	self refreshHorizontalScollbars.
]

{ #category : #building }
GLMSystemWindow >> refreshHorizontalScollbars [
	self flag: 'this was somehow needed when the magritte form was embedded in a scroll pane'
"	self allMorphsDo: 
		[ :morph | 
		(morph isKindOf: GLMScrollPaneForHResize) ifTrue: [ 
			morph scroller submorphs anyOne width: morph scroller width - 20 ] ]"
]
