Class {
	#name : #SGLTreeWithAmountFiltering,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLTreeWithAmountFiltering class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/treeWithAmountFiltering'
]

{ #category : #accessing }
SGLTreeWithAmountFiltering >> browser [
	^ GLMBasicExamples new treeWithAmountFiltering 
]

{ #category : #accessing }
SGLTreeWithAmountFiltering >> model [
	^ 1 to: 10000
]
