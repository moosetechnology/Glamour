Class {
	#name : #SGLTreeWithChildrenByLevel,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLTreeWithChildrenByLevel class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/treeWithChildrenByLevel'
]

{ #category : #accessing }
SGLTreeWithChildrenByLevel >> browser [
	^ GLMBasicExamples new treeWithChildrenByLevel.
]

{ #category : #accessing }
SGLTreeWithChildrenByLevel >> model [
	^ 1 to: 25
]
