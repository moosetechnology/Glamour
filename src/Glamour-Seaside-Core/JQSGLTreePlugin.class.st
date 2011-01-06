Class {
	#name : #JQSGLTreePlugin,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #printing }
JQSGLTreePlugin >> javascriptContentOn: aStream [
	JSStream
		encodeDictionary: self options
		on: aStream
]

{ #category : #options }
JQSGLTreePlugin >> optionAt: aKey put: aValue [
	^self options at: aKey put: aValue
]

{ #category : #options }
JQSGLTreePlugin >> options [
	^options ifNil: [options := GRSmallDictionary new]
]
