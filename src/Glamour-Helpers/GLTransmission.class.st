Class {
	#name : #GLTransmission,
	#superclass : #Object,
	#category : #'Glamour-Core'
}

{ #category : #RefactoringBrowser }
GLTransmission class >> browserIcon [
	
	^ListIconLibrary visualFor: #glamourTransmission
]

{ #category : #testing }
GLTransmission >> originatesAt: aPort [
	
	^false
]

{ #category : #transmitting }
GLTransmission >> transmit [
	
	self subclassResponsibility
]

{ #category : #transmitting }
GLTransmission >> value [
	
	self subclassResponsibility
]
