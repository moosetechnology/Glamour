Class {
	#name : #GLMFormatedPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'formater',
		'format'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #'instance creation' }
GLMFormatedPresentation class >> formater: aBlock [ 
	 
	^(self new) 
		formater: aBlock; 
		yourself
]

{ #category : #private }
GLMFormatedPresentation >> defaultFormater [ 
	 
	^#glamourString
]

{ #category : #accessing }
GLMFormatedPresentation >> format [ 
	 
	^format ifNil: [format _ self defaultFormater]
]

{ #category : #accessing }
GLMFormatedPresentation >> format: anObject [ 
	 
	format _ anObject
]

{ #category : #accessing }
GLMFormatedPresentation >> formatedDisplayValue [ 
	 
	^self format glamourValue: self displayValue
]
