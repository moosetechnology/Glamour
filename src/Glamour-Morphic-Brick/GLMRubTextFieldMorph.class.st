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
	| vgap |
	vgap := self currentHScrollBarThickness isZero
		ifTrue: [  -1 ]
		ifFalse: [ self currentHScrollBarThickness - 1 ].
		
	^ self textArea height + vgap
]
