Class {
	#name : #SGLTabsWithActions,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLTabsWithActions class >> initialize [
	self registerAsApplication: 'glamour/actions/tabsWithActions'
]

{ #category : #'as yet unclassified' }
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
			act: [:list :entity| Transcript show: '+1'; cr ] entitled: '+1';
			act: [:list :entity| Transcript show: '+2'; cr ] entitled: '+2';
			act: [:list :entity| Transcript show: '+3'; cr ] entitled: '+3'.
		a list
			title: 'Second';
			showOnly: 60;
			display:  [ :x | 1 to: x ];
			act: [:list :entity| Transcript show: '-1'; cr ] entitled: '-1';
			act: [:list :entity| Transcript show: '-2'; cr ] entitled: '-2'.
		a list
			title: 'Third';
			display:  [ :x | 1 to: x ] ;
			act: [:list :entity| Transcript show: '*1'; cr ] entitled: '*1';
			act: [:list :entity| Transcript show: '*2'; cr ] entitled: '*2';
			act: [:list :entity| Transcript show: '*3'; cr ] entitled: '*3';
			act: [:list :entity| Transcript show: '*4'; cr ] entitled: '*4'  ].
	^browser
]

{ #category : #'as yet unclassified' }
SGLTabsWithActions >> model [
	^ 18
]
