Class {
	#name : #GLMAsyncTaskChain,
	#superclass : #Object,
	#instVars : [
		'tasks'
	],
	#category : #'Glamour-Morphic-Brick-Async'
}

{ #category : #scripting }
GLMAsyncTaskChain >> execute [

	self tasks do: #execute
]

{ #category : #scripting }
GLMAsyncTaskChain >> executeAt: anInteger [

	^ (self tasks at: anInteger) execute
]

{ #category : #scripting }
GLMAsyncTaskChain >> executeFirst: anInteger [

	(self tasks first: (anInteger min: self tasks size))
		do: #execute
]

{ #category : #scripting }
GLMAsyncTaskChain >> task [

	^ self tasks add: GLMAsyncTask new
]

{ #category : #accessing }
GLMAsyncTaskChain >> tasks [

	^ tasks ifNil: [ tasks := OrderedCollection new ]
]
