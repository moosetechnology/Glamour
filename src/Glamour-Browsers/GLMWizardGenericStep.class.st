Class {
	#name : #GLMWizardGenericStep,
	#superclass : #GLMAbstractWizardStep,
	#instVars : [
		'size'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #'initialize-release' }
GLMWizardGenericStep >> initialize [

	super initialize.
	size := 1
]

{ #category : #accessing }
GLMWizardGenericStep >> size [

	^ size moValue: self input
]

{ #category : #accessing }
GLMWizardGenericStep >> size: aNumberOrAblock [

	size := aNumberOrAblock 
]
