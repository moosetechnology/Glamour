Extension { #name : #GLMCompositePresentation }

{ #category : #'*glamour-rubric-presentations' }
GLMCompositePresentation >> pharoMethod [
	^ self custom: GLMPharoMethodPresentation new
]

{ #category : #'*glamour-rubric-presentations' }
GLMCompositePresentation >> pharoPlayground [
	^ self custom: GLMPharoPlaygroundPresentation new
]

{ #category : #'*glamour-rubric-presentations' }
GLMCompositePresentation >> rubricText [
	^ self custom: GLMRubricTextPresentation new
]
