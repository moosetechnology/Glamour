Class {
	#name : #GLMPagerMorph,
	#superclass : #Morph,
	#instVars : [
		'adapter'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerMorph class >> simpleExample [
	|pager adapter|
	adapter := GLMPagerModel new.
	pager :=	GLMPagerMorph new.
	pager adapter: adapter.
	
	pager pushPane: (Morph new color: Color red).
	pager pushPane: (Morph new color: Color green).
	pager pushPane: (Morph new color: Color yellow).
	pager pushPane: (Morph new color: Color blue).
	pager pushPane: (Morph new color: Color pink).
	pager pushPane: (Morph new color: Color red).
	pager pushPane: (Morph new color: Color green).
	pager pushPane: (Morph new color: Color yellow).
	pager pushPane: (Morph new color: Color blue).
	pager pushPane: (Morph new color: Color pink).
	
	pager height: 777.
	pager width: 1337.
	pager openInWindow.
	
	"pager inspect."
]

{ #category : #accessing }
GLMPagerMorph >> adapter [
	^ adapter
]

{ #category : #accessing }
GLMPagerMorph >> adapter: anObject [
	adapter := anObject.
	
	self addMorphBack: (GLMPagerScrollMorph new adapter: adapter).
	self addMorphBack: (GLMPagerBarMorph new adapter: adapter).
]

{ #category : #initialization }
GLMPagerMorph >> initialColorInSystemWindow: aSystemWindow [
	"Answer the colour the receiver should be when added to a SystemWindow."

	^ Color transparent
]

{ #category : #initialization }
GLMPagerMorph >> initialize [
	super initialize.
	self changeTableLayout;
		changeListDirection: #topToBottom;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		cellPositioning: #center;
		listCentering: #center;
		wrapCentering: #center
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> popAndReplacePane: aMorph [
	adapter popAndReplacePane: aMorph
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> popPane [
	adapter popPane.
]

{ #category : #'as yet unclassified' }
GLMPagerMorph >> pushPane: aMorph [
	
	adapter pushPane: aMorph smooth: true.
	
]
