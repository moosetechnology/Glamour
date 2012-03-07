Class {
	#name : #GLMMagrittePersonExample,
	#superclass : #Object,
	#instVars : [
		'name',
		'address'
	],
	#classVars : [
		'Sample1'
	],
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample class >> sample1 [
	"self new magritteAddressBook openOn: self new magritteAddressBookModel "
	Sample1 ifNil: 
	[
		Sample1 := OrderedCollection new.
		Sample1 add: (GLMMagrittePersonExample new name: 'William Shakespeare' ; address: 'Stratford-upon-Avon' ).
		Sample1 add: (GLMMagrittePersonExample new name: 'Victor Hugo' ; address: 'Besançon' ).
		Sample1 add: (GLMMagrittePersonExample new name: 'Mark Twain' ; address: 'Florida' ).
		Sample1 add: (GLMMagrittePersonExample new name: 'Banjo Paterson' ; address: 'Narrambla' ).
	].
	^Sample1
	

]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample class >> sample1Reset [
	
	| oldSample newSample |
	"oldSample := self sample1."
	Sample1 := nil.
"	newSample := self sample1.
	oldSample become: newSample."
]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample >> address [
	^ address
]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample >> address: aString [
	address := aString
]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample >> descriptionAddress [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #address;
		label: 'Address';
		yourself
]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample >> descriptionContainer [
	<magritteContainer>
	^ super descriptionContainer
		propertyAt: #containerBase put: nil;
		yourself
]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #name;
		label: 'Name';
		yourself
]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample >> identityInSample1 [
	^ self class sample1 includes: self.
	
]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample >> name [
	^ name
]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample >> name: aString [
	name := aString
]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample >> printOn: aStream [
	aStream nextPutAll: '('.
	self name printOn: aStream.
	aStream nextPutAll: ','.
	self address printOn: aStream.
	aStream nextPutAll: ')'.
	self identityInSample1 
		ifTrue: [ aStream nextPutAll: ' #original# '] 
		ifFalse: [ aStream nextPutAll: ' #copy# '].
	super printOn: aStream.
]
