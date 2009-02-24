Class {
	#name : #GLFormatedPresentation,
	#superclass : #GLPresentation,
	#instVars : [
		'formater',
		'format'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #'instance creation' }
GLFormatedPresentation class >> formater: aBlock [
	
	^(self new)
		formater: aBlock;
		yourself
]

{ #category : #private }
GLFormatedPresentation >> defaultFormater [
	
	^#displayString
]

{ #category : #accessing }
GLFormatedPresentation >> format [
	
	^format ifNil: [format := self defaultFormater]
]

{ #category : #accessing }
GLFormatedPresentation >> format: anObject [
	
	format := anObject
]

{ #category : #accessing }
GLFormatedPresentation >> formatedDisplayValue [
	
	^self format glamourValue: self displayValue
]
