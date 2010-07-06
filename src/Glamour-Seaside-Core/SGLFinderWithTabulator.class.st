Class {
	#name : #SGLFinderWithTabulator,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLFinderWithTabulator class >> initialize [
	self registerAsApplication: 'glamour/finder/finderWithTabulator'
]

{ #category : #'as yet unclassified' }
SGLFinderWithTabulator >> browser [
	|innerBrowser finder|
	innerBrowser := GLMTabulator new.
	innerBrowser row: #methods; row: #source.
	innerBrowser transmit to: #methods; andShow: [ :a | 
		a list
			title: [:each | 'Methods invoking ', each name ];
			display: #invokingMethods ;
			showOnly: 50;
			format: #mooseName ].
	innerBrowser transmit from: #methods; to: #source; andShow: [:a |
		a text display: #sourceText ].
	
	innerBrowser transmit from: #methods; toOutside: #selection.
	
	finder  := GLMFinder new.
	finder title: [ :each | 'Reference browser on ', each mooseName ].
	finder show: [ :a |
		a custom: innerBrowser ].
	
	^finder
]

{ #category : #'as yet unclassified' }
SGLFinderWithTabulator >> model [
	 ^ (MooseModel root allModels first allMethods entityNamed: #'org::argouml::model::Facade.getName()' )
]
