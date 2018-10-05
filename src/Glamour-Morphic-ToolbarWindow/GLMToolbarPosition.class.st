"
I represent a toolbar position (who can be: top, left, bottom and right).
I'm an abstract class and my children implements each one of the possible positions. 

I am used by GLMMorphicToolbarWindowRenderer to place the toolbar where it belongs (see #addToolbar: to:) and to configure the toolbar when is needed (see #configureToolbar:)
"
Class {
	#name : #GLMToolbarPosition,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Glamour-Morphic-ToolbarWindow'
}

{ #category : #'instance creation' }
GLMToolbarPosition class >> fromSymbol: aSymbol [
	^ (self allSubclasses
		detect: [ :each | each kind = aSymbol ])
		uniqueInstance
]

{ #category : #accessing }
GLMToolbarPosition class >> kind [
	^ self subclassResponsibility
]

{ #category : #accessing }
GLMToolbarPosition class >> left [
	^ GLMToolbarPositionLeft uniqueInstance
]

{ #category : #'instance creation' }
GLMToolbarPosition class >> new [
	^ self error: 'Use #uniqueInstance'
]

{ #category : #accessing }
GLMToolbarPosition class >> top [
	^ GLMToolbarPositionTop uniqueInstance
]

{ #category : #'instance creation' }
GLMToolbarPosition class >> uniqueInstance [
	self = GLMToolbarPosition ifTrue: [ 
		self error: 'I''m an abstract class, use one of my children' ].
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ]
]

{ #category : #'configuring morphs' }
GLMToolbarPosition >> addToolbar: toolbarMorph to: aMorph [
	"Places a toolbar into a aMorph. 
	 Answers the offset position to place content element"
	self subclassResponsibility
]

{ #category : #converting }
GLMToolbarPosition >> asToolbarPosition [
	^ self
]

{ #category : #'configuring morphs' }
GLMToolbarPosition >> configureToolbar: aMorph [
	self subclassResponsibility
]

{ #category : #accessing }
GLMToolbarPosition >> kind [
	^ self class kind
]
