Class {
	#name : #GLMPresentation,
	#superclass : #Announcer,
	#instVars : [
		'pane',
		'title',
		'transformation',
		'actions',
		'condition',
		'isInspectable',
		'implicitNotNil',
		'postTransformation',
		'dynamicActionsBlock'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMPresentation >> actions [
	actions ifNil: [actions := OrderedCollection new].
	^ actions
]

{ #category : #accessing }
GLMPresentation >> addAction: anAction [ 
	 
	self actions addLast: anAction
]

{ #category : #accessing }
GLMPresentation >> allActions [ 
	^ self actions, self dynamicActions
]

{ #category : #accessing }
GLMPresentation >> beInspectable [ 
	self flag: 'reconsider this part'.
	^isInspectable := true
]

{ #category : #accessing }
GLMPresentation >> condition [ 
	 
	^condition ifNil: [condition := [true]]
]

{ #category : #accessing }
GLMPresentation >> condition: anObject [ 
	 
	condition := anObject
]

{ #category : #accessing }
GLMPresentation >> displayValue [
	^ self transformation glamourValue: self entity
]

{ #category : #accessing }
GLMPresentation >> dynamicActions [
	dynamicActionsBlock isNil ifTrue: [ ^ OrderedCollection new ].
	^ dynamicActionsBlock value: self
]

{ #category : #'accessing ports' }
GLMPresentation >> entity [ 
	 
	^(self pane port: #entity) value
]

{ #category : #'accessing ports' }
GLMPresentation >> entity: anObject [ 
	 
	(self pane port: #entity) value: anObject
]

{ #category : #events }
GLMPresentation >> innerPortEvent: aPortEvent [ 
	 
	
]

{ #category : #accessing }
GLMPresentation >> isInspectable [ 
	 
	^isInspectable ifNil: [isInspectable := false]
]

{ #category : #testing }
GLMPresentation >> matches [ 
	^(self usesImplicitNotNil 
		ifTrue: [GLMNotNilCondition new glamourValue: self entity] 
		ifFalse: [true]) and: [(self condition glamourValue: self entity) = true]
]

{ #category : #events }
GLMPresentation >> outerPortEvent: aPortEvent [ 
	 
	self 
		announce: 
			((GLMContextChanged new) 
				presentation: self; 
				property: aPortEvent portName; 
				value: aPortEvent value; 
				oldValue: aPortEvent oldValue; 
				yourself)
]

{ #category : #accessing }
GLMPresentation >> pane [ 
	 
	^pane 
		ifNil: 
			[pane := (GLMPane in: GLMNoBrowser new) 
				addPresentation: self; 
				yourself]
]

{ #category : #accessing }
GLMPresentation >> pane: aPane [ 
	 
	pane := aPane
]

{ #category : #copying }
GLMPresentation >> postCopy [ 
	 
	super postCopy
]

{ #category : #accessing }
GLMPresentation >> postTransformation [
	"this is used for transforming the object before updating the selection"
	^ postTransformation ifNil: [postTransformation := #yourself]
]

{ #category : #rendering }
GLMPresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderPresentation: self
]

{ #category : #'accessing ports' }
GLMPresentation >> selection [ 
	 
	^(self pane port: #selection) value
]

{ #category : #'accessing ports' }
GLMPresentation >> selection: anObject [ 
	 
	(self pane port: #selection) value: (self postTransformation glamourValue: anObject)
]

{ #category : #accessing }
GLMPresentation >> selectionTransformation: anObject [ 
	postTransformation := anObject
]

{ #category : #accessing }
GLMPresentation >> title [ 
	 
	^title ifNil: [title := #glamourString]
]

{ #category : #accessing }
GLMPresentation >> title: aStringOrBlock [ 
	 
	title := aStringOrBlock
]

{ #category : #accessing }
GLMPresentation >> titleValue [
	| value |
	value := self title glamourValue: self entity.
	value size > 16 ifTrue: [ value := (value copyFrom: 1 to: 12), ' ...' ].	
	^ value 
]

{ #category : #accessing }
GLMPresentation >> transformation [ 
	 
	^transformation ifNil: [transformation := #yourself]
]

{ #category : #accessing }
GLMPresentation >> transformation: aBlock [ 
	 
	transformation := aBlock
]

{ #category : #accessing }
GLMPresentation >> useExplicitNotNil [ 
	 
	implicitNotNil := false
]

{ #category : #accessing }
GLMPresentation >> useImplicitNotNil [ 
	 
	implicitNotNil := true
]

{ #category : #testing }
GLMPresentation >> usesExplicitNotNil [ 
	 
	^self usesImplicitNotNil not
]

{ #category : #testing }
GLMPresentation >> usesImplicitNotNil [ 
	 
	^implicitNotNil ifNil: [implicitNotNil := true]
]

{ #category : #announcements }
GLMPresentation >> whenContextChanged: aBlock [ 
	 
	^self when: GLMContextChanged do: aBlock
]
