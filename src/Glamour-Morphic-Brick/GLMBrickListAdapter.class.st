Class {
	#name : #GLMBrickListAdapter,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Model'
}

{ #category : #private }
GLMBrickListAdapter >> itemMorphAt: anInteger recycled: aMorph [

	^ (aMorph ifNil: [ GLMLabelBrick new ]) 
			color: Color random muchLighter;
			text: anInteger asString;
			textPosition: #center;
			yourself
]

{ #category : #private }
GLMBrickListAdapter >> itemsCount [

	^ 4000000000
]
