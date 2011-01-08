"
This class specifies that the updating announcement should come only from the single announcer object.
"
Class {
	#name : #GLMSingleUpdateAction,
	#superclass : #GLMUpdateAction,
	#category : #'Glamour-Core'
}

{ #category : #public }
GLMSingleUpdateAction >> computeAnnouncerObjects [ 
	^ OrderedCollection with: (self transformation glamourValue: self presentation entity)
]
