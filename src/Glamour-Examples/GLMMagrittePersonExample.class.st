Class {
	#name : #GLMMagrittePersonExample,
	#superclass : #Object,
	#instVars : [
		'name',
		'address'
	],
	#classVars : [
		'SampleData'
	],
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample class >> sampleData [
	"self new magritteAddressBook openOn: self new magritteAddressBookModel "
	SampleData ifNil: 
	[
		SampleData := GLMAnnouncingCollection new.
		SampleData add: (GLMMagrittePersonExample new name: 'William Shakespeare' ; address: 'Stratford-upon-Avon' ).
		SampleData add: (GLMMagrittePersonExample new name: 'Victor Hugo' ; address: 'Besançon' ).
		SampleData add: (GLMMagrittePersonExample new name: 'Mark Twain' ; address: 'Florida' ).
		SampleData add: (GLMMagrittePersonExample new name: 'Banjo Paterson' ; address: 'Narrambla' ).
	].
	^SampleData
	

]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample class >> sampleReset [
	SampleData := nil.

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
GLMMagrittePersonExample >> exampleSupportIdentityInSample [
	^ self class sampleData includes: self.
	
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
	self exampleSupportIdentityInSample 
		ifTrue: [ aStream nextPutAll: ' #original# '] 
		ifFalse: [ aStream nextPutAll: ' #copy# '].
	super printOn: aStream.
]
