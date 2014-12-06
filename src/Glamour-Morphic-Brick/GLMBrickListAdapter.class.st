"
A GLMBrickListAdapter is an adapter to be used with GLMScrollListBrick
"
Class {
	#name : #GLMBrickListAdapter,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Model'
}

{ #category : #api }
GLMBrickListAdapter >> itemMorphAt: anInteger recycled: aMorph [
	
	^ (aMorph ifNil: [ GLMLabelBrick new ]) 
			color: Color random muchLighter;
			text: anInteger asString, ' of ', self itemsCount asString;
			textPosition: #center;
			yourself
]

{ #category : #api }
GLMBrickListAdapter >> itemsCount [

	^ 4000000000
]
