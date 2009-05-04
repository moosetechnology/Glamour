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
		'implicitNotNil'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMPresentation >> actions [ 
	 
	^actions ifNil: [actions _ OrderedCollection new]
]

{ #category : #accessing }
GLMPresentation >> addAction: anAction [ 
	 
	self actions addLast: anAction
]

{ #category : #accessing }
GLMPresentation >> beInspectable [ 
	 
	^isInspectable _ true
]

{ #category : #accessing }
GLMPresentation >> condition [ 
	 
	^condition ifNil: [condition _ [true]]
]

{ #category : #accessing }
GLMPresentation >> condition: anObject [ 
	 
	condition _ anObject
]

{ #category : #accessing }
GLMPresentation >> displayValue [ 
	 
	^self transformation glamourValue: self entity
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
	 
	^isInspectable ifNil: [isInspectable _ false]
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
			[pane _ (GLMPane new) 
				addPresentation: self; 
				yourself]
]

{ #category : #accessing }
GLMPresentation >> pane: aPane [ 
	 
	pane _ aPane
]

{ #category : #copying }
GLMPresentation >> postCopy [ 
	 
	super postCopy
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
	 
	(self pane port: #selection) value: anObject
]

{ #category : #accessing }
GLMPresentation >> title [ 
	 
	^title ifNil: [title _ #glamourString]
]

{ #category : #accessing }
GLMPresentation >> title: aStringOrBlock [ 
	 
	title _ aStringOrBlock
]

{ #category : #accessing }
GLMPresentation >> titleValue [ 
	 
	^self title glamourValue: self entity
]

{ #category : #accessing }
GLMPresentation >> transformation [ 
	 
	^transformation ifNil: [transformation _ #yourself]
]

{ #category : #accessing }
GLMPresentation >> transformation: aBlock [ 
	 
	transformation _ aBlock
]

{ #category : #accessing }
GLMPresentation >> useExplicitNotNil [ 
	 
	implicitNotNil _ false
]

{ #category : #accessing }
GLMPresentation >> useImplicitNotNil [ 
	 
	implicitNotNil _ true
]

{ #category : #testing }
GLMPresentation >> usesExplicitNotNil [ 
	 
	^self usesImplicitNotNil not
]

{ #category : #testing }
GLMPresentation >> usesImplicitNotNil [ 
	 
	^implicitNotNil ifNil: [implicitNotNil _ true]
]

{ #category : #announcements }
GLMPresentation >> whenContextChanged: aBlock [ 
	 
	^self when: GLMContextChanged do: aBlock
]
