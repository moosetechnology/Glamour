Class {
	#name : #SGLTextPresenterSelectionIntervalChanged,
	#superclass : #Announcement,
	#instVars : [
		'selectionInterval'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #accessing }
SGLTextPresenterSelectionIntervalChanged >> selectionInterval [
	^ selectionInterval
]

{ #category : #accessing }
SGLTextPresenterSelectionIntervalChanged >> selectionInterval: anObject [
	selectionInterval := anObject
]
