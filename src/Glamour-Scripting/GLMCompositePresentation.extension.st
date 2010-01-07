Extension { #name : #GLMCompositePresentation }

{ #category : #'*Glamour-Scripting' }
GLMCompositePresentation >> accordionArrangement [
	^ self arrangement: GLMAccordionArrangement new
]

{ #category : #'*Glamour-Scripting' }
GLMCompositePresentation >> custom: aPresentation [
	^ self add: aPresentation
]
