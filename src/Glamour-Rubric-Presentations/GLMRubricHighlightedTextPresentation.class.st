"
|browser|
browser := GLMTabulator new.
browser row: #row.

browser transmit to: #row; andShow: [ :composite |
	composite custom: (GLMRubricHighlightedTextPresentation new
		editingMode: [GLMHighlighterTextRubEditingMode forStyler: #personStyler]) ].
	
browser openOn: '
person {	
	name	=	''Phil'';
	age = ''23'';	
}
person {}
'.
"
Class {
	#name : #GLMRubricHighlightedTextPresentation,
	#superclass : #GLMRubricTextPresentation,
	#instVars : [
		'editingMode'
	],
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #accessing }
GLMRubricHighlightedTextPresentation >> editingMode [
	^ editingMode isNil 
		ifTrue: [nil] 
		ifFalse: [editingMode glamourValue: self]
]

{ #category : #accessing }
GLMRubricHighlightedTextPresentation >> editingMode: aBlock [
	
	editingMode := aBlock
]

{ #category : #accessing }
GLMRubricHighlightedTextPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRubricHighlightedTextPresentation: self
]
