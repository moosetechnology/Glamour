Extension { #name : #GLMCompositePresentation }

{ #category : #'*Glamour-Scripting' }
GLMCompositePresentation >> accordionArrangement [
	^ self arrangement: GLMAccordionArrangement new
]

{ #category : #'*Glamour-Scripting' }
GLMCompositePresentation >> custom: aPresentation [
	^ self add: aPresentation
]

{ #category : #'*Glamour-Scripting' }
GLMCompositePresentation >> stackedVerticallyArrangement [
	^ self arrangement: (GLMStackedVerticallyArrangement of: self)
]

{ #category : #'*Glamour-Scripting' }
GLMCompositePresentation >> verticallyStackedArrangement [
	^ self stackedVerticallyArrangement
]
