Class {
	#name : #GLMMorphicModel,
	#superclass : #Announcer,
	#instVars : [
		'keystrokeActions'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMMorphicModel >> addKeystrokeAction: anAction [
	keystrokeActions add: anAction
]

{ #category : #initialization }
GLMMorphicModel >> initialize [
	super initialize.
	keystrokeActions := OrderedCollection new.
]

{ #category : #callbacks }
GLMMorphicModel >> keystroke: aChar from: aMorph [
	| action |
	action := keystrokeActions detect: [:a | a shortcut = aChar] ifNone: [nil].
	action ifNotNil: [self announce: (GLMKeyStroke action: action)].
]
