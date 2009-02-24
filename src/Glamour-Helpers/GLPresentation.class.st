Class {
	#name : #GLPresentation,
	#superclass : #Announcer,
	#instVars : [
		'pane',
		'title',
		'transformation',
		'actions',
		'condition',
		'isInspectable',
		'implicitNotNil'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLPresentation class >> browserIcon [
	
	^ListIconLibrary visualFor: #glamourPresentation
]

{ #category : #accessing }
GLPresentation >> actions [
	
	^actions ifNil: [actions := OrderedCollection new]
]

{ #category : #accessing }
GLPresentation >> addAction: anAction [
	
	self actions addLast: anAction
]

{ #category : #accessing }
GLPresentation >> beInspectable [
	
	^isInspectable := true
]

{ #category : #accessing }
GLPresentation >> condition [
	
	^condition ifNil: [condition := [true]]
]

{ #category : #accessing }
GLPresentation >> condition: anObject [
	
	condition := anObject
]

{ #category : #scripting }
GLPresentation >> display: aBlock [
	
	self transformation: aBlock
]

{ #category : #accessing }
GLPresentation >> displayValue [
	
	^self transformation glamourValue: self entity
]

{ #category : #'accessing ports' }
GLPresentation >> entity [
	
	^(self pane port: #entity) value
]

{ #category : #'accessing ports' }
GLPresentation >> entity: anObject [
	
	(self pane port: #entity) value: anObject
]

{ #category : #events }
GLPresentation >> innerPortEvent: aPortEvent [
	
	
]

{ #category : #accessing }
GLPresentation >> isInspectable [
	
	^isInspectable ifNil: [isInspectable := false]
]

{ #category : #testing }
GLPresentation >> matches [
	
	^(self usesImplicitNotNil
		ifTrue: [GLNotNilCondition new glamourValue: self entity]
		ifFalse: [true]) and: [(self condition glamourValue: self entity) = true]
]

{ #category : #scripting }
GLPresentation >> on: aCharacter do: aBlock [
	
	self
		addAction:
			((GLAction new)
				action: aBlock;
				shortcut: aCharacter;
				yourself)
]

{ #category : #events }
GLPresentation >> outerPortEvent: aPortEvent [
	
	self
		announce:
			((GLContextChanged new)
				presentation: self;
				property: aPortEvent portName;
				value: aPortEvent value;
				oldValue: aPortEvent oldValue;
				yourself)
]

{ #category : #accessing }
GLPresentation >> pane [
	
	^pane
		ifNil:
			[pane := (GLPane new)
				addPresentation: self;
				yourself]
]

{ #category : #accessing }
GLPresentation >> pane: aPane [
	
	pane := aPane
]

{ #category : #copying }
GLPresentation >> postCopy [
	
	super postCopy
]

{ #category : #rendering }
GLPresentation >> renderGlamorouslyOn: aRenderer [
	
	^aRenderer renderPresentation: self
]

{ #category : #'accessing ports' }
GLPresentation >> selection [
	
	^(self pane port: #selection) value
]

{ #category : #'accessing ports' }
GLPresentation >> selection: anObject [
	
	(self pane port: #selection) value: anObject
]

{ #category : #accessing }
GLPresentation >> title [
	
	^title
]

{ #category : #accessing }
GLPresentation >> title: aString [
	
	title := aString
]

{ #category : #accessing }
GLPresentation >> transformation [
	
	^transformation ifNil: [transformation := #yourself]
]

{ #category : #accessing }
GLPresentation >> transformation: aBlock [
	
	transformation := aBlock
]

{ #category : #accessing }
GLPresentation >> useExplicitNotNil [
	
	implicitNotNil := false
]

{ #category : #accessing }
GLPresentation >> useImplicitNotNil [
	
	implicitNotNil := true
]

{ #category : #testing }
GLPresentation >> usesExplicitNotNil [
	
	^self usesImplicitNotNil not
]

{ #category : #testing }
GLPresentation >> usesImplicitNotNil [
	
	^implicitNotNil ifNil: [implicitNotNil := true]
]

{ #category : #scripting }
GLPresentation >> when: aBlock [
	
	self condition: aBlock
]

{ #category : #announcements }
GLPresentation >> whenContextChanged: aBlock [
	
	^self on: GLContextChanged do: aBlock
]

{ #category : #scripting }
GLPresentation >> whenKindOf: aClass [
	
	self when: [:each | each isKindOf: aClass]
]
