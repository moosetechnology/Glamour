Class {
	#name : #GLMRubTextFieldMorph,
	#superclass : #RubTextFieldMorph,
	#category : #'Glamour-Morphic-Brick-Morphic'
}

{ #category : #'initialize-release' }
GLMRubTextFieldMorph >> newScrollPane [
	"using hacked ScrollPane to remove focus border"
	| sp |
	sp := GLMRubTextScrollPane new.
	sp scrollTarget: self defaultScrollTarget.
	^ sp
]

{ #category : #geometry }
GLMRubTextFieldMorph >> textFieldHeight [

	^ self textArea height
]
