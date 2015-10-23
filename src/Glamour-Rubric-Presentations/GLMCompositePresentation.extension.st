Extension { #name : #GLMCompositePresentation }

{ #category : #'*glamour-rubric-presentations' }
GLMCompositePresentation >> pharoMethod [
	^ self custom: GLMPharoMethodPresentation new
]

{ #category : #'*glamour-rubric-presentations' }
GLMCompositePresentation >> pharoPlayground [
	self deprecated: 'Use pharoScript instead'.
	^ self custom: GLMPharoPlaygroundPresentation new
]

{ #category : #'*glamour-rubric-presentations' }
GLMCompositePresentation >> pharoScript [
	^ self custom: GLMPharoPlaygroundPresentation new
]

{ #category : #'*glamour-rubric-presentations' }
GLMCompositePresentation >> rubricText [
	^ self custom: GLMRubricTextPresentation new
]
