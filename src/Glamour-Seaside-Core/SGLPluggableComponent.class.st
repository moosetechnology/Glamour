Class {
	#name : #SGLPluggableComponent,
	#superclass : #SGLComponent,
	#classVars : [
		'SGLModel',
		'SGLBrowser'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #initialization }
SGLPluggableComponent class >> initialize [
	| application |
	application := self registerAsApplication: 'glamour/pluggable'.
	application parent defaultName: application name
]

{ #category : #public }
SGLPluggableComponent class >> register: aBrowser on: aModel [
	SGLBrowser := aBrowser.
	SGLModel := aModel
]

{ #category : #accessing }
SGLPluggableComponent >> browser [
	^ SGLBrowser
]

{ #category : #accessing }
SGLPluggableComponent >> model [
	^ SGLModel
]
