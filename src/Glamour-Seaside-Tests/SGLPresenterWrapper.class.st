Class {
	#name : #SGLPresenterWrapper,
	#superclass : #SGLComponent,
	#instVars : [
		'renderable',
		'presenter',
		'renderer'
	],
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #accessing }
SGLPresenterWrapper >> browser [
	^ self renderableObject
]

{ #category : #initialization }
SGLPresenterWrapper >> initializeFor: aRenderable [
	renderable := aRenderable.
	renderer :=  SGLRenderer new.
	presenter := SGLTextPresenter for: self browser from: renderer
]

{ #category : #initialization }
SGLPresenterWrapper >> initializeFor: aRenderable with: rendererClass [
	renderable := aRenderable.
	renderer :=  SGLRenderer new.
	presenter := rendererClass perform: #for:from: with: self browser with: renderer
]

{ #category : #accessing }
SGLPresenterWrapper >> model [

]

{ #category : #accessing }
SGLPresenterWrapper >> presenter [
	^ presenter
]

{ #category : #rendering }
SGLPresenterWrapper >> renderContentOn: html [
	self session addBrowser: self browser.
	renderer html: html.
	html render: presenter
	
]

{ #category : #accessing }
SGLPresenterWrapper >> renderableObject [
	^ renderable
]

{ #category : #accessing }
SGLPresenterWrapper >> renderableObject: anObject [
	renderable := anObject
]
