"
This is a helper class that is supposed to be subclassed for each rendering logic of a specific morph. For example, there will be a TreeRenderer, a TextRenderer etc
"
Class {
	#name : #GLMMorphicWidgetRenderer,
	#superclass : #Object,
	#instVars : [
		'renderer'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMorphicWidgetRenderer class >> render: aPresentation from: aRenderer [
	^ self new 
		renderer: aRenderer;
		render: aPresentation
]

{ #category : #rendering }
GLMMorphicWidgetRenderer >> render: aPresentation [
	^ self subclassResponsibility 
]

{ #category : #private }
GLMMorphicWidgetRenderer >> renderObject: anObject [
	^ renderer render: anObject 
]

{ #category : #accessing }
GLMMorphicWidgetRenderer >> renderer [
	^ renderer
]

{ #category : #accessing }
GLMMorphicWidgetRenderer >> renderer: anObject [
	renderer := anObject
]
