Class {
	#name : #GLMBrickVectorIcons,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Vector'
}

{ #category : #util }
GLMBrickVectorIcons class >> for: aCollectionOfPoint [

	^ GLMPolyhedronForm from: aCollectionOfPoint color: Color gray
]

{ #category : #icons }
GLMBrickVectorIcons class >> play [

	^ self for: { 0@0 . 1@(3/6) . 0@1 }
]

{ #category : #icons }
GLMBrickVectorIcons class >> right [

	^ self for: { 0@(2/6) . (4.2/8)@(2/6) . (4.2/8)@0 . 1@(3/6) . (4.2/8)@1 . (4.2/8)@(4/6) . 0@(4/6) }
]
