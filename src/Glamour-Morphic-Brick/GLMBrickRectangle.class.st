Class {
	#name : #GLMBrickRectangle,
	#superclass : #Rectangle,
	#instVars : [
		'isDirty'
	],
	#category : #'Glamour-Morphic-Brick-Utils'
}

{ #category : #testing }
GLMBrickRectangle >> isDirty [

	^ isDirty ifNil: [ isDirty := true ]
]

{ #category : #actions }
GLMBrickRectangle >> markClean [

	isDirty := false
]

{ #category : #actions }
GLMBrickRectangle >> markDitry [

	isDirty := true
]
