Extension { #name : #GLMBrowser }

{ #category : #'*Glamour-Seaside-Scripting' }
GLMBrowser >> registerInSeasideOn: aModel [
	SGLDefaultComponent register: self on: aModel
]
