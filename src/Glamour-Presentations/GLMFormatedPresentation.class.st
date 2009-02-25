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
	 
	^#asString
]

{ #category : #accessing }
GLMFormatedPresentation >> format [ 
	 
	^format ifNil: [format := self defaultFormater]
]

{ #category : #accessing }
GLMFormatedPresentation >> format: anObject [ 
	 
	format := anObject
]

{ #category : #accessing }
GLMFormatedPresentation >> formatedDisplayValue [ 
	 
	^self format glamourValue: self displayValue
]
