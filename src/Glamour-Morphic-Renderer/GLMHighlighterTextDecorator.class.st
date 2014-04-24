Class {
	#name : #GLMHighlighterTextDecorator,
	#superclass : #RubParagraphDecorator,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMHighlighterTextDecorator class >> key [

	^ nil
]

{ #category : #accessing }
GLMHighlighterTextDecorator >> parser [
	
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
GLMHighlighterTextDecorator >> replaceFrom: start to: stop with: aText [
	| colorizedText hasVisibleChar | 
	hasVisibleChar := aText string anySatisfy: [ :c | c isSeparator not ].	
	"by default the new text is false (in red). 
	If the aText contains only separators then all the text is considered as possibly false"
	hasVisibleChar
		ifTrue: [ aText makeAllColor: Color red ]
		ifFalse: [ self text makeAllColor: Color red ].
	next replaceFrom: start to: stop with: aText.
	"try to parse, if there is no syntax error then the result is a colorized text"
	colorizedText := self parser parse: self text asString onError: [  ].
	colorizedText ifNotNil: [ next replaceFrom: 1 to: self text size with: colorizedText ]
]
