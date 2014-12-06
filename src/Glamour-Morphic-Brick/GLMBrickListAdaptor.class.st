"
A GLMBrickListAdapter is an adapter to be used with GLMScrollListBrick
"
Class {
	#name : #GLMBrickListAdaptor,
	#superclass : #GLMBrickAbstractAdaptor,
	#category : #'Glamour-Morphic-Brick-Model'
}

{ #category : #'adaptor api' }
GLMBrickListAdaptor >> count [

	^ 100
]

{ #category : #'adaptor api' }
GLMBrickListAdaptor >> morphAt: anInteger convert: aMorph [

	^ (aMorph ifNil: [ GLMLabelBrick new ])
			color: Color random muchLighter;
			text: anInteger asString, ' of ', self count asString;
			yourself
]
