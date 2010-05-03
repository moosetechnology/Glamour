Class {
	#name : #GLMMultipleUpdateAction,
	#superclass : #GLMUpdateAction,
	#category : #'Glamour-Core'
}

{ #category : #public }
GLMMultipleUpdateAction >> computeAnnouncerObjects [ 
	^ self transformation glamourValue: self presentation entity
]
