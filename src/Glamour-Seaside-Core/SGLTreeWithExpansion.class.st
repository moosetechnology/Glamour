Class {
	#name : #SGLTreeWithExpansion,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #'as yet unclassified' }
SGLTreeWithExpansion class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/treeWithExpansion'
]

{ #category : #'as yet unclassified' }
SGLTreeWithExpansion >> browser [
	^ GLMBasicExamples new treeWithExpansion
]

{ #category : #'as yet unclassified' }
SGLTreeWithExpansion >> model [
	^ #(($a $b $c $d) ($e $f) ($g $h $i $j ($l $m $n)))
]
