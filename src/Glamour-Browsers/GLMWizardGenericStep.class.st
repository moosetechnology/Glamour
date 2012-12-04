Class {
	#name : #GLMWizardGenericStep,
	#superclass : #GLMAbstractWizardStep,
	#instVars : [
		'size',
		'numberOfDisplayBlock'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #'initialize-release' }
GLMWizardGenericStep >> initialize [

	super initialize.
	size := 1
]

{ #category : #accessing }
GLMWizardGenericStep >> numberOfDisplay [
	
	self numberOfDisplayBlock isNil 
		ifFalse: [
			^ self numberOfDisplayBlock moValue: self input
			]
		ifTrue: [
			^ super numberOfDisplay
			].
	
]

{ #category : #accessing }
GLMWizardGenericStep >> numberOfDisplayBlock [

	^ numberOfDisplayBlock
]

{ #category : #accessing }
GLMWizardGenericStep >> numberOfDisplayBlock: aBlock [

	"this method allow the user to externally control the progression of this step. In merlin for exemple, it can be usefull to have some 'conditions' to validate before going on. If those conditions are not validated, we do not progress"
	numberOfDisplayBlock := aBlock
]

{ #category : #accessing }
GLMWizardGenericStep >> size [

	^ size glamourValue: self input
]

{ #category : #accessing }
GLMWizardGenericStep >> size: aNumberOrAblock [

	size := aNumberOrAblock 
]
