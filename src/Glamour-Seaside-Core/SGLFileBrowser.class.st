Class {
	#name : #SGLFileBrowser,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLFileBrowser class >> initialize [
	self registerAsApplication: 'glamour/file'
]

{ #category : #accessing }
SGLFileBrowser >> browser [
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser 
		column: #folders;
		column: [ :c | c row: #files span: 2; row: #summary ] span: 2.

	browser showOn: #folders; using: [
		browser tree 
			title: 'Folders'; 
			children: [ :directory | 
				directory directoryNames
					collect: [ :each | directory directoryNamed: each ] ];
			format: [ :directory | directory localName ] ].

	browser showOn: #files; from: #folders; using: [
		browser list
			display: [ :directory | 
				directory fileNames
					collect: [ :each | directory directoryNamed: each ] ];
			format: [ :directory | directory localName ] ].

	browser showOn: #summary; from: #files; using: [
		browser text 
			title: 'Summary';
			display: [ :directory |
				| stream |
				stream := FileStream oldFileNamed: directory pathName.
				[ stream contents ] ensure: [ stream close ] ] ].

	^ browser
]

{ #category : #accessing }
SGLFileBrowser >> model [
	^ FileDirectory default
]
