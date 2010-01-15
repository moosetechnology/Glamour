Class {
	#name : #GLMHelperTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMHelperTest >> testAsGlamorousMultiValue [
	self assert: (GLMMultiValue withAll: #(1 2 3)) = (#(1 2 3) asGlamorousMultiValue).
	self assert: 
		(1 asGlamorousMultiValue, #(2) asGlamorousMultiValue, #(3) asGlamorousMultiValue) = 
		(#(1 2 3) asGlamorousMultiValue)
]

{ #category : #'as yet unclassified' }
GLMHelperTest >> testGlamourValue [
	self assert: ([:a | a + 2 ] glamourValue: 40) = 42.
	self assert: ([:a | a + 2 ] glamourValue: 40 asGlamorousMultiValue) = 42.
	self assert: ([ 42 ] glamourValue: 40 asGlamorousMultiValue) = 42.

	self assert: ([:a | a first + a last ] glamourValue: #(40 2)) = 42.
	self assert: ([:a :b | a + b] glamourValue: #(40 2) asGlamorousMultiValue) = 42.
	self assert: ([:a | a + 2 ] glamourValue: #(40 2) asGlamorousMultiValue) = 42.
	self assert: ([ 42 ] glamourValue: #(40 2) asGlamorousMultiValue) = 42
]
