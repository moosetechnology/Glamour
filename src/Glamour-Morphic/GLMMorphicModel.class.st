Class {
	#name : #GLMMorphicModel,
	#superclass : #Announcer,
	#instVars : [
		'keystrokeActions',
		'menuActions'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMMorphicModel >> addKeystrokeAction: anAction [
	keystrokeActions add: anAction
]

{ #category : #accessing }
GLMMorphicModel >> addMenuAction: anAction [
	menuActions add: anAction
]

{ #category : #callbacks }
GLMMorphicModel >> executeMenuAction: anAction [
	self halt.
	self announce: (GLMMenuItemSelected action: anAction)
]

{ #category : #initialization }
GLMMorphicModel >> initialize [
	super initialize.
	keystrokeActions := OrderedCollection new.
	menuActions := OrderedCollection new.
]

{ #category : #callbacks }
GLMMorphicModel >> keystroke: aChar from: aMorph [
	| action |
	self halt.
	action := keystrokeActions detect: [:a | a shortcut = aChar] ifNone: [nil].
	action ifNotNil: [self announce: (GLMKeyStroke action: action)].
]

{ #category : #callbacks }
GLMMorphicModel >> menu [
	self halt
]

{ #category : #callbacks }
GLMMorphicModel >> menu: aMenuMorph [
	self halt.
	menuActions do: [:action |
		aMenuMorph add: action title target: self selector: #executeMenuAction: argument: action].
	^aMenuMorph
]
