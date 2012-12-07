Class {
	#name : #SGLDropDownListPresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'model'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'jQuery-scripts' }
SGLDropDownListPresenter >> dropDownInitializationScriptWith: html [

	^ html jQuery new glamourDropdown
		selectedIndex: self model selectionIndex - 1;
		onSelectionChanged: (self onSelectionChangeActionWith: html)
]

{ #category : #initialization }
SGLDropDownListPresenter >> initializeFor: aPresentation [
	model := SGLDropDownListModel for: aPresentation 	
]

{ #category : #accessing }
SGLDropDownListPresenter >> model [
	
	^ model
]

{ #category : #'jQuery-scripts' }
SGLDropDownListPresenter >> onSelectionChangeActionWith: html [

	^ html jQuery ajax 
		callback: [ :value | self model selectionIndex: value asInteger + 1] 
			value: (self selectedIndexScriptWith: html);
		script: [:s | self renderer updateScript: s ];
		asFunction 
]

{ #category : #accessing }
SGLDropDownListPresenter >> presentationId [

	^ self renderer uuidFor: self model glamourPresentation
]

{ #category : #rendering }
SGLDropDownListPresenter >> renderContentOn: html [

	self model updateSelectionIndex.

	html div 
		id: self presentationId;
		class: 'sgl-dropdown-presentation';
		script: (self dropDownInitializationScriptWith: html);
		with: [ self renderOptionsOn: html ]
]

{ #category : #rendering }
SGLDropDownListPresenter >> renderOptionWithIndex: anIndex andValue: aValue on: html [

	html option
		with:  aValue
]

{ #category : #rendering }
SGLDropDownListPresenter >> renderOptionsOn: html [

	html select 
		with: [		
			1 to: self model list size do: [:index |
				self renderOptionWithIndex: index andValue: (self model list at: index) on: html ] ].

]

{ #category : #'jQuery-scripts' }
SGLDropDownListPresenter >> selectedIndexScriptWith: html [

	^ (html jQuery id: self presentationId) 
				children: 'select'; 
				propertyAt: 'selectedIndex'
]
