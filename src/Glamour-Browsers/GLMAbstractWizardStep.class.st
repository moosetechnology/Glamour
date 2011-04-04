Class {
	#name : #GLMAbstractWizardStep,
	#superclass : #Object,
	#instVars : [
		'name',
		'presentationBlock',
		'previousStep',
		'numberOfDisplay',
		'input'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #testing }
GLMAbstractWizardStep >> atBeginning [ 

	^ self numberOfDisplay = 1
]

{ #category : #testing }
GLMAbstractWizardStep >> atEnd [

	^ self size = self numberOfDisplay 
]

{ #category : #accessing }
GLMAbstractWizardStep >> decrementNumberOfDisplay [ 

	self numberOfDisplay: self numberOfDisplay - 1
]

{ #category : #scripting }
GLMAbstractWizardStep >> from: aSymbol [

	self previousStep: aSymbol  
]

{ #category : #accessing }
GLMAbstractWizardStep >> incrementNumberOfDisplay [

	self numberOfDisplay: self numberOfDisplay + 1
]

{ #category : #accessing }
GLMAbstractWizardStep >> input [

	^ input 
]

{ #category : #accessing }
GLMAbstractWizardStep >> input: anObject [

	input := anObject
]

{ #category : #accessing }
GLMAbstractWizardStep >> name [

	^ name ifNil: [name := '']
]

{ #category : #accessing }
GLMAbstractWizardStep >> name: aSymbolOrABlock [

	name := aSymbolOrABlock
]

{ #category : #accessing }
GLMAbstractWizardStep >> numberOfDisplay [
	
	^ numberOfDisplay ifNil: [numberOfDisplay := 0]
]

{ #category : #accessing }
GLMAbstractWizardStep >> numberOfDisplay: aNumber [
	
	numberOfDisplay := aNumber
]

{ #category : #accessing }
GLMAbstractWizardStep >> presentationBlock [

	^ presentationBlock 
]

{ #category : #accessing }
GLMAbstractWizardStep >> presentationBlock: aBlock [

	presentationBlock :=  aBlock
]

{ #category : #accessing }
GLMAbstractWizardStep >> previousStep [

	^ previousStep
]

{ #category : #accessing }
GLMAbstractWizardStep >> previousStep: aSymbol [

	previousStep := aSymbol
]

{ #category : #scripting }
GLMAbstractWizardStep >> show: aBlock [

	self presentationBlock: aBlock  
]

{ #category : #accessing }
GLMAbstractWizardStep >> size [

	^ self subclassResponsibility 
]
