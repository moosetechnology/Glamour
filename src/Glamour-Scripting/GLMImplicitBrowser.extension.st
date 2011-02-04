Extension { #name : #GLMImplicitBrowser }

{ #category : #'*Glamour-Scripting' }
GLMImplicitBrowser >> custom: aPresentation [ 
	 
	scriptTransmission isNil 
		ifTrue: [self addPresentation: aPresentation] 
		ifFalse: [self scriptTransmission addPresentation: aPresentation]. 
	^aPresentation
]

{ #category : #'*Glamour-Scripting' }
GLMImplicitBrowser >> show: aBlock [
	^ aBlock value: self presentations
]
