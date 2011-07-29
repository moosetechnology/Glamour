Class {
	#name : #GLMDashboard,
	#superclass : #GLMExplicitBrowser,
	#instVars : [
		'panesExtents',
		'extentStrategy',
		'defaultPaneExtent'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #scripting }
GLMDashboard >> addPaneNamed: aString [

	self addNewPaneNamed: aString
]

{ #category : #scripting }
GLMDashboard >> addPaneNamed: aSymbol extent: aPoint [

	self addPaneNamed: aSymbol.
	self panesExtents at: aSymbol put: aPoint
]

{ #category : #accessing }
GLMDashboard >> defaultPaneExtent [

	^ defaultPaneExtent ifNil: [defaultPaneExtent := 300@150]
]

{ #category : #accessing }
GLMDashboard >> defaultPaneExtent: anObject [

	"so that each renderer can make specific the way to compute the default extent"
	defaultPaneExtent := anObject
]

{ #category : #accessing }
GLMDashboard >> extentOfPaneNamed: aSymbol [

	^ self panesExtents at: aSymbol ifAbsent: [
		"default extent for a pane"
		"#glamourOptimalExtent"
		self defaultPaneExtent
		]
]

{ #category : #accessing }
GLMDashboard >> extentStrategy [

	^ extentStrategy ifNil: [extentStrategy := GLMFillWidthStrategy new].
]

{ #category : #accessing }
GLMDashboard >> extentStrategy: aGLMDashboardExtentStrategy [

	extentStrategy := aGLMDashboardExtentStrategy.
]

{ #category : #scripting }
GLMDashboard >> fillWidthStrategy [

	self extentStrategy: GLMFillWidthStrategy new 
]

{ #category : #scripting }
GLMDashboard >> initializeScriptingDefaults [
	super initializeScriptingDefaults.
	self transmissions
		detect: [ :each | each originatesAt: (self pane port: #entity) ]
		ifNone: [ 
			self
				transmit to: (self panes first port: #entity);
				from: #outer port: #entity;
				andShow: [:a |  a custom: GLMFlexiblePresentation new ] ]
]

{ #category : #accessing }
GLMDashboard >> panesExtents [

	^ panesExtents ifNil: [panesExtents := Dictionary new]
]

{ #category : #rendering }
GLMDashboard >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderDashboard: self
]

{ #category : #scripting }
GLMDashboard >> rigidStrategy [

	self extentStrategy: GLMRigidStrategy new 
]
