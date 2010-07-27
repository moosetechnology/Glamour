Class {
	#name : #SGLTreePresenter,
	#superclass : #WAPresenter,
	#instVars : [
		'renderer',
		'model',
		'htmlId'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'instance creation' }
SGLTreePresenter class >> for: aModel with: aRenderer [
	^ self basicNew initializeFor: aModel with: aRenderer 
]

{ #category : #selection }
SGLTreePresenter >> explicitSelection: anObject from: aPresentationModel [
	"anObject is a node or a collection of nodes"
	aPresentationModel glamourPresentation isMultiple 
		ifTrue: [ 
			|nodesPaths|
			nodesPaths := OrderedCollection new.
			anObject isCollection 
				ifTrue: [ anObject do: [:each | nodesPaths add: each path ] ] 
				ifFalse: [nodesPaths add: anObject path]. 
			aPresentationModel selection: (MorphTreeMorphMultipleSelection new selectedNodePathList: nodesPaths ) ]
		ifFalse: [ aPresentationModel selection: (MorphTreeMorphSingleSelection new selectedNodePath: anObject path). ]
]

{ #category : #accessing }
SGLTreePresenter >> htmlId [
	^ htmlId
]

{ #category : #accessing }
SGLTreePresenter >> htmlId: anObject [
	htmlId := anObject
]

{ #category : #initialization }
SGLTreePresenter >> initializeFor: aModel with: aRenderer [
	self initialize.
	model := aModel.
	renderer := aRenderer
]

{ #category : #actions }
SGLTreePresenter >> onClickActionForAppendButtonOn: html [
	^ html jQuery ajax
		script: [ :s | 
			(model roots size > model amountShown) 
				ifTrue: [ "Load the required elements"
					s << (  (s jQuery id: self htmlId) children: '.glm-tree-root-ct' ) 
						append: [:h |
							self renderRootNodesBeginningWith: model amountShown+1 on: h ] ] .
			(model roots size > model amountShown) 
				ifFalse: [  "Disable the button for loading content"
					s << ( (s jQuery id: self htmlId) children: '.glm-tree-append-button'  ) attributeAt: 'disabled' put: true ].
			s << (JSStream new 
				nextPutAll: 'Glamour.tree.addRootIcon'; 
				arguments: (Array with: '#', self htmlId,  ' > .glm-tree-root-ct' with: 0 ) ) ] 
]

{ #category : #actions }
SGLTreePresenter >> onClickActionForNode: aNode withContent: aBlock on: html [
	|rendered|
	rendered := aNode contents size > 0 and: [ aNode expanded ].
	
	^ html jQuery ajax script: [:s | 
		rendered "Render the node childrens or just update the model"
			ifTrue: [
				aNode expanded 
					ifTrue: [aNode expanded: false] 
					ifFalse: [aNode expanded: true] ] 
			ifFalse: [
				s << aBlock value.
				aNode expanded: true.
				rendered := true ].
		"Update the selection load the modifications"
		self updateSelectionWithNode: aNode on: s ] 

]

{ #category : #actions }
SGLTreePresenter >> onClickActionForTag: aTag of: aNode on: html [
	^ html jQuery ajax script: [:s | 
		aNode containerTree toggleFilteringByTag: aTag.
		s << ( html jQuery id: (self renderer uuidFor: aNode containerTree glamourPresentation ) )
			replaceWith: [ :h |
				self renderContentOn: h ] ] 
]

{ #category : #rendering }
SGLTreePresenter >> renderAppendButtonOn: html [
	html submitButton
		onClick: (self onClickActionForAppendButtonOn: html);
		disabled: false;
		class: 'glm-tree-append-button';
         	with: 'Append'
]

{ #category : #rendering }
SGLTreePresenter >> renderContentOn: html [
	self renderer widgetContainer
		class: 'list-presentation';
		id: self htmlId;
		with: [
			self renderInitialRootNodesOn: html.
			(model roots size > model amountShown) ifTrue: [ "Add a button for loading the remaining elements"
				self renderAppendButtonOn: html ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderInitialRootNodesOn: html [
	|listId|
	listId := html nextId.
	html unorderedList   
		class: 'glm-tree-root-ct';
		id: listId;
		script:  (JSStream new 
			nextPutAll: 'Glamour.tree.bindEvents'; 
			arguments: (Array with: listId with: 0 ) );
		with: [ self renderRootNodesBeginningWith: 1 on: html ]
]

{ #category : #rendering }
SGLTreePresenter >> renderNode: aNode fromLevel: level on: html [
	|childrens|
	aNode htmlId: html nextId.
	childrens := aNode contents.
	html listItem  
		id: aNode htmlId;  
		class: 'glm-tree-node';
		class: 'glm-tree-leaf' if: childrens size == 0;
		class: 'glm-tree-open' if: (childrens size > 0 and: [aNode expanded]);
		class: 'glm-tree-closed' if: (childrens size > 0 and: [aNode expanded not]);
		with: [
			self renderNodeTitleFor: aNode 
				withContent: [
					(html jQuery id: aNode htmlId) append: [:h | 
						self renderNodes: childrens asListFromLevel: level+1 on: h ] ]
				on: html.
			(childrens size > 0 and: [ aNode expanded] ) ifTrue: [ 
				self renderNodes: childrens asListFromLevel: level+1 on: html ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderNodeTitleFor: aNode withContent: aBlock on: html [
	html div
		class: 'glm-tree-node-el';
		onClick: (self onClickActionForNode: aNode withContent: aBlock on: html);
		with: [ 
			html span with: [
				html span
					with: aNode displayText. 
				self renderTagsOf: aNode on: html ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderNodes: nodes asListFromLevel: level on: html [
	html unorderedList 
		id: html nextId;
		script: (JSStream new 
					nextPutAll: 'Glamour.tree.bindEvents'; 
					arguments: (Array with: html lastId with: level ) );
		class: 'glm-tree-node-ct';
		with: [ nodes do: [:each | 
			self renderNode: each fromLevel: level on: html ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderRootNodesBeginningWith: startIndex on: html [
	"Render the first 'amountToShow' elements starting from the one with the index 'startIndex'"
	
	|endIndex nodes|
	nodes := model roots.
	(startIndex == 1 and: [model amountShown ~= 0 ] ) 
		ifTrue: [ endIndex  := model amountShown min: model roots size ] 
		ifFalse: [ endIndex := startIndex+model amountToShow-1 ].
	(startIndex to: endIndex) do: [ :each |   
			self renderNode: (nodes at: each)  fromLevel: 0 on: html ].
	(startIndex == 1 and: [model amountShown ~= 0 ] ) 
		ifTrue: [
			 model amountShown: (model amountShown max: endIndex) ]  
		ifFalse: [
			model amountShown: model amountToShow + model amountShown ] 
]

{ #category : #rendering }
SGLTreePresenter >> renderTag: aTag withFilter: aFilter for: aNode on: html [
	html div
		class: 'glm-tree-tag ui-corner-top ui-corner-bottom';
		class: 'glm-tree-tag-selected' if: ( aNode containerTree tagsToFilterBy includes: aTag );
		onClick: (self onClickActionForTag: aTag of: aNode on: html);
		onClick: JQEvent new stopPropagation, JQEvent new preventDefault;
		with: aTag asString 
]

{ #category : #rendering }
SGLTreePresenter >> renderTagsOf: aNode on: html [
	| tags tagsFilter |
	tags:= aNode containerTree glamourPresentation tagsFor: aNode item to: #show.
	tagsFilter := aNode containerTree glamourPresentation tagsFor: aNode item to: #filter.
	html div
		class: 'glm-tree-tags';
		with: [
			tags withIndexDo:[ :each :index | 
				self renderTag: each withFilter: (tagsFilter at: index ifAbsentPut:[ each ] ) for: aNode on: html ] ]
]

{ #category : #accessing }
SGLTreePresenter >> renderer [ 
	^ renderer
]

{ #category : #updating }
SGLTreePresenter >> updateSelectedNodesFrom: aPresentationModel [
	self renderer scriptFor: aPresentationModel glamourPresentation add: (
		JSStream new 
			nextPutAll:  'Glamour.tree.deselectAll'; 
			argument: self htmlId).
	aPresentationModel selection selectedNodes do: [:each | 
		self renderer scriptFor: aPresentationModel glamourPresentation add: (
			JSStream new 
				nextPutAll:  'Glamour.tree.selectNode'; 
				argument: each htmlId ) ]
]

{ #category : #updating }
SGLTreePresenter >> updateSelectionWithNode: aNode on: aScript [
	self explicitSelection: aNode from: aNode containerTree.
	self updateSelectedNodesFrom: aNode containerTree.
	self renderer updateScript: aScript
]
