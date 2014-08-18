Class {
	#name : #GLMPagerMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'pagerModel',
		'pagerMorph',
		'window'
	],
	#category : #'Glamour-Morphic-Pager-Tests'
}

{ #category : #accessing }
GLMPagerMorphTest >> buttonsMorphs [

	^ pagerMorph submorphs second submorphs second submorphs
]

{ #category : #private }
GLMPagerMorphTest >> createSimplePaneMorph [

	^ Morph new
]

{ #category : #private }
GLMPagerMorphTest >> openInWindow [

	window := pagerMorph openInWindow 
]

{ #category : #accessing }
GLMPagerMorphTest >> panesMorphs [

	^ pagerMorph submorphs first panes
]

{ #category : #running }
GLMPagerMorphTest >> setUp [

	pagerModel := GLMPagerModel new.
	pagerMorph := GLMPagerMorph new
		pagerModel: pagerModel
		yourself.
]

{ #category : #running }
GLMPagerMorphTest >> tearDown [

	window ifNotNil: [ window delete ]
]

{ #category : #tests }
GLMPagerMorphTest >> testPushPanesAfterOpen [

	pagerModel pushPane: self createSimplePaneMorph smooth: false.
	self openInWindow.
	pagerModel pushPane: self createSimplePaneMorph smooth: false.
	pagerModel pushPane: self createSimplePaneMorph smooth: false.
	
	self assert: pagerModel size equals: 3.
	self assert: self panesMorphs size equals: 3.
	self assert: self buttonsMorphs size equals: 3.
	
	

]

{ #category : #tests }
GLMPagerMorphTest >> testPushPanesBeforeOpen [

	pagerModel pushPane: self createSimplePaneMorph smooth: false.
	pagerModel pushPane: self createSimplePaneMorph smooth: false.
	pagerModel pushPane: self createSimplePaneMorph smooth: false.

	self openInWindow.
	
	self assert: pagerModel size equals: 3.
	self assert: self panesMorphs size equals: 3.
	self assert: self buttonsMorphs size equals: 3.
	
	

]
