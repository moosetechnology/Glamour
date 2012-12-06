Class {
	#name : #SGLDropDownListPresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'model'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'as yet unclassified' }
SGLDropDownListPresenter >> initializeFor: aPresentation [
	model := SGLDropDownListModel for: aPresentation 	
]

{ #category : #'as yet unclassified' }
SGLDropDownListPresenter >> onSelectionChangeActionWith: html [

	^ html jQuery ajax 
		callback: [ :value | 
				model selectionIndex: value asInteger + 1.
			 ] value: (JSStream on: '$(''#', (self renderer uuidFor: model glamourPresentation),  '>select'').prop(''selectedIndex'')');		
		script: [:s | 
			self renderer updateScript: s ] 
]

{ #category : #'as yet unclassified' }
SGLDropDownListPresenter >> renderContentOn: html [

	model updateSelectionIndex.

	html div 
		id: (self renderer uuidFor: model glamourPresentation );
		class: 'sgl-dropdown-presentation';
		"script: (html jQuery new glamourDropdown );"
		with: [
			html  select 
				onChange: (self onSelectionChangeActionWith: html);
        			selected:  model selectionIndex;
				with: [
					
					1 to: model list size do: [:index |
						html option
							selected: (model selectionIndex = index);
							with:  ( model list at: index )
							
						] ].

			
			]
]
