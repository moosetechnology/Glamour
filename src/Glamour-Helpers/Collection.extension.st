Extension { #name : #Collection }

{ #category : #'*Glamour-Helpers' }
Collection >> asGlamorousMultiValue [
	^ GLMMultiValue withAll: self
]
