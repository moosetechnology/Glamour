"
self open
"
Class {
	#name : #GLMOtherExamples,
	#superclass : #GLMExamples,
	#category : #'Glamour-Examples'
}

{ #category : #'other examples' }
GLMOtherExamples >> expander [
	"self new expander openOn: Collection withAllSubclasses"
	| browser expander |
	browser := GLMTabulator new.
	browser title: 'Example'.
	expander := GLMExpander new.
	expander title: 'Methods'.
	expander display: [:class | class methods ].
	expander show: [ :a | 
		a title: [:x | x selector ].
		a text 
			display: #getSource].
	browser column: #classes; column: #methods.
	browser transmit to: #classes; andShow: [:a | 
		a list title: 'Classes' ].
	browser transmit to: #methods; from: #classes; andShow: [:a | 
		a custom: expander ].
	^ browser

]

{ #category : #'file examples' }
GLMOtherExamples >> fileExplorer [
	<glmBrowser: 'File Explorer' input: 'FileDirectory default'>
	"self new fileExplorer openOn: FileDirectory default"
	| browser |
	browser := GLMTabulator new.
	browser 
		column: #folders;
		column: [ :col | col row: #files span: 2; row: #preview ] span: 2. 
	browser transmit to: #folders; andShow: [ :a | 
		a tree 
			title: 'Folders'; 
			children: [ :fd | fd directoryNames collect: [ :each | FileDirectory on: fd pathName, fd pathNameDelimiter asString, each ] ]; 
			format: [ :folder | folder localName ] ].
	browser transmit to: #files; from: #folders; andShow: [ :a |
		a list 
			format: [ :fd | fd localName ]; 
			display: [ :fd | fd fileNames collect: [:each | FileDirectory on: fd pathName, fd pathNameDelimiter asString, each ] ] ].
	browser transmit to: #preview; from: #files; andShow: [ :a |
		a text
			display: [ :file | file fullName ] ].
	^ browser
]

{ #category : #'file examples' }
GLMOtherExamples >> fileFinder [
	<glmBrowser: 'File Finder' input: 'FileDirectory default'>
	"self new fileFinder openOn: FileDirectory default"

	| browser |
	browser := GLMFinder new.
	browser show:
	[ 	:a | a list
		display: [ :fd | fd entries collect: [:each | 
				FileDirectory on: fd pathName, fd pathNameDelimiter asString, each name]];
		format: [ :fd | fd localName ];
		when: [ :fd | fd directoryEntry isDirectory ]
	].
	browser show:
	[ 	:a | a text
		display: [ :fd | fd fullName ];
		when: [ :fd | fd directoryEntry isDirectory not ]
	].
	^ browser
]

{ #category : #'pier examples' }
GLMOtherExamples >> pierFinder [
	"
		self new pierFinder openOn: PRKernel instances anyOne root.
	"
	| browser |
	browser := GLMFinder new.
	browser list
		display: [:each | each enumerator contents];
		format: [:each | each title];
		title: 'Navigation'.
	browser magritte title: 'Editor'.
	browser mondrian
			title: 'Tree';
			painting: [:view :each | 
				view nodeShape: (MORectangleShape withBorder height: [:x | x plainText size // 10]).
				view nodes: each enumerator everything contents.
				view edgesFrom: #parent.
				view treeLayout].
	^ browser
]

{ #category : #'pier examples' }
GLMOtherExamples >> pierTreeEditor [

	"
		self new pierTreeEditor openOn: PRKernel instances anyOne root.
	"

	| browser |
	browser := GLMTabulator new.
	browser column: #navigation; column: #editor span: 4.
	browser transmit to: #navigation; andShow: [ :a |
		a tree
			children: [:each | each enumerator contents];
			format: [:each | each title ];
			title: 'Navigation'.
	].
	browser transmit to: #editor; from: #navigation; andShow: [ :a | 
		a magritte
			title: 'Editor'.
	].
	^ browser 
]
