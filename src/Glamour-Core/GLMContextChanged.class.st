Class {
	#name : #GLMContextChanged,
	#superclass : #Announcement,
	#instVars : [
		'presentation',
		'property',
		'value',
		'oldValue'
	],
	#category : #'Glamour-Core'
}

{ #category : #testing }
GLMContextChanged >> announcesNewSelection [ 
	"ContextChanged announces a new selection if 
	the updated port is #selection and the new value is different from the current selection. 
	This method is useful when updating the selection in UI widgets, because 
	we only want to affect the widget when there actually is a new selection" 
	 
	^self property = #selection 
		and: [self presentation selection ~~ self value]
]

{ #category : #accessing }
GLMContextChanged >> oldValue [ 
	 
	^oldValue
]

{ #category : #accessing }
GLMContextChanged >> oldValue: anObject [ 
	 
	oldValue _ anObject
]

{ #category : #accessing }
GLMContextChanged >> presentation [ 
	 
	^presentation
]

{ #category : #accessing }
GLMContextChanged >> presentation: aPresentation [ 
	 
	presentation _ aPresentation
]

{ #category : #accessing }
GLMContextChanged >> property [ 
	 
	^property
]

{ #category : #accessing }
GLMContextChanged >> property: aSymbol [ 
	 
	property _ aSymbol
]

{ #category : #accessing }
GLMContextChanged >> value [ 
	 
	^value
]

{ #category : #accessing }
GLMContextChanged >> value: anObject [ 
	 
	value _ anObject
]
