Class {
	#name : #SGLComposedTabulatorWithActions,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLComposedTabulatorWithActions class >> initialize [
	self registerAsApplication: 'glamour/actions/composedTabulatorWithAction'
]

{ #category : #accessing }
SGLComposedTabulatorWithActions >> browser [
	"self new browser openOn: self new model."
	|browser|

	browser := GLMTabulator new.
	browser column:  #tab; column: #accordion; column: #stack.

	browser transmit  to: #tab; andShow: [ :a |
		a title: 'Tab arrangement'.
		a act: [:list :entity| Transcript show: 'Tab arrangement action 1'; cr ] icon: MenuIcons jumpIcon entitled: 'Tab arrangement action 1'.
		a act: [:list :entity| Transcript show: 'Tab arrangement action 2'; cr ] icon: MenuIcons helpIcon  entitled: 'Tab arrangement action 2'.
		a act: [:list :entity| Transcript show: 'Tab arrangement action 3'; cr ] icon: MenuIcons jumpIcon entitled: 'Tab arrangement action 3'.
		a act: [:list :entity| Transcript show: 'Tab arrangement action 4'; cr ] icon: MenuIcons helpIcon  entitled: 'Tab arrangement action 4'.
		a list
			title: 'First';
			showOnly: 10;
			act: [:list :entity| Transcript show: 'First tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'First tab action 1';
			act: [:list :entity| Transcript show: 'First tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'First tab action 2';
			display:  [ :x | 1 to: x ].
		a list
			title: 'Second';
			showOnly: 60;
			act: [:list :entity| Transcript show: 'Second tab action 1'; cr ] icon: MenuIcons publishIcon entitled: 'Second tab action 1';
			display:  [ :x | 1 to: x ].
		a list
			title: 'Third';
			act: [:list :entity| Transcript show: 'Third tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'Third tab action 1';
			act: [:list :entity| Transcript show: 'Third tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'Third tab action 2';
			act: [:list :entity| Transcript show: 'Third tab action 3'; cr ] icon: MenuIcons paintTabIcon entitled: 'Third tab action 3';
			act: [:list :entity| Transcript show: 'Third tab action 4'; cr ] icon: MenuIcons publishIcon entitled: 'Third tab action 4';
			display:  [ :x | 1 to: x ] ].

	browser transmit  to: #accordion; andShow: [ :a |
		a accordionArrangement.
		a act: [:list :entity| Transcript show: 'Accordion arrangement action 1'; cr ] icon: MenuIcons jumpIcon entitled: 'Accordion arrangement action 1'.
		a title: 'Accordion arrangement'.
		a list
			title: 'First';
			showOnly: 10;
			act: [:list :entity| Transcript show: 'First accordion tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'First accordion tab action 1';
			act: [:list :entity| Transcript show: 'First accordion tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'First accordion tab action 2';
			act: [:list :entity| Transcript show: 'First accordion tab action 3'; cr ] icon: MenuIcons paintTabIcon entitled: 'First accordion tab action 3';
			act: [:list :entity| Transcript show: 'First accordion tab action 4'; cr ] icon: MenuIcons projectIcon entitled: 'First accordion tab action 4';
			act: [:list :entity| Transcript show: 'First accordion tab action 5'; cr ] icon: MenuIcons jumpIcon entitled: 'First accordion tab action 5';
			act: [:list :entity| Transcript show: 'First accordion tab action 6'; cr ] icon: MenuIcons paintTabIcon entitled: 'First accordion tab action 6';
			display:  [ :x | 1 to: x ].
		a list
			title: 'Second';
			showOnly: 60;
			act: [:list :entity| Transcript show: 'Second accordion tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'Second accordion tab action 1';
			act: [:list :entity| Transcript show: 'Second accordion tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'Second accordion tab action 2';
			display:  [ :x | 1 to: x ].
		a list
			title: 'Third';
			display:  [ :x | 1 to: x ] ].
		
	browser transmit  to: #stack; andShow: [ :a |
		a stackedVerticallyArrangement.
		a act: [:list :entity| Transcript show: 'Stacked arrangement action 1'; cr ] icon: MenuIcons jumpIcon entitled: 'Stacked arrangement action 1'.
		a title: 'Stack arrangement'.
		a list
			title: 'First';
			showOnly: 10;
			act: [:list :entity| Transcript show: 'First stacked tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'First stacked tab action 1';
			act: [:list :entity| Transcript show: 'First stacked tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'First stacked tab action 2';
			display:  [ :x | 1 to: x ].
		a list
			title: 'Second';
			showOnly: 60;
			display:  [ :x | 1 to: x ].
		a list
			title: 'Third';
			act: [:list :entity| Transcript show: 'Third stacked tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'Third stacked tab action 1';
			act: [:list :entity| Transcript show: 'Third stacked tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'Third stacked tab action 2';
			act: [:list :entity| Transcript show: 'Third stacked tab action 3'; cr ] icon: MenuIcons paintTabIcon entitled: 'Third stacked tab action 3';
			display:  [ :x | 1 to: x ] ].
		
	^browser 
]

{ #category : #accessing }
SGLComposedTabulatorWithActions >> model [
	^ 100

]
