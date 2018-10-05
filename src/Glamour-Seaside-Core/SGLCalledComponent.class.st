Class {
	#name : #SGLCalledComponent,
	#superclass : #SGLComponent,
	#instVars : [
		'browser',
		'model'
	],
	#classVars : [
		'SGLBrowser',
		'SGLModel'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
SGLCalledComponent >> browser [
	^ browser
]

{ #category : #accessing }
SGLCalledComponent >> browser: aGLMBrowser [

	browser := aGLMBrowser
]

{ #category : #accessing }
SGLCalledComponent >> model [
	
	^ model ifNil: [model := self browser entity]
]

{ #category : #accessing }
SGLCalledComponent >> model: aModel [
	
	model := aModel
]
