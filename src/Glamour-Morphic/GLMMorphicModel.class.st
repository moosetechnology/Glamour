Class {
	#name : #GLMMorphicModel,
	#superclass : #Announcer,
	#instVars : [
		'keystrokeActions',
		'menuActions',
		'glamourPresentation'
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
	keystrokeActions := OrderedCollection new.
	menuActions := OrderedCollection new.
]

{ #category : #callbacks }
GLMMorphicModel >> keystroke: aChar from: aMorph [
	| action |
	action := keystrokeActions detect: [:a | a shortcut = aChar] ifNone: [nil].
	action ifNotNil: [ self announce: (GLMKeyStroke action: action) ].
]

{ #category : #callbacks }
GLMMorphicModel >> menu: aMenuMorph [ 
	self glamourPresentation dynamicActions do: 
		[ :action | 
		aMenuMorph 
			add: action title
			target: self
			selector: #executeMenuAction:
			argument: action ].
	^ aMenuMorph
]
