Class {
	#name : #SGLThreeInterdependentPanes,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'instance creation' }
SGLThreeInterdependentPanes class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/threeInterdependentPanes'
]

{ #category : #accessing }
SGLThreeInterdependentPanes >> browser [
	"self new browser openOn: self new model."

	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser showOn: #one; using: [
		browser tree
			title: 'Pane 1';
			display: [:x | 1 to: x]].
	browser showOn: #two; from: #one; using: [ 
		browser tree
			title: 'Pane 2';
			display: [:x | 1 to: x*2]].
	browser showOn: #three; from: #two; using: [
		browser tree
			title: 'Pane 3';
			display: [:x | 1 to: x*3];
			populate: #focus icon: MenuIcons projectIcon entitled: 'Focus' with: [:list | list selection] ].
	browser sendTo: #outer->#focus from: #three->#focus with: [:x | x ].
	browser sendTo: #one->#selection from: #outer->#focus with: [:x | x ].
	browser sendTo: #two->#selection from: #outer->#focus with: [:x | x ].
	^ browser
	
]

{ #category : #accessing }
SGLThreeInterdependentPanes >> model [
	^ 5
]
