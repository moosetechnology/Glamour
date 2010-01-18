Class {
	#name : #GLMPaneRemoved,
	#superclass : #GLMPaneAnnouncement,
	#category : #'Glamour-Browsers'
}

{ #category : #'instance creation' }
GLMPaneRemoved class >> pane: aPane fromBrowser: aBrowser [ 
	 
	^(self new) 
		pane: aPane; 
		browser: aBrowser; 
		yourself
]
