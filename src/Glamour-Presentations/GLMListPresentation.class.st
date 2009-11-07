Class {
	#name : #GLMListPresentation,
	#superclass : #GLMListingPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMListPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^aRenderer renderListPresentation: self
]

{ #category : #rendering }
GLMListPresentation >> update [

	(self entity includes: self selection) ifFalse: [self selection: nil].
	super update
]
