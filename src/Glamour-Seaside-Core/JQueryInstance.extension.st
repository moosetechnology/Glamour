Extension { #name : #JQueryInstance }

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourResize [
	^ self create: JQSGLResize 
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourScrollTo [
	^ self create: JQScrollTo
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourTabs [
	^ self create: JQSGLTabs
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourText [
	^ self create: JQSGLText
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourTree [
	^ self create: JQSGLTree
]
