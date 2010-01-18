Class {
	#name : #GLMAnnouncingCollection,
	#superclass : #Announcer,
	#instVars : [
		'collection'
	],
	#category : #'Glamour-Examples'
}

{ #category : #initialization }
GLMAnnouncingCollection >> add: anObject [

	collection add: anObject.
	self announce: GLMItemAdded
]

{ #category : #initialization }
GLMAnnouncingCollection >> at: anObject [

	^collection at: anObject
]

{ #category : #private }
GLMAnnouncingCollection >> collect: aBlock [
	^collection collect: aBlock
	
]

{ #category : #initialization }
GLMAnnouncingCollection >> do: aBlock [

	^collection do: aBlock
]

{ #category : #private }
GLMAnnouncingCollection >> includes: anObject [ 
	^collection includes: anObject
]

{ #category : #initialization }
GLMAnnouncingCollection >> initialize [

	collection := OrderedCollection new
]

{ #category : #initialization }
GLMAnnouncingCollection >> isCollection [

	^true
]

{ #category : #initialization }
GLMAnnouncingCollection >> printString [
	^ collection printString 
]

{ #category : #initialization }
GLMAnnouncingCollection >> remove: anObject [

	collection remove: anObject.
	self announce: GLMItemRemoved
]

{ #category : #initialization }
GLMAnnouncingCollection >> withIndexDo: aBlock [

	^collection withIndexDo: aBlock
]
