Class {
	#name : #JQScrollTo,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
JQScrollTo >> method [
	^ 'scrollTo'
]

{ #category : #actions }
JQScrollTo >> target: aTarget [
	self action: aTarget
]
