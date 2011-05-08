"
A GLMDynamicPresentation is a presentation that takes the actual presentation from the display value. Like this, we can have the block of display return a presentation depending on the input.

A usage for this behavior is the Glamorous Editor, which takes the text as input and based on this it displays the browser.
"
Class {
	#name : #GLMDynamicPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'presentationTransformation'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMDynamicPresentation >> currentPresentation [ 
	| composite |
	composite := GLMCompositePresentation new.
	self presentationTransformation glamourValue: (
			composite asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue).
	composite pane: self pane.
	^ composite
"	^ self displayValue pane: self pane"
]

{ #category : #'initialize-release' }
GLMDynamicPresentation >> initialize [ 
	super initialize.
	presentationTransformation := [ :aComposite :each | aComposite add: each ]
]

{ #category : #scripting }
GLMDynamicPresentation >> presentation: aBlock [
	self presentationTransformation: aBlock
]

{ #category : #accessing }
GLMDynamicPresentation >> presentationTransformation [
	^ presentationTransformation
]

{ #category : #accessing }
GLMDynamicPresentation >> presentationTransformation: anObject [
	presentationTransformation := anObject
]

{ #category : #rendering }
GLMDynamicPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderDynamicPresentation: self
]

{ #category : #scripting }
GLMDynamicPresentation >> with: aBlock [
	self presentationTransformation: aBlock
]
