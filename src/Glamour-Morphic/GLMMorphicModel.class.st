Class {
	#name : #GLMMorphicModel,
	#superclass : #Announcer,
	#category : #'Glamour-Morphic'
}

{ #category : #callbacks }
GLMMorphicModel >> keystroke: aChar from: aMorph [
	self announce: (GLMKeyStroke shortcut: aChar)
]
