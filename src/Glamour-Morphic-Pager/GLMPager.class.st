Class {
	#name : #GLMPager,
	#superclass : #Morph,
	#instVars : [
		'adapter'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPager class >> simpleExample [
	|pager adapter|
	adapter := GLMPagerPageModel new.
	pager :=	GLMPager new.
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
GLMPager >> adapter [
	^ adapter
]

{ #category : #accessing }
GLMPager >> adapter: anObject [
	adapter := anObject.
	
	self addMorphBack: (GLMPagerScrollMorph new adapter: adapter).
	self addMorphBack: (GLMPagerBarMorph new adapter: adapter).
]

{ #category : #initialization }
GLMPager >> initialize [
	super initialize.
	self changeTableLayout;
		changeListDirection: #topToBottom;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		cellPositioning: #center;
		listCentering: #center;
		wrapCentering: #center.
	
	"
	adapter addPageBack: (GTPageModel new morph: (Morph new color: Color red)).
	adapter addPageBack: (GTPageModel new morph: (Morph new color: Color green)).
	adapter addPageBack: (GTPageModel new morph: (Morph new color: Color yellow)).
	adapter addPageBack: (GTPageModel new morph: (Morph new color: Color blue)).
	adapter addPageBack: (GTPageModel new morph: (Morph new color: Color pink))."
]

{ #category : #'as yet unclassified' }
GLMPager >> popAndReplacePane: aMorph [
	adapter popAndReplacePane: aMorph
]

{ #category : #'as yet unclassified' }
GLMPager >> popPane [
	adapter popPane.
]

{ #category : #'as yet unclassified' }
GLMPager >> pushPane: aMorph [
	adapter pushPane: aMorph smooth: true.
]
