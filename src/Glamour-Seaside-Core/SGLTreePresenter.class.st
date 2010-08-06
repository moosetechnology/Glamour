Class {
	#name : #SGLTreePresenter,
	#superclass : #WAPresenter,
	#instVars : [
		'renderer',
		'model',
		'htmlId',
		'nodesId'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'instance creation' }
SGLTreePresenter class >> for: aModel with: aRenderer [
	^ self basicNew initializeFor: aModel with: aRenderer 
]

{ #category : #accessing }
SGLTreePresenter >> associateId: anId forNode: aNode [
	nodesId at: anId ifAbsentPut: [aNode] 
]

{ #category : #selection }
SGLTreePresenter >> explicitSelection: aNodeOrCollection [
	self model glamourPresentation isMultiple 
		ifTrue: [ 
			|nodesPaths|
			nodesPaths := OrderedCollection new.
			aNodeOrCollection isCollection 
				ifTrue: [ aNodeOrCollection do: [:each | nodesPaths add: each path ] ] 
				ifFalse: [nodesPaths add: aNodeOrCollection path]. 
			self model selectAllNodePaths: nodesPaths ]
		ifFalse: [ self model selectNodePath: aNodeOrCollection path]
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
SGLTreePresenter >> initialize [
	nodesId := Dictionary new
]

{ #category : #initialization }
SGLTreePresenter >> initializeFor: aModel with: aRenderer [
	self initialize.
	model := aModel.
	renderer := aRenderer
]

{ #category : #accessing }
SGLTreePresenter >> model [
	^ model
]

{ #category : #accessing }
SGLTreePresenter >> nodeForId: anId [
	^ nodesId at: anId 
]

{ #category : #actions }
SGLTreePresenter >> onClickActionForAppendButtonOn: html [
	^ html jQuery ajax
		script: [ :s | 
			(self model roots size > self model amountShown) 
				ifTrue: [ "Load the required elements"
					s << (  (s jQuery id: self htmlId) children: '.glm-tree-root-ct' ) 
						append: [:h |
							self renderRootNodesBeginningWith: self model amountShown+1 on: h ] ] 
				ifFalse: [  "Disable the button for loading content"
					s << ( (s jQuery id: self htmlId) children: '.glm-tree-append-button'  ) attributeAt: 'disabled' put: true ].
			s << ( (html jQuery expression: '#', self htmlId, ' > .glm-tree-root-ct' ) glamourTree update ) ] 
]

{ #category : #actions }
SGLTreePresenter >> onClickActionForTag: aTag of: aNode on: html [
	^ html jQuery ajax script: [:s | 
		aNode containerTree toggleFilteringByTag: aTag.
		s << ( html jQuery id: (self renderer uuidFor: aNode containerTree glamourPresentation ) )
			replaceWith: [ :h |
				self renderContentOn: h ] ] 
]

{ #category : #actions }
SGLTreePresenter >> onExpandToggledActionForANodeOn: html [
	^ html jQuery ajax 
		script: [:s | 
			self renderer updateScript: s ] ;
		callback: [ :nodeId |
			|aNode|
			aNode := self nodeForId: nodeId.
			aNode rendered "Render the children and update the model"
				ifTrue: [ aNode toggleExpansion ]
				ifFalse: [
					self renderer scriptFor: self model glamourPresentation add: (
						(html jQuery id: aNode htmlId ) append: [:h | 
							self renderNodes: aNode contents asListFromLevel: aNode path size on: h ]).
					aNode expanded: true.
					aNode rendered: true ] ] value:  (JSStream on: '$node.attr("id")')
]

{ #category : #actions }
SGLTreePresenter >> onSelectActionForANodeOn: html [
	^ html jQuery ajax 
		script: [:s | 
			self renderer updateScript: s ] ;
		callback: [ :value |
			|nodes|
			nodes := ( value contents findTokens: $, ) collect: [:each | 
				self nodeForId: each].
			(nodes size == 1) 
				ifTrue: [self explicitSelection: (nodes at: 1) ]
				ifFalse:  [self explicitSelection: nodes].
			self updateSelectedNodes ] value:  (JSStream on: '$anIdOrAList')
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
			(self model roots size > self model amountShown) ifTrue: [ "Add a button for loading the remaining elements"
				self renderAppendButtonOn: html ] ].
	
]

{ #category : #rendering }
SGLTreePresenter >> renderInitialRootNodesOn: html [
	|listId|
	listId := html nextId.
	html unorderedList   
		class: 'glm-tree-root-ct';
		id: listId;
		script: ( html jQuery new glamourTree init; 
			isMultiple: self model glamourPresentation isMultiple;
			selectedNodes: self selectedIds; 
			onSelect: (self onSelectActionForANodeOn: html);
			onExpandToggled: (self onExpandToggledActionForANodeOn: html) );
		with: [ self renderRootNodesBeginningWith: 1 on: html ]
]

{ #category : #rendering }
SGLTreePresenter >> renderNode: aNode fromLevel: level on: html [
	|children|
	aNode htmlIdIfNotNil: html nextId.
	self associateId: aNode htmlId forNode: aNode.
	children := aNode contents.
	html listItem  
		id: aNode htmlId;  
		class: 'glm-tree-node';
		class: 'glm-tree-leaf' if: children size == 0;
		class: 'glm-tree-open' if: (children size > 0 and: [aNode expanded]);
		class: 'glm-tree-closed' if: (children size > 0 and: [aNode expanded not]);
		with: [
			self renderNodeTitleFor: aNode on: html.
			(children size > 0 and: [ aNode expanded ] ) ifTrue: [ 
				self renderNodes: children asListFromLevel: level+1 on: html.
				aNode rendered: true. ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderNodeTitleFor: aNode on: html [
	html div
		class: 'glm-tree-node-el';
		with: [ 
			html span with: [
				html span: aNode displayText. 
				self renderTagsOf: aNode on: html ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderNodes: nodes asListFromLevel: level on: html [
	html unorderedList 
		id: html nextId;
		script: ( html jQuery new glamourTree init; level: level );
		class: 'glm-tree-node-ct';
		with: [ nodes do: [:each | 
			self renderNode: each fromLevel: level on: html ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderRootNodesBeginningWith: startIndex on: html [
	"Render the first 'amountToShow' elements starting from the one with the index 'startIndex'"
	
	|endIndex nodes|
	nodes := self model roots.
	(startIndex == 1 and: [ self model amountShown ~= 0 ] ) 
		ifTrue: [ endIndex  := self model amountShown min: self model roots size ] 
		ifFalse: [ endIndex := startIndex+self model amountToShow-1 ].
	(startIndex to: endIndex) do: [ :each |   
			self renderNode: (nodes at: each)  fromLevel: 0 on: html ].
	(startIndex == 1 and: [self model amountShown ~= 0 ] ) 
		ifTrue: [
			 self model amountShown: (self model amountShown max: endIndex) ]  
		ifFalse: [
			self model amountShown: self model amountToShow + self model amountShown ] 
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

{ #category : #private }
SGLTreePresenter >> selectNodesScript [
	^ JSStream new 
			nextPutAll:  '$.glamour.selectNodes'; 
			arguments: (Array with: self htmlId with: self selectedIds)
]

{ #category : #private }
SGLTreePresenter >> selectedIds [
	|ids|
	ids := OrderedCollection new.
	self model selection ifNotNil: [ self model selection selectedNodes do: [:each |
		each ifNotNil: [ 
			ids add: each htmlId ] ] ].
	^ ids
]

{ #category : #updating }
SGLTreePresenter >> updateSelectedNodes [
	self renderer 
		scriptFor: self model glamourPresentation 
		add: self selectNodesScript
]

{ #category : #updating }
SGLTreePresenter >> updateSelectionWithNode: aNode on: aScript [
	self explicitSelection: aNode.
	self updateSelectedNodes.
	self renderer updateScript: aScript
]
