Extension { #name : #GLMCompositePresentation }

{ #category : #'*Glamour-Seaside-Core' }
GLMCompositePresentation >> registerInSeasideOn: aModel [
	SGLDefaultComponent register: self first on: aModel
]
