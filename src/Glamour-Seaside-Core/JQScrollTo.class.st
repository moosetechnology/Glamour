Class {
	#name : #JQScrollTo,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'options-generated' }
JQScrollTo >> duration: anInteger [
	self optionAt: 'duration' put: anInteger
]

{ #category : #accessing }
JQScrollTo >> method [
	^ 'scrollTo'
]

{ #category : #actions }
JQScrollTo >> target: aTarget [
	self action: aTarget
]
