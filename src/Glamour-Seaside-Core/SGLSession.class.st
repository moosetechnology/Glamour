Class {
	#name : #SGLSession,
	#superclass : #WASession,
	#instVars : [
		'browsers'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
SGLSession >> addBrowser: aBrowser [
	self browsers add: aBrowser
]

{ #category : #accessing }
SGLSession >> browsers [
	^ browsers ifNil: [browsers := OrderedCollection new]
]

{ #category : #'parent/child' }
SGLSession >> unregistered [
	super unregistered.
	self browsers do: [:each| each unregisterFromAllAnnouncements].
	browsers := nil
]
