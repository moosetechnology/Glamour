Extension { #name : #GLMBundleTransmission }

{ #category : #'*Glamour-Scripting' }
GLMBundleTransmission >> showing: aBlock [
	self origins isEmpty ifTrue: [self from: #outer->#entity].
	aBlock value: self presentations
]
