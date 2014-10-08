Class {
	#name : #GLMRubricTextFieldScrollPane,
	#superclass : #RubTextScrollPane,
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #'as yet unclassified' }
GLMRubricTextFieldScrollPane >> handlesMouseWheel: evt [
	"Do I want to receive mouseWheel events?." 

	^ false
]
