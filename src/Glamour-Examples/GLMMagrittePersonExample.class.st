Class {
	#name : #GLMMagrittePersonExample,
	#superclass : #Object,
	#instVars : [
		'name',
		'address'
	],
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample class >> sample1 [
	"self new magritteAddressBook openOn: self new magritteAddressBookModel "
	| model |
	model := OrderedCollection new.
	model add: (GLMMagrittePersonExample new name: 'William Shakespeare' ; address: 'Stratford-upon-Avon' ).
	model add: (GLMMagrittePersonExample new name: 'Victor Hugo' ; address: 'Besançon' ).
	model add: (GLMMagrittePersonExample new name: 'Mark Twain' ; address: 'Florida' ).
	model add: (GLMMagrittePersonExample new name: 'Banjo Paterson' ; address: 'Narrambla' ).
	^ model.
	

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
GLMMagrittePersonExample >> name [
	^ name
]

{ #category : #'as yet unclassified' }
GLMMagrittePersonExample >> name: aString [
	name := aString
]
