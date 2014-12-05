Class {
	#name : #GLMBrickListAdapter,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Model'
}

{ #category : #private }
GLMBrickListAdapter >> itemMorphAt: anInteger recycled: aMorph [
	|item|
	item := aMorph ifNil: [ GLMLabelBrick new ].
	
	^ item color: Color random muchLighter; text: anInteger asString; textPosition: #center; yourself
]

{ #category : #private }
GLMBrickListAdapter >> itemsCount [

	^ 2000000
]
