Class {
	#name : #GLMFormatedPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'format',
		'icon'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMFormatedPresentation >> format [
	^ format ifNil: [ format := #glamourString ]
]

{ #category : #accessing }
GLMFormatedPresentation >> format: anObject [ 
	 
	format := anObject
]

{ #category : #accessing }
GLMFormatedPresentation >> formatedDisplayValue [
	^ self format glamourValue: self displayValue
]

{ #category : #accessing }
GLMFormatedPresentation >> formatedDisplayValueOf: anObject [
	^ self format glamourValue: (anObject asGlamorousMultiValue, self entity asGlamorousMultiValue)
]

{ #category : #accessing }
GLMFormatedPresentation >> icon [
	^ icon ifNil: [ icon := [nil] ]
]

{ #category : #accessing }
GLMFormatedPresentation >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
GLMFormatedPresentation >> iconFor: anObject [
	^ self icon glamourValue: (anObject asGlamorousMultiValue, self entity asGlamorousMultiValue)
]
