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
	"Displays a tag along the node with a text and/or an icon, as returned when evaluating anObject. Clicking on such a node's' tag would remove all nodes that don't have this tag (this behavior can be changed by sending the #tagsFilter: message)"
	tagsBlock := anObject.
	self hasTagsFilter ifFalse:[ tagsFilterBlock := anObject ]
]

{ #category : #'*Glamour-Scripting' }
GLMListingPresentation >> tagsFilter: anObject [
	"Changes the default behavior of hiding all nodes that don't have the exact same tag as the one just clicked"
	tagsFilterBlock := anObject 
]
