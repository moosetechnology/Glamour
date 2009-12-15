Class {
	#name : #GLMBrowserTemplate,
	#superclass : #Object,
	#instVars : [
		'browser'
	],
	#category : #'Glamour-Examples'
}

{ #category : #opening }
GLMBrowserTemplate class >> open [
	^ self new
		open
]

{ #category : #accessing }
GLMBrowserTemplate >> browser [
	^ browser ifNil: [self buildBrowser. browser]
]

{ #category : #building }
GLMBrowserTemplate >> buildBrowser [
	^ self subclassResponsibility
]

{ #category : #opening }
GLMBrowserTemplate >> defaultEntity [
	^ self subclassResponsibility
]

{ #category : #opening }
GLMBrowserTemplate >> open [
	^ self browser openOn: self defaultEntity
]
