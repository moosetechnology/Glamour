Class {
	#name : #SGLSTPackageBrowser,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLSTPackageBrowser class >> initialize [
	self registerAsApplication: 'glamour/package'
]

{ #category : #accessing }
SGLSTPackageBrowser >> browser [
	^ GLMSTBrowserExample new browser
]

{ #category : #accessing }
SGLSTPackageBrowser >> model [
	^ BrowserEnvironment new forPackageNamed: 'Glamour'
]
