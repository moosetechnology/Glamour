Extension { #name : #GLMCompositePresentation }

{ #category : #'*glamour-rubric-presentations' }
GLMCompositePresentation >> rubricSmalltalkCode [
	^ self custom: GLMRubricSmalltlakCodePresentation new
]

{ #category : #'*glamour-rubric-presentations' }
GLMCompositePresentation >> rubricText [
	^ self custom: GLMRubricTextPresentation new
]
