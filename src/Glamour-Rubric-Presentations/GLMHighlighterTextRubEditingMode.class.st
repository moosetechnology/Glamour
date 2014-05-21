Class {
	#name : #GLMHighlighterTextRubEditingMode,
	#superclass : #RubEditingMode,
	#instVars : [
		'registerStylerKey'
	],
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #'as yet unclassified' }
GLMHighlighterTextRubEditingMode class >> forStyler: aStylerKey [

	^ self new
		registerStylerKey: aStylerKey
]

{ #category : #accessing }
GLMHighlighterTextRubEditingMode >> registerStylerKey [
	
	^ registerStylerKey
]

{ #category : #accessing }
GLMHighlighterTextRubEditingMode >> registerStylerKey: anObject [
	
	registerStylerKey := anObject
]

{ #category : #'initialize-release' }
GLMHighlighterTextRubEditingMode >> updateTextAreaWhenPlugged [
	self withRegistryStyler.
	super updateTextAreaWhenPlugged
]

{ #category : #'initialize-release' }
GLMHighlighterTextRubEditingMode >> updateTextAreaWhenUnplugged [
	self withoutRegistryStyler.
	super updateTextAreaWhenUnplugged


]

{ #category : #'initialize-release' }
GLMHighlighterTextRubEditingMode >> withRegistryStyler [
	self textArea withDecoratorNamed: self registerStylerKey
]

{ #category : #'initialize-release' }
GLMHighlighterTextRubEditingMode >> withoutRegistryStyler [
	self textArea withoutDecoratorNamed: self registerStylerKey
]
