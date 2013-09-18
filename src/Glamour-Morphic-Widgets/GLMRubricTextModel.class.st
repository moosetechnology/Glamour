Class {
	#name : #GLMRubricTextModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'announcer',
		'primarySelectionInterval'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #accessing }
GLMRubricTextModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new weak ]
]

{ #category : #accessing }
GLMRubricTextModel >> announcer: anObject [
	announcer := anObject
]

{ #category : #accessing }
GLMRubricTextModel >> getText [
	^ self glamourPresentation displayValue
]

{ #category : #accessing }
GLMRubricTextModel >> primarySelectionInterval [
	^ primarySelectionInterval
]

{ #category : #accessing }
GLMRubricTextModel >> primarySelectionInterval: anInterval [ 
	primarySelectionInterval := anInterval
]

{ #category : #accessing }
GLMRubricTextModel >> setText: aText from: aRubScrolledTextMorph [ 
	self glamourPresentation text: aText.
	^true
]
