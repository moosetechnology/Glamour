Class {
	#name : #GLMPagerModelTest,
	#superclass : #TestCase,
	#instVars : [
		'pagerModel'
	],
	#category : #'Glamour-Morphic-Pager-Tests'
}

{ #category : #private }
GLMPagerModelTest >> createSimplePaneMorph [

	^ Morph new
]

{ #category : #running }
GLMPagerModelTest >> setUp [

	pagerModel := GLMPagerPageModel new.
]

{ #category : #tests }
GLMPagerModelTest >> testEmptyPopPane [
	| count |
	
	count := 0.
	pagerModel announcer when: GLMPagePoped do: [ :ann | count := count + 1 ].
	
	pagerModel popPane.
	
	self assert: count equals: 0.
	
	self assert: pagerModel pagesCount equals: 0.
	self assert: pagerModel firstVisiblePageIndex equals: pagerModel defaultFirstVisiblePageIndex.
	self assert: pagerModel lastVisiblePageIndex equals: 0.
	self assert: pagerModel numberOfVisiblePages equals: pagerModel defaultNumberOfVisiblePages.
	
	pagerModel popPane.
	pagerModel popPane.
	
	self assert: count equals: 0.
	
]

{ #category : #tests }
GLMPagerModelTest >> testModelInitialization [

	self assert: pagerModel pagesCount equals: 0.
	self assert: pagerModel firstVisiblePageIndex equals: pagerModel defaultFirstVisiblePageIndex.
	self assert: pagerModel lastVisiblePageIndex equals: 0.
	self assert: pagerModel numberOfVisiblePages equals: pagerModel defaultNumberOfVisiblePages.
]

{ #category : #tests }
GLMPagerModelTest >> testOnePanePush [
	
	pagerModel pushPane: self createSimplePaneMorph smooth: false.
	
	self assert: pagerModel pagesCount equals: 1.
	self assert: pagerModel firstVisiblePageIndex equals: pagerModel defaultFirstVisiblePageIndex.
	self assert: pagerModel lastVisiblePageIndex equals: 1.
	self assert: pagerModel numberOfVisiblePages equals: pagerModel defaultNumberOfVisiblePages.
	
]

{ #category : #tests }
GLMPagerModelTest >> testOneReplacePane [
	
	pagerModel popAndReplacePane: self createSimplePaneMorph.

	self assert: pagerModel pagesCount equals: 1.
	self assert: pagerModel firstVisiblePageIndex equals: pagerModel defaultFirstVisiblePageIndex.
	self assert: pagerModel lastVisiblePageIndex equals: 1.
	self assert: pagerModel numberOfVisiblePages equals: pagerModel defaultNumberOfVisiblePages.
	
]

{ #category : #tests }
GLMPagerModelTest >> testOneReplacePaneAnnouncement [
	| count currentAnn paneMorph |
	
	count := 0.
	paneMorph := self createSimplePaneMorph.
	pagerModel announcer when: GLMPageSwitched do: [ :ann | count := count + 1. currentAnn := ann ].
	
	pagerModel popAndReplacePane: paneMorph.
	
	self assert: count equals: 1.
	pagerModel popAndReplacePane: self createSimplePaneMorph.
	pagerModel popAndReplacePane: self createSimplePaneMorph.
	
	self assert: count equals: 3.
	
]

{ #category : #tests }
GLMPagerModelTest >> testPanePushAnnouncement [
	| count currentAnn paneMorph |
	
	count := 0.
	paneMorph := self createSimplePaneMorph.
	pagerModel announcer when: GLMPagePushed do: [ :ann | count := count + 1. currentAnn := ann ].
	
	pagerModel pushPane: paneMorph smooth: false.
	self assert: count equals: 1.
	self assert: currentAnn morph equals: paneMorph.
	
	paneMorph := self createSimplePaneMorph.
	pagerModel pushPane: paneMorph smooth: false.
	self assert: count equals: 2.
	self assert: currentAnn morph equals: paneMorph.
	
	pagerModel pushPane: self createSimplePaneMorph smooth: false.
	pagerModel pushPane: self createSimplePaneMorph smooth: false.
	self assert: count equals: 4.
]
