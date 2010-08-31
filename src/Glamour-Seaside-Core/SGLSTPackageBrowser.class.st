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
	"self new browser openOn: self new model"
	^ GLMSTBrowserExample new browser
]

{ #category : #accessing }
SGLSTPackageBrowser >> model [
	^ BrowserEnvironment new forPackageNamed: 'Glamour'
]
