Class {
	#name : #GLMPaginatedMorphTreeMorph,
	#superclass : #PaginatedMorphTreeMorph,
	#instVars : [
		'stopStepping'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #stepping }
GLMPaginatedMorphTreeMorph >> step [

	self wantsSteps ifFalse: [ ^ self ].
	self model updateRoots.
	self updateList
]

{ #category : #stepping }
GLMPaginatedMorphTreeMorph >> stepTime [
	^ self model stepTime
]

{ #category : #testing }
GLMPaginatedMorphTreeMorph >> wantsSteps [
	^ self model wantsSteps
]
