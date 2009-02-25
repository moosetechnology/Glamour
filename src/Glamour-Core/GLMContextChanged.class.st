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

{ #category : #accessing }
GLMContextChanged >> oldValue [ 
	 
	^oldValue
]

{ #category : #accessing }
GLMContextChanged >> oldValue: anObject [ 
	 
	oldValue := anObject
]

{ #category : #accessing }
GLMContextChanged >> presentation [ 
	 
	^presentation
]

{ #category : #accessing }
GLMContextChanged >> presentation: aPresentation [ 
	 
	presentation := aPresentation
]

{ #category : #accessing }
GLMContextChanged >> property [ 
	 
	^property
]

{ #category : #accessing }
GLMContextChanged >> property: aSymbol [ 
	 
	property := aSymbol
]

{ #category : #accessing }
GLMContextChanged >> value [ 
	 
	^value
]

{ #category : #accessing }
GLMContextChanged >> value: anObject [ 
	 
	value := anObject
]
