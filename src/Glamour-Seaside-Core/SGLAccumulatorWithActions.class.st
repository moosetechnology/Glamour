Class {
	#name : #SGLAccumulatorWithActions,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLAccumulatorWithActions class >> initialize [
	self registerAsApplication: 'glamour/actions/composedAccumulatorWithActions'
]

{ #category : #accessing }
SGLAccumulatorWithActions >> browser [
	"self new browser openOn: self new model"
	
	| browser acc|
	browser := GLMTabulator new.
	browser title: 'A tabulator'.
	acc := GLMAccumulator new.
	acc title: 'An accumulator'.
	acc show: [:a |
		a title: [:x | x asString].

		a act: [:ac :entity| Transcript show: 'Accumulator action '; cr ] icon: MenuIcons helpIcon entitled: 'Accumulator action'.

		a list 
			title: 'List';
			showOnly: 10;
			act: [:list :entity| 
				Transcript show: 'List action 1 for accumulator'; cr ] icon: MenuIcons jumpIcon entitled: 'List action 1 for accumulator';

			display: [:x |1 to: x ].
		a text 
			title: 'Text'; 
			display: [:x | 'This is an editor on ', x printString ];
			act: [:list :entity| Transcript show: 'Text action 1 for accumulator'; cr ] icon: MenuIcons helpIcon  entitled: 'Text action 1 for accumulator'.
		].
	browser column: [:c | c row: #one span: 4; row: #two]; column: #three; column: #four.
	browser transmit to: #one; andShow: [:a | 
		a list 
			title: 'List presentation';
			display: [:x | x to: 10 * x]; showOnly: 10].
	browser transmit from: #one; to: #two; andShow: [:a |
		a text display: [:x | 'You have selected ', x printString, '. Double cick to open to the right']].
	browser transmit from: #one; to: #three; andShowIfNone: [:a |
		a custom: acc ].
	
	browser transmit from: #one; to: #three->#entityToSelect.
	browser transmit from: #three->#activeEntity; to: #one->#selection.
	
	browser transmit from: #three; to: #four; andShow: [ :a |
		a list display: [:x| 1 to: x]	].

	^ browser
	
]

{ #category : #accessing }
SGLAccumulatorWithActions >> model [
	^ 42
]
