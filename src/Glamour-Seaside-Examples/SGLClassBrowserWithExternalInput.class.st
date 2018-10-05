Class {
	#name : #SGLClassBrowserWithExternalInput,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLClassBrowserWithExternalInput class >> initialize [
	self registerAsApplication: 'glamour/development/tools/classBrowserWithExternalInput'
]

{ #category : #accessing }
SGLClassBrowserWithExternalInput >> browser [
	|browser|

	browser := GLMTabulator new.
	browser  row: #methods; row: #code.

	browser transmit to: #methods;  andShow: [ :composite |
		composite list 
			display:  [ :class | class methods ];
			format: #selector ].
		
	browser transmit from: #methods; to: #code; andShow: [:composite|
		composite text
			display: [ :method | method getSource ] ].
		
	browser transmit 
		from: #methods port: #entity; 
		fromOutsidePort: #externalSelection; 
		to: #methods port: #selection; 
		when: [:class :methodName | methodName isNil not];
		transformed: [:class :methodName| class methodDictionary at: methodName asSymbol ].
	
	^browser
]

{ #category : #accessing }
SGLClassBrowserWithExternalInput >> model [
	^ RPackageOrganizer 
]

{ #category : #'as yet unclassified' }
SGLClassBrowserWithExternalInput >> transformEntityPortValue: aString [
	^ Smalltalk at: aString asSymbol
]
