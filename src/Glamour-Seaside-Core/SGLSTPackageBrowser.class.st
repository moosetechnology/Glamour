Class {
	#name : #SGLSTPackageBrowser,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLSTPackageBrowser class >> initialize [
	self registerAsApplication: 'glamour/package'
]

{ #category : #'as yet unclassified' }
SGLSTPackageBrowser >> browser [
	^ GLMSTBrowserExample new browser
]

{ #category : #'as yet unclassified' }
SGLSTPackageBrowser >> model [
	^ BrowserEnvironment new forPackageNamed: 'Glamour'
]
