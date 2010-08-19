Class {
	#name : #SGLBasicExamples,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLBasicExamples class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/all'
]

{ #category : #accessing }
SGLBasicExamples >> browser [
	"self new browser openOn: self new model"

	^ self wrappedClass browser
]

{ #category : #accessing }
SGLBasicExamples >> model [
	^ self wrappedClass model.
]

{ #category : #accessing }
SGLBasicExamples >> wrappedClass [
	^ GLMBasicExamples
]
