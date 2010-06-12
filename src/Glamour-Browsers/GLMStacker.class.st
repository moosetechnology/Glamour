"
A GLMStacker is an explicit browser that allows us to stack panes on top of each other and show them as tabs.
"
Class {
	#name : #GLMStacker,
	#superclass : #GLMExplicitBrowser,
	#category : #'Glamour-Browsers'
}

{ #category : #'as yet unclassified' }
GLMStacker >> aPane: aBlockOrSymbol [
	^ self addNewPaneNamed: aBlockOrSymbol
]

{ #category : #'as yet unclassified' }
GLMStacker >> renderGlamorouslyOn: aRenderer [ 
	^aRenderer renderStacker: self
]
