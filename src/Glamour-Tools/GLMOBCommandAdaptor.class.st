Class {
	#name : #GLMOBCommandAdaptor,
	#superclass : #Object,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMOBCommandAdaptor >> actionsFrom: aCollectionOfOBCommandClasses on: aTarget for: aRequestor [
	| command |
	^ (aCollectionOfOBCommandClasses "select: [ :each | each isActive ]") collect: [ :each |
		command := each on: aTarget for: aRequestor.
		GLMAction new
			icon: command icon;
			title: command label;
			action: [:presentation | command execute ];
			yourself 
		]
]
