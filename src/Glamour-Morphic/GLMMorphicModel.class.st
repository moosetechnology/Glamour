Class {
	#name : #GLMMorphicModel,
	#superclass : #Announcer,
	#instVars : [
		'keystrokeActions',
		'menuActions',
		'menuInvokedAction'
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

{ #category : #initialization }
GLMMorphicModel >> initialize [
	super initialize.
	keystrokeActions := OrderedCollection new.
	menuActions := OrderedCollection new.
	menuInvokedAction := GLMAction new
							action: [:aPresentation :aMenuMorph | self updateMenu: aMenuMorph with: aPresentation menuActions]; 
									shortcut: $x; 
									title: 'Menu'; 
									yourself.									
	self flag: 'Review the menuInvokedAction initialization'.
]

{ #category : #callbacks }
GLMMorphicModel >> keystroke: aChar from: aMorph [
	| action |
	action := keystrokeActions detect: [:a | a shortcut = aChar] ifNone: [nil].
	action ifNotNil: [self announce: (GLMKeyStroke action: action)].
]

{ #category : #callbacks }
GLMMorphicModel >> menu: aMenuMorph [
	menuInvokedAction ifNotNil: [self announce: (GLMMenuInvoked action: menuInvokedAction on: aMenuMorph)].

	"menuActions do: [:action |
		aMenuMorph add: action title target: self selector: #executeMenuAction: argument: action].
	^aMenuMorph"
]
