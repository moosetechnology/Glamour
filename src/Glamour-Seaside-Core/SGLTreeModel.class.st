Class {
	#name : #SGLTreeModel,
	#superclass : #Object,
	#instVars : [
		'roots',
		'glamourPresentation',
		'amountToShow',
		'amountShown',
		'shouldRootsExpand',
		'shouldAllExpand'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
SGLTreeModel >> amountShown [
	^ amountShown ifNil: [amountShown := 0]
]

{ #category : #accessing }
SGLTreeModel >> amountShown: anInteger [
	amountShown := anInteger 
]

{ #category : #accessing }
SGLTreeModel >> amountToShow [ 
	amountToShow ifNil: [
		amountToShow := self glamourPresentation  amountToShow ifNil: [self roots size] ].
	(amountToShow + self amountShown ) > self roots size 
		ifTrue: [amountToShow := self roots size - self amountShown ].
	^ amountToShow 
	
]

{ #category : #accessing }
SGLTreeModel >> glamourPresentation [
	^ glamourPresentation 
]

{ #category : #accessing }
SGLTreeModel >> glamourPresentation: anObject [
	glamourPresentation := anObject 
]

{ #category : #accessing }
SGLTreeModel >> roots [
	roots ifNil: [ self roots: self glamourPresentation displayValue ].
	"roots := roots select: [ :each | each shouldBeDisplayed ]. "
	^ roots
]

{ #category : #accessing }
SGLTreeModel >> roots: anObjectOrCollection [
	roots := anObjectOrCollection isCollection 
		ifTrue: [ OrderedCollection newFrom: self glamourPresentation displayValue ]
		ifFalse: [ OrderedCollection with: anObjectOrCollection]
]

{ #category : #accessing }
SGLTreeModel >> shouldAllExpand [
	^ shouldAllExpand ifNil: [shouldAllExpand := false]
]

{ #category : #accessing }
SGLTreeModel >> shouldAllExpand: anObject [
	shouldAllExpand := anObject
]

{ #category : #accessing }
SGLTreeModel >> shouldRootsExpand [
	^ shouldRootsExpand ifNil: [shouldRootsExpand := false]
]

{ #category : #accessing }
SGLTreeModel >> shouldRootsExpand: anObject [
	shouldRootsExpand := anObject
]
