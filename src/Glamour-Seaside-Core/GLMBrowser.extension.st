Extension { #name : #GLMBrowser }

{ #category : #'*Glamour-Seaside-Core' }
GLMBrowser >> registerInSeasideOn: aModel [
	SGLDefaultComponent register: self on: aModel
]
