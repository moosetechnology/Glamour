Class {
	#name : #GLMPolyhedronForm,
	#superclass : #GLMBrickForm,
	#instVars : [
		'points'
	],
	#category : #'Glamour-Morphic-Brick-Vector'
}

{ #category : #example }
GLMPolyhedronForm class >> example [
	
	"self example"
	GLMFoundationBrick new
		addBrickBack: (self from: { 0.25@0.25. 0.75@0.25. 0.75@0.75. 0.25@0.75 } color: Color green);
		addBrickBack: (self from: { 0.25@0.25. 0.75@0.25. 0.75@0.75. 0.25@0.75 } color: Color blue);
		extent: 300@300;
		openInWindow
]

{ #category : #'instance creation' }
GLMPolyhedronForm class >> from: aCollectionOfPoint color: aColor [

	^ self new
		points: aCollectionOfPoint;
		color: aColor
]

{ #category : #'creating path' }
GLMPolyhedronForm >> pathOn: builder [
	
	builder absolute.
		
	self points do: [ :each |
		each = self points	first
			ifTrue: [ builder moveTo: each ]
			ifFalse: [ builder lineTo: each ] ].
		
	self points isEmpty ifFalse: [ builder lineTo: self points first ]
]

{ #category : #accessing }
GLMPolyhedronForm >> points [

	^ points ifNil: [ points := OrderedCollection new ]
]

{ #category : #accessing }
GLMPolyhedronForm >> points: aCollectionOfPoints [

	points := aCollectionOfPoints
]
