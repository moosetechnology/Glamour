Class {
	#name : #GLMListPresentation,
	#superclass : #GLMListingPresentation,
	#instVars : [
		'allowsMultipleSelection'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #testing }
GLMListPresentation >> isMultiple [
	^ allowsMultipleSelection ifNil: [ allowsMultipleSelection := false ]
]

{ #category : #testing }
GLMListPresentation >> isSingle [ 
	^ self isMultiple not
]

{ #category : #rendering }
GLMListPresentation >> renderGlamorouslyOn: aRenderer [ 
	^aRenderer renderListPresentation: self
]
