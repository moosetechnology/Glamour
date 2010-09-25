Class {
	#name : #GLMOBCommandAdaptor,
	#superclass : #Object,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMOBCommandAdaptor >> actionsFrom: aCollectionOfOBCommandClasses on: aTarget for: aRequestor [
	^ (aCollectionOfOBCommandClasses "select: [ :each | each isActive ]") collect: [ :each |
		| command |
		command := each on: aTarget for: aRequestor.
		GLMGenericAction new
			icon: command icon;
			title: command label;
			action: [:presentation | command execute ];
			yourself 
		]
]
