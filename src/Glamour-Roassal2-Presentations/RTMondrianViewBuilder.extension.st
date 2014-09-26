Extension { #name : #RTMondrianViewBuilder }

{ #category : #'*Glamour-Roassal2-Presentations' }
RTMondrianViewBuilder >> openWithToolbar [
	GLMCompositePresentation new 
		title: 'Roassal painting';
		with: [:composite |
			composite roassal2 initializeView: [ self ] ];
		openOn: self
]
