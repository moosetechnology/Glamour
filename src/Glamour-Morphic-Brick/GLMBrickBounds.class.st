Class {
	#name : #GLMBrickBounds,
	#superclass : #Object,
	#instVars : [
		'bounds',
		'state'
	],
	#category : #'Glamour-Morphic-Brick-Utils'
}

{ #category : #accessing }
GLMBrickBounds >> bounds [

	^ bounds ifNil: [ bounds := 0@0 corner: 50@50 ]
]

{ #category : #accessing }
GLMBrickBounds >> bounds: aRectangle [

	bounds := aRectangle.
	self markDirty
]

{ #category : #testing }
GLMBrickBounds >> isClean [

	^ self state = #clean
]

{ #category : #testing }
GLMBrickBounds >> isDirty [

	^ self state = #dirty
]

{ #category : #marking }
GLMBrickBounds >> markClean [

	self state: #clean
]

{ #category : #marking }
GLMBrickBounds >> markDirty [

	self state: #dirty
]

{ #category : #accessing }
GLMBrickBounds >> state [

	^ state ifNil: [ state := #dirty ]
]

{ #category : #accessing }
GLMBrickBounds >> state: aSymbol [

	state := aSymbol
]
