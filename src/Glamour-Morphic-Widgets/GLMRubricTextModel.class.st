Class {
	#name : #GLMRubricTextModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'announcer'
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

{ #category : #'as yet unclassified' }
GLMRubricTextModel >> getText [
	^ self glamourPresentation displayValue
]
