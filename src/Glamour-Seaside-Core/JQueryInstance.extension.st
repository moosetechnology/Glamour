Extension { #name : #JQueryInstance }

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourDashboard [

	^ self create: JQSGLDashboard
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourDashboardCell [

	^ self create: JQSGLDashboardCell
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourDashboardColumn [

	^ self create: JQSGLDashboardColumn
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourDropdown [
	^ self create: JQSGLDropdown 
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
JQueryInstance >> glamourRoassal [
	^ self create: JQSGLRoassalView
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
JQueryInstance >> glamourTable [
	^ self create: JQSGLTable
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

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourValidator [

	^ self create: JQSGLValidator
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourValidatorBrowser [

	^ self create: JQSGLValidatorBrowser
]

{ #category : #'*Glamour-Seaside-Core' }
JQueryInstance >> glamourWizard [

	^ self create: JQSGLWizard
]
