Extension { #name : #RubScrolledTextMorph }

{ #category : #'*Glamour-Morphic-Brick' }
RubScrolledTextMorph >> cursor [
	"polymorphism with text area"
	^ self textArea cursor
]

{ #category : #'*Glamour-Morphic-Brick' }
RubScrolledTextMorph >> font: aFont [
	"polymorphism with text area"
	self textFont: aFont
]

{ #category : #'*Glamour-Morphic-Brick' }
RubScrolledTextMorph >> margins: aRectangle [
	"polymorphism with text area"
	self textArea margins: aRectangle
]
