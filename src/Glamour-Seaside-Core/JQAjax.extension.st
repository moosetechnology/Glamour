Extension { #name : #JQAjax }

{ #category : #'*Glamour-Seaside-Core' }
JQAjax >> sglCallbackText: aBlock [
	"Trigger aBlock with the event object. Depending on the type of the 
	event only certain fields may be populated"
	
	self sglPostCallback: aBlock forEvent: #(
		(string port)
		(string text "the text contained in the element")
		(string selection "the selected text")
		(number start "the start position of the selected text")
		(number end "the end position of the selected text"))
					
]

{ #category : #'*Glamour-Seaside-Core' }
JQAjax >> sglPostCallback: aBlock forEvent: anArraySpec [
	| parameters |
	parameters := GRSmallDictionary new.
	anArraySpec do: [ :spec |
		(spec first = #passenger)
			ifTrue: [ parameters at: spec last put: (JSStream on: '$(arguments[1].', spec last,').attr("id")'  ) ] 
			ifFalse: [ parameters at: spec last put: (JSStream on: 'arguments[1].', spec last) ] ].
	self 
		type: 'POST';
		addParameters: parameters;
		script: [ :script | 
			|result|
			result := GRSmallDictionary new.
			anArraySpec do: [ :spec | 
				(spec first = #string)
					ifTrue: [ result at: spec last put: (self requestContext request at: spec last ifAbsent: [''])].
				(spec first = #passenger)
					ifTrue: [ result at: spec last put: (self requestContext request at: spec last ifAbsent: [''])].
				(spec first = #number)
					ifTrue: [ result at: spec last put: (self requestContext request at: spec last ifAbsent: ['0']) greaseInteger]
			].
			"result at: 'text' put: (self requestContext request at: 'text')."
			aBlock value: result value: script ]
]

{ #category : #'*Glamour-Seaside-Core' }
JQAjax >> sglTreeCallbackAppendRootsURL: aBlock [
	| aTab |
	^ self 
		script: [ :script | 	
			|result|
			result := GRSmallDictionary new.
			result at: 'stepSize' put: (self requestContext request at: 'stepSize' ifAbsent: ['0']) greaseInteger.
			aBlock value: result value: script];
		fullUrl
]

{ #category : #'*Glamour-Seaside-Core' }
JQAjax >> sglTreeCallbackAppendURL: aBlock [
	| aTab |
	^ self 
		html: [ :aRenderer | 	
			|result|
			result := GRSmallDictionary new.
			result at: 'id' put: (self requestContext request at: 'id' ifAbsent: ['']).
			aBlock value: result value: aRenderer];
		fullUrl
]

{ #category : #'*Glamour-Seaside-Core' }
JQAjax >> sglTreeCallbackSelectURL: aBlock [
	| aTab |
	^ self 
		script: [ :script | 	
			|result|
			result := GRSmallDictionary new.
			result at: 'selectedIds' put: (self requestContext request at: 'selectedIds').
			aBlock value: result value: script];
		fullUrl
]

{ #category : #'*Glamour-Seaside-Core' }
JQAjax >> sglTreeCallbackToggleExpand: aBlock [
	
	self sglPostCallback: aBlock forEvent: #(
		(passenger node)
		(string action) )
					
]
