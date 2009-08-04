Class {
	#name : #GLMMorphicModel,
	#superclass : #Announcer,
	#instVars : [
		'glamourPresentation'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #callbacks }
GLMMorphicModel >> allKeystrokeActions [
	^ self glamourPresentation allActions select: [:action | action hasShortcut ]
]

{ #category : #callbacks }
GLMMorphicModel >> allMenuActions [
	^ self glamourPresentation allActions select: [:action | action hasTitle ]
]

{ #category : #callbacks }
GLMMorphicModel >> executeMenuAction: anAction [
	self announce: (GLMMenuItemSelected action: anAction)
]

{ #category : #accessing }
GLMMorphicModel >> glamourPresentation [
	^ glamourPresentation
]

{ #category : #accessing }
GLMMorphicModel >> glamourPresentation: anObject [
	glamourPresentation := anObject
]

{ #category : #initialization }
GLMMorphicModel >> initialize [
	super initialize.
]

{ #category : #callbacks }
GLMMorphicModel >> keystroke: aChar from: aMorph [
	| action |
	action := self allKeystrokeActions detect: [:a | a shortcut = aChar] ifNone: [nil].
	action ifNotNil: [ self announce: (GLMKeyStroke action: action) ].
]

{ #category : #callbacks }
GLMMorphicModel >> menu: aMenuMorph [ 
	self allMenuActions do: [ :action | 
		aMenuMorph 
			add: action title
			target: self
			selector: #executeMenuAction:
			argument: action ].
	^ aMenuMorph
]
