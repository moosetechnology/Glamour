Extension { #name : #GLMListingPresentation }

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> filterOn: aBlock [ 
	filterBlock := aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> searchOn: aBlock [
	searchBlock := aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> tags: anObject [
	tagsBlock := anObject
]
