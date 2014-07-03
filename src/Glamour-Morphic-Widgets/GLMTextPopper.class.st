"
We only need this specialization so that we can delete the text area on escape
"
Class {
	#name : #GLMTextPopper,
	#superclass : #RubEditingArea,
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #'event handling' }
GLMTextPopper >> escapePressed [
	^ self delete
]
