Class {
	#name : #SGLTreeModel,
	#superclass : #Object,
	#instVars : [
		'roots',
		'glamourPresentation',
		'amountToShow',
		'amountShown',
		'tagsToFilterBy',
		'shouldRootsExpand',
		'shouldAllExpand'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'as yet unclassified' }
SGLTreeModel class >> with: anObject [
	^ self new item: anObject 
]

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
SGLTreeModel >> nodeModelFor: anObject [
	^ (SGLTreeNodeModel with: anObject) containerTree: self; yourself
]

{ #category : #accessing }
SGLTreeModel >> roots [
	roots ifNil: [ self roots: self glamourPresentation displayValue ].
	^ roots select: [ :each | each shouldBeDisplayed ]. "This result should be chached as this method is often called"
	
]

{ #category : #accessing }
SGLTreeModel >> roots: anObjectOrCollection [
	roots := anObjectOrCollection isCollection 
		ifTrue: [ anObjectOrCollection collect: [:each | self nodeModelFor: each ] ]
		ifFalse: [ OrderedCollection with: (self nodeModelFor: anObjectOrCollection) ]
]

{ #category : #accessing }
SGLTreeModel >> shouldAllExpand [
	^ shouldAllExpand ifNil: [shouldAllExpand := false]
]

{ #category : #accessing }
SGLTreeModel >> shouldAllExpand: anObject [
	shouldAllExpand := anObject
]

{ #category : #'as yet unclassified' }
SGLTreeModel >> shouldFilterByTag: aTag [
	^ self tagsToFilterBy includes: aTag 
]

{ #category : #accessing }
SGLTreeModel >> shouldRootsExpand [
	^ shouldRootsExpand ifNil: [shouldRootsExpand := false]
]

{ #category : #accessing }
SGLTreeModel >> shouldRootsExpand: anObject [
	shouldRootsExpand := anObject
]

{ #category : #accessing }
SGLTreeModel >> tagsToFilterBy [
	^ tagsToFilterBy ifNil: [ tagsToFilterBy := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
SGLTreeModel >> toggleFilteringByTag: aTag [ 
	(self shouldFilterByTag: aTag) 
		ifTrue: [self tagsToFilterBy remove: aTag ]
		ifFalse: [self tagsToFilterBy add: aTag].
	self updateRoots 
]

{ #category : #accessing }
SGLTreeModel >> updateRoots [
	"roots := nil."
	"self roots"
]
