Class {
	#name : #GLMEyeSeeExample,
	#superclass : #Object,
	#category : #'Glamour-EyeSee-Presentations'
}

{ #category : #'as yet unclassified' }
GLMEyeSeeExample >> eyeseeBarDiagram [
	<glmBrowser: 'EyeSee interactive bar chart' input: '#(5 2 10 6 12 8)'>
	"self new eyeseeBarDiagram openOn: #(5 2 10 6 12 8)."
	| browser |

	browser := GLMTabulator new.
	browser row: #one span: 3; row: #two.
	browser transmit to: #one; andShow: [:a |
	       a eyesee
			title: 'Sample bar chart';
			diagram: [:renderer :x |
	                       renderer verticalBarDiagram
						y: #yourself;
						models: x;
						width: 200;
						height: 150;
						baseAxisLine.
					renderer interaction popupText: #yourself ]].
	browser transmit from: #one; to: #two; andShow: [:a | 
		a text
			title: 'Preview'].
	^ browser
]
