Class {
	#name : #SGLTabsWithActions,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLTabsWithActions class >> initialize [
	self registerAsApplication: 'glamour/actions/tabsWithActions'
]

{ #category : #accessing }
SGLTabsWithActions >> browser [
	|browser|
	
	browser := GLMTabulator new.
	browser column: #aColumn.

	browser transmit  to: #aColumn; andShow: [ :a |
		a title: 'Tab arrangement'.
		a list
			title: 'First';
			showOnly: 10;
			display:  [ :x | 1 to: x ];
			act: [:list :entity| Transcript show: '+1'; cr ] icon: MenuIcons projectIcon entitled: '+1';
			act: [:list :entity| Transcript show: '+2'; cr ] icon: MenuIcons jumpIcon entitled: '+2';
			act: [:list :entity| Transcript show: '+3'; cr ] icon: MenuIcons jumpIcon entitled: '+3'.
		a list
			title: 'Second';
			showOnly: 60;
			display:  [ :x | 1 to: x ];
			act: [:list :entity| Transcript show: '-1'; cr ] icon: MenuIcons publishIcon entitled: '-1';
			act: [:list :entity| Transcript show: '-2'; cr ] icon: MenuIcons jumpIcon entitled: '-2'.
		a list
			title: 'Third';
			display:  [ :x | 1 to: x ] ;
			act: [:list :entity| Transcript show: '*1'; cr ] icon: MenuIcons paintTabIcon entitled: '*1';
			act: [:list :entity| Transcript show: '*2'; cr ] icon: MenuIcons helpIcon entitled: '*2';
			act: [:list :entity| Transcript show: '*3'; cr ] icon: MenuIcons projectIcon entitled: '*3';
			act: [:list :entity| Transcript show: '*4'; cr ] icon: MenuIcons jumpIcon entitled: '*4'  ].
	^browser
]

{ #category : #accessing }
SGLTabsWithActions >> model [
	^ 18
]
