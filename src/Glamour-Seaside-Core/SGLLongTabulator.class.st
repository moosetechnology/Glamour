Class {
	#name : #SGLLongTabulator,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLLongTabulator class >> initialize [
	self registerAsApplication: 'glamour/tabulator/longTabulator'
]

{ #category : #'as yet unclassified' }
SGLLongTabulator >> browser [
	|browser|
	browser := GLMTabulator new.
	browser column:  #col1; column:  #col2; column: #col3.
	browser transmit to: #col1; andShow: [ :a | 
		a list
			title: [:each | 'Methods invoking ', each name ];
			display: #invokingMethods ;
			format: #mooseName;
			showOnly: 30 ].
	browser transmit to: #col2; andShow: [ :a | 
		a list
			title: [:each | 'Methods invoking ', each name ];
			display: #invokingMethods ;
			format: #mooseName;
			showOnly: 200 ].
	browser transmit to: #col3; andShow: [ :a | 
		a list
			title: [:each | 'Methods invoking ', each name ];
			display: #invokingMethods ;
			format: #mooseName ].
	
	^browser
]

{ #category : #'as yet unclassified' }
SGLLongTabulator >> model [
	^ (MooseModel root allModels first allMethods entityNamed: #'org::argouml::model::Facade.getName()' )
]
