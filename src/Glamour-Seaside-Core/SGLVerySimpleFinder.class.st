Class {
	#name : #SGLVerySimpleFinder,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLVerySimpleFinder class >> initialize [
	self registerAsApplication: 'glamour/finder/simpleFinder'
]

{ #category : #'as yet unclassified' }
SGLVerySimpleFinder >> browser [
	| finder |
	finder := GLMFinder new.
	finder title: 'Finder'.
	finder show: [ :a |
		a list 
			showOnly: 30;
			title: 'A Finder';
			format: #mooseName;
			send: #providerNamespaces ].
		
	^finder.
]

{ #category : #'as yet unclassified' }
SGLVerySimpleFinder >> model [
	^	MooseModel root allModels first allModelNamespaces
]
