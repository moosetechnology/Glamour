Class {
	#name : #SGLDefaultComponent,
	#superclass : #SGLComponent,
	#classVars : [
		'SGLModel',
		'SGLBrowser'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #initialization }
SGLDefaultComponent class >> initialize [
	| application |
	application := self registerAsApplication: 'glamour/pluggable'.
	application parent defaultName: application name
]

{ #category : #public }
SGLDefaultComponent class >> register: aBrowser on: aModel [
	SGLBrowser := aBrowser.
	SGLModel := aModel
]

{ #category : #accessing }
SGLDefaultComponent >> browser [
	^ SGLBrowser
]

{ #category : #accessing }
SGLDefaultComponent >> model [
	^ SGLModel
]
