Extension { #name : #GLMListPresentation }

{ #category : #'*Glamour-Scripting' }
GLMListPresentation >> beMultiple [
	allowsMultipleSelection := true
]

{ #category : #'*Glamour-Scripting' }
GLMListPresentation >> beSingle [
	allowsMultipleSelection := false
]
