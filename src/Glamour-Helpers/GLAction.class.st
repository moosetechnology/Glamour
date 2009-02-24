"
Actions are elements of behavior that are executed upon a keyboard shortcut or other event.

Instances of Action are stored and maintained by Presentations. The exact representation is determined by the renderer, but actions can define a keyboard shortcut that should trigger the action or a title, category and position to be able to use the action as a context menu item.
"
Class {
	#name : #GLAction,
	#superclass : #Object,
	#instVars : [
		'action',
		'title',
		'shortcut',
		'position',
		'category'
	],
	#category : #'Glamour-Core'
}

{ #category : #'public interface' }
GLAction >> actOn: aPresentation [
	
	^self action glamourValueWithArgs: (Array with: aPresentation)
]

{ #category : #accessing }
GLAction >> action [
	"The code that should be executed when this action is triggered."
	
	^action
]

{ #category : #accessing }
GLAction >> action: aBlock [
	"The code that should be executed when this action is triggered.

	The block can take optional arguments, the first will always be the
	presentation on which this action was triggered."
	
	action := aBlock
]

{ #category : #accessing }
GLAction >> category [
	"The name of the category that should be used when this action is displayed in a context menu."
	
	^category
]

{ #category : #accessing }
GLAction >> category: aString [
	"The name of the category that should be used when this action is displayed in a context menu."
	
	category := aString
]

{ #category : #accessing }
GLAction >> position [
	"The relative position within a context menu."
	
	^position
]

{ #category : #accessing }
GLAction >> position: anInteger [
	"The relative position within a context menu."
	
	position := anInteger
]

{ #category : #accessing }
GLAction >> shortcut [
	"Shortcut character that this action should be triggered with when the focus rests on the corresponding presentation.
	Modifiers are platform specific an can not be defined."
	
	^shortcut
]

{ #category : #accessing }
GLAction >> shortcut: aCharacter [
	"Shortcut character that this action should be triggered with when the focus rests on the corresponding presentation.
	Modifiers are platform specific an can not be defined."
	
	shortcut := aCharacter
]

{ #category : #accessing }
GLAction >> title [
	"Title that this action should use in a context menu."
	
	^title
]

{ #category : #accessing }
GLAction >> title: anObject [
	"Title that this action should use in a context menu."
	
	title := anObject
]
