Class {
	#name : #GLMHighlighterTextRubEditingMode,
	#superclass : #RubEditingMode,
	#instVars : [
		'stylerDecorator'
	],
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #'as yet unclassified' }
GLMHighlighterTextRubEditingMode class >> withParserStyler: aParser [

	^ self new stylerDecorator: (GLMHighlighterTextStylerDecorator new
			withParserStyler: aParser)
]

{ #category : #'as yet unclassified' }
GLMHighlighterTextRubEditingMode class >> withStylerDecorator: aDecorator [

	^ self new stylerDecorator: aDecorator
]

{ #category : #accessing }
GLMHighlighterTextRubEditingMode >> stylerDecorator [
	
	^ stylerDecorator
]

{ #category : #accessing }
GLMHighlighterTextRubEditingMode >> stylerDecorator: anObject [
	
	stylerDecorator := anObject
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
	self textArea withDecorator: self stylerDecorator
]

{ #category : #'initialize-release' }
GLMHighlighterTextRubEditingMode >> withoutStyler [
	self textArea withoutDecorator: self stylerDecorator
]
