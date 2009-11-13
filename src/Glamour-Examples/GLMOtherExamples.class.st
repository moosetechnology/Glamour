"
self browseExamples
"
Class {
	#name : #GLMOtherExamples,
	#superclass : #GLMExamples,
	#category : #'Glamour-Examples'
}

{ #category : #'file examples' }
GLMOtherExamples >> fileExplorer [
	<glmBrowser: 'File Explorer' input: 'FileDirectory default'>
	"self new fileExplorer openOn: FileDirectory default"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser 
		column: #folders;
		column: [ :col | col row: #files span: 2; row: #preview ] span: 2. 
	browser showOn: #folders; using: [
		browser tree 
			title: 'Folders'; 
			children: [ :fd | fd directoryNames collect: [ :each | FileDirectory on: fd pathName, fd pathNameDelimiter asString, each ] ]; 
			format: [ :folder | folder localName ] ].
	browser showOn: #files; from: #folders; using: [
		browser list 
			format: [ :fd | fd localName ]; 
			display: [ :fd | fd fileNames collect: [:each | FileDirectory on: fd pathName, fd pathNameDelimiter asString, each ] ] ].
	browser showOn: #preview; from: #files; using: [
		browser text
			display: [ :file | file fullName ] ].
	^ browser
]

{ #category : #'file examples' }
GLMOtherExamples >> fileFinder [
	<glmBrowser: 'File Finder' input: 'FileDirectory default'>
	"self new fileFinder openOn: FileDirectory default"

	| browser |
	browser := GLMFinder new.
	browser list
		display: [ :fd | fd entries collect: [:each | 
				FileDirectory on: fd pathName, fd pathNameDelimiter asString, each name]];
		format: [ :fd | fd localName ];
		when: [ :fd | fd directoryEntry isDirectory ].
	browser text
		display: [ :fd | fd fullName ];
		when: [ :fd | fd directoryEntry isDirectory not ].
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
	browser := GLMTableLayoutBrowser new.
	browser column: #navigation; column: #editor span: 4.
	browser showOn: #navigation; using: [
		browser tree
			children: [:each | each enumerator contents];
			format: [:each | each title ];
			title: 'Navigation'.
	].
	browser showOn: #editor; from: #navigation; using: [
		browser magritte
			title: 'Editor'.
	].
	^ browser 
]
