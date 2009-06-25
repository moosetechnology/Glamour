Class {
	#name : #GLMScrollBar,
	#superclass : #ScrollBar,
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMScrollBar class >> alwaysShowFlatScrollbarForAlternativeLook [
	"Set this value to true, if you want to see the flat scrollbar look in flop-out mode as well as inboard.  Otherwise the flop-out scrollbar will be rounded and inboard will be flat."
	^ false
]

{ #category : #'class initialization' }
GLMScrollBar class >> initialize [ "GLMScrollBar initialize"

	UpArrow := Form
		extent: 6@3
		fromArray: #(2r11e28 2r1111e27 2r111111e26)
		offset: 0@0.
]
