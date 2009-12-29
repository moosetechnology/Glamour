Extension { #name : #GLMListingPresentation }

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> allowDeselection [
	self allowsDeselection: true
]

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> beMultiple [
	allowsMultipleSelection := true
]

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> beSingle [
	allowsMultipleSelection := false
]

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> filterOn: aBlock [ 
	filterBlock := aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> searchOn: aBlock [
	searchBlock := aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> showOnly: aBlock [
	amountToShowBlock := aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> tags: anObject [
	tagsBlock := anObject.
	self hasTagsFilter ifFalse:[ tagsFilterBlock := anObject ]
]

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> tagsFilter: anObject [
	tagsFilterBlock := anObject 
]
