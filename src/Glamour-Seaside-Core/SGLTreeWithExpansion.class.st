Class {
	#name : #SGLTreeWithExpansion,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLTreeWithExpansion class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/treeWithExpansion'
]

{ #category : #accessing }
SGLTreeWithExpansion >> browser [
	^ GLMBasicExamples new treeWithExpansion
]

{ #category : #accessing }
SGLTreeWithExpansion >> model [
	^ #(($a $b $c $d) ($e $f) ($g $h $i $j ($l $m $n)))
]
