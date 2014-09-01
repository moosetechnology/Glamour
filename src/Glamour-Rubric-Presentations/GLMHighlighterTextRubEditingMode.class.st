Class {
	#name : #GLMHighlighterTextRubEditingMode,
	#superclass : #RubEditingMode,
	#instVars : [
		'styler'
	],
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #'as yet unclassified' }
GLMHighlighterTextRubEditingMode class >> forStyler: aStyler [

	^ self new styler: aStyler
]

{ #category : #accessing }
GLMHighlighterTextRubEditingMode >> styler [
	
	^ styler
]

{ #category : #accessing }
GLMHighlighterTextRubEditingMode >> styler: anObject [
	
	styler := anObject
]

{ #category : #'initialize-release' }
GLMHighlighterTextRubEditingMode >> updateTextAreaWhenPlugged [
	self withStyler.
	super updateTextAreaWhenPlugged
]

{ #category : #'initialize-release' }
GLMHighlighterTextRubEditingMode >> updateTextAreaWhenUnplugged [
	self withoutStyler.
	super updateTextAreaWhenUnplugged


]

{ #category : #'initialize-release' }
GLMHighlighterTextRubEditingMode >> withStyler [
	self textArea withDecorator: self styler
]

{ #category : #'initialize-release' }
GLMHighlighterTextRubEditingMode >> withoutStyler [
	self textArea withoutDecorator: self styler
]
