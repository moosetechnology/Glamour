Class {
	#name : #GLMBrickRefactoringService,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Utils'
}

{ #category : #refactoring }
GLMBrickRefactoringService >> replaceAll: aString with: anotherString [
	"replaces aString in source code in the whole image in all methods with anotherString"
	((self systemNavigation allMethodsWithSourceString: aString matchCase: false) collect: #compiledMethod)
		do: [ :each | each methodClass compile: (each sourceCode copyReplaceAll: aString with: anotherString) classified: each category ]
]
