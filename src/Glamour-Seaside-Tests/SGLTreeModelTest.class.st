Class {
	#name : #SGLTreeModelTest,
	#superclass : #TestCase,
	#instVars : [
		'presentation',
		'model'
	],
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLTreeModelTest >> setUp [
	super setUp.

	presentation := GLMTreePresentation new.
	model := SGLTreeModel for: presentation
]

{ #category : #testing }
SGLTreeModelTest >> testAmountToFilterByWithShowOnly [
	presentation showOnly: 20.
	self assert: model amountToFilterBy == 20.
	model amountToFilterBy: 10.
	self assert: model amountToFilterBy == 10.
]

{ #category : #testing }
SGLTreeModelTest >> testAmountToFilterByWithStepSize [
	presentation showOnly: 20.
	model stepSize: 14.
	self assert: model amountToFilterBy == 14
]

{ #category : #testing }
SGLTreeModelTest >> testAnnouncerslInitialization [
	| count selection |
	count := 0. 
	selection := MorphTreeMorphSingleSelection new selectedNodePath: nil.
	model announcer on: GLMTreeMorphSelectionChanged do: [ :ann | count := count +1].
	model selection: selection.
	model selection: selection.
	self assert: count = 1.
	model selection: (MorphTreeMorphSingleSelection new selectedNodePath: nil).
	self assert: count ==2
]

{ #category : #testing }
SGLTreeModelTest >> testModelInitialization [
	self assert: model glamourPresentation == presentation.
	self assert: model shouldAllExpand == false.
	self assert: model shouldRootsExpand == false.
	self assert: model amountToFilterBy == 0.
	self assert: model stepSize == 0.
	self assert: model announcer notNil.
]

{ #category : #testing }
SGLTreeModelTest >> testRootsWithFilterByAmount [
	|roots entities|
	presentation entity: (1 to: 100).
	presentation showOnly: 20.
	roots := model roots.
	self assert: roots size == 20.
	self assert: model allRoots size == 100.
	entities := OrderedCollection new.
	roots do: [:each| entities add: each item].
	self assert: entities = (1 to: 20) asOrderedCollection.
	entities := OrderedCollection new.
	model allRoots do: [:each| entities add: each item].
	self assert: entities = (1 to: 100) asOrderedCollection
]

{ #category : #testing }
SGLTreeModelTest >> testRootsWithoutFilterByAmount [
	|roots entities|
	presentation entity: (1 to: 100).
	roots := model roots.
	self assert: roots size == 100.
	self assert: model allRoots size == 100.
	entities := OrderedCollection new.
	roots do: [:each| entities add: each item].
	self assert: entities = (1 to: 100) asOrderedCollection.
	entities := OrderedCollection new.
	model allRoots do: [:each| entities add: each item].
	self assert: entities = (1 to: 100) asOrderedCollection  
]

{ #category : #testing }
SGLTreeModelTest >> testShouldFilterByAmountWithShowOnly [
	presentation showOnly: 2.
	self assert: model shouldFilterByAmount == true.
]

{ #category : #testing }
SGLTreeModelTest >> testShouldFilterByAmountWithStepSize [
	model stepSize: 2.
	self assert: model shouldFilterByAmount == true.
]

{ #category : #testing }
SGLTreeModelTest >> testSimpleSelection [
	| count selection selectionPath |
	count := 0.
	presentation entity: (1 to: 10).
	presentation children: [:item :x :level | 
				level > 2 ifTrue: [#()] ifFalse: [ (item*10+1) to: (item*10 + 9) ] ].
	model announcer on: GLMTreeMorphSelectionChanged do: [ :ann | 
		count := count +1.
		selection := ann selectionValue.
		selectionPath := ann selectionPathValue ].
	model explicitSelection: 342.
	model explicitSelection: 342.
	self assert: count = 1.
	self assert: selection = 342.
	self assert: (selectionPath = (OrderedCollection with: 3 with:  34 with:  342)).
]

{ #category : #testing }
SGLTreeModelTest >> testStepSizeWithShowOnly [
	presentation showOnly: 20.
	self assert: model stepSize == 20.
	model stepSize: 10.
	self assert: model stepSize == 10.
]
