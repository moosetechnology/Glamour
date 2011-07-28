Class {
	#name : #JQSGLDashboardColumn,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
JQSGLDashboardColumn >> cellHeight: anInteger [

	self optionAt: 'cellHeight' put: anInteger 
]

{ #category : #accessing }
JQSGLDashboardColumn >> method [ 
	^ 'sglDashboardColumn'
]
