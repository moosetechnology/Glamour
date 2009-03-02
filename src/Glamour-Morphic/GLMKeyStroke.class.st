Class {
	#name : #GLMKeyStroke,
	#superclass : #Announcement,
	#instVars : [
		'shortcut'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'instance creation' }
GLMKeyStroke class >> shortcut: aChar [
	^self new shortcut: aChar; yourself
]

{ #category : #accessing }
GLMKeyStroke >> shortcut [
	^shortcut 
]

{ #category : #accessing }
GLMKeyStroke >> shortcut: aChar [
	shortcut := aChar
]
