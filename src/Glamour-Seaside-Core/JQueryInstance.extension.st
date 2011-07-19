Extension { #name : #JQueryInstance }

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourDashboard [

	^ self create: JQSGLDashboard
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourDashboardContainer [

	^ self create: JQSGLDashboardContainer
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourExpander [
	^ self create: JQSGLExpander
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourFinder [
	^ self create: JQSGLFinder
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourHtml: aRenderable [
	self call: 'glamourHtml' with: (self render: aRenderable)
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourResize [
	^ self create: JQSGLResize 
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourScrollTo [
	^ self create: JQScrollTo
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourStack [
	^ self create: JQSGLStack 
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
