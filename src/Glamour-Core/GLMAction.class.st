"
Actions are elements of behavior that are executed upon a keyboard shortcut or other event.

Instances of Action are stored and maintained by Presentations. The exact representation is determined by the renderer, but actions can define a keyboard shortcut that should trigger the action or a title, category and position to be able to use the action as a context menu item.
"
Class {
	#name : #GLMAction,
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
GLMAction >> actOn: aPresentation [ 
	 
	^self action 
		glamourValueWithArgs: 
			(Array 
				with: aPresentation 
				withAll: aPresentation entity asGlamorousArray)
]

{ #category : #accessing }
GLMAction >> action [ 
	"The code that should be executed when this action is triggered." 
	 
	^action
]

{ #category : #accessing }
GLMAction >> action: aBlock [ 
	"The code that should be executed when this action is triggered. 
 
	The block can take optional arguments, the first will always be the 
	presentation on which this action was triggered." 
	 
	action := aBlock
]

{ #category : #accessing }
GLMAction >> category [ 
	"The name of the category that should be used when this action is displayed in a context menu." 
	 
	^category
]

{ #category : #accessing }
GLMAction >> category: aString [ 
	"The name of the category that should be used when this action is displayed in a context menu." 
	 
	category := aString
]

{ #category : #testing }
GLMAction >> hasShortcut [ 
	 
	^self shortcut notNil
]

{ #category : #testing }
GLMAction >> hasTitle [ 
	 
	^self title notNil
]

{ #category : #accessing }
GLMAction >> position [ 
	"The relative position within a context menu." 
	 
	^position
]

{ #category : #accessing }
GLMAction >> position: anInteger [ 
	"The relative position within a context menu." 
	 
	position := anInteger
]

{ #category : #accessing }
GLMAction >> shortcut [ 
	"Shortcut character that this action should be triggered with when the focus rests on the corresponding presentation. 
	Modifiers are platform specific an can not be defined." 
	 
	^shortcut
]

{ #category : #accessing }
GLMAction >> shortcut: aCharacter [ 
	"Shortcut character that this action should be triggered with when the focus rests on the corresponding presentation. 
	Modifiers are platform specific an can not be defined." 
	 
	shortcut := aCharacter
]

{ #category : #accessing }
GLMAction >> title [ 
	"Title that this action should use in a context menu." 
	 
	^title
]

{ #category : #accessing }
GLMAction >> title: anObject [ 
	"Title that this action should use in a context menu." 
	 
	title := anObject
]
