Class {
	#name : #JQTabsOld,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #actions }
JQTabsOld >> abort [
	"Terminate all running tab ajax requests and animations."
	
	self action: 'abort'
]

{ #category : #actions }
JQTabsOld >> add: aUrl label: aString [
	"Add a new tab. The second argument is either a URL consisting of a fragment identifier only to create an in-page tab or a full url (relative or absolute, no cross-domain support) to turn the new tab into an Ajax (remote) tab. The third is the zero-based position where to insert the new tab. Optional, by default a new tab is appended at the end."
	
	self action: 'add' arguments: (Array with: aUrl with: aString)
]

{ #category : #actions }
JQTabsOld >> add: aUrl label: aString at: anInteger [
	"Add a new tab. The second argument is either a URL consisting of a fragment identifier only to create an in-page tab or a full url (relative or absolute, no cross-domain support) to turn the new tab into an Ajax (remote) tab. The third is the zero-based position where to insert the new tab. Optional, by default a new tab is appended at the end."
	
	self action: 'add' arguments: (Array with: aUrl with: aString with: anInteger)
]

{ #category : #'options-generated' }
JQTabsOld >> ajaxOptions: anOptions [
	"Additional Ajax options to consider when loading tab content (see $.ajax)."

	self optionAt: 'ajaxOptions' put: anOptions
]

{ #category : #'options-generated' }
JQTabsOld >> cache: aBoolean [
	"Whether or not to cache remote tabs content, e.g. load only once or with every click. Cached content is being lazy loaded, e.g once and only once for the first click. Note that to prevent the actual Ajax requests from being cached by the browser you need to provide an extra cache: false flag to ajaxOptions."

	self optionAt: 'cache' put: aBoolean
]

{ #category : #'options-generated' }
JQTabsOld >> collapsible: aBoolean [
	"Set to true to allow an already selected tab to become unselected again upon reselection."

	self optionAt: 'collapsible' put: aBoolean
]

{ #category : #'options-generated' }
JQTabsOld >> cookie: anObject [
	"Store the latest selected tab in a cookie. The cookie is then used to determine the initially selected tab if the 'selected' option is not defined. Requires [http://plugins.jquery.com/project/cookie cookie plugin], which can also be found in the development-bundle>external folder from the download builder. The object needs to have key/value pairs of the form the cookie plugin expects as options. Available options (example): &#123; expires: 7, path: '/', domain: 'jquery.com', secure: true &#125;. Since jQuery UI 1.7 it is also possible to define the cookie name being used via 'name' property."

	self optionAt: 'cookie' put: anObject
]

{ #category : #'options-generated' }
JQTabsOld >> deselectable: aBoolean [
	"deprecated in jQuery UI 1.7, use collapsible."

	self optionAt: 'deselectable' put: aBoolean
]

{ #category : #actions }
JQTabsOld >> disable: anInteger [
	"=Disable a tab. The selected tab cannot be disabled. To disable more than one tab at once use: <code>$('#example').data('disabled.tabs', [1, 2, 3]);</code>  The second argument is the zero-based index of the tab to be disabled. "
	
	self action: 'disable' arguments: (Array with: anInteger)
]

{ #category : #'options-generated' }
JQTabsOld >> disabled: anArrayNumber [
	"An array containing the position of the tabs (zero-based index) that should be disabled on initialization."

	self optionAt: 'disabled' put: anArrayNumber
]

{ #category : #actions }
JQTabsOld >> enable: anInteger [
	"Enable a disabled tab.  To enable more than one tab at once reset the disabled property like: <code>$('#example').data('disabled.tabs', []);</code>. The second argument is the zero-based index of the tab to be enabled."
	
	self action: 'enable' arguments: (Array with: anInteger)
]

{ #category : #'options-generated' }
JQTabsOld >> event: aString [
	"The type of event to be used for selecting a tab."

	self optionAt: 'event' put: aString
]

{ #category : #'options-generated' }
JQTabsOld >> fx: anOptionsOrArrayOptions [
	"Enable animations for hiding and showing tab panels. The duration option can be a string representing one of the three predefined speeds ('slow', 'normal', 'fast') or the duration in milliseconds to run an animation (default is 'normal')."

	self optionAt: 'fx' put: anOptionsOrArrayOptions
]

{ #category : #'options-generated' }
JQTabsOld >> idPrefix: aString [
	"If the remote tab, its anchor element that is, has no title attribute to generate an id from, an id/fragment identifier is created from this prefix and a unique id returned by $.data(el), for example 'ui-tabs-54'."

	self optionAt: 'idPrefix' put: aString
]

{ #category : #actions }
JQTabsOld >> length [
	"Retrieve the number of tabs of the first matched tab pane."
	
	self action: 'length'
]

{ #category : #actions }
JQTabsOld >> load: anInteger [
	"Reload the content of an Ajax tab programmatically. This method always loads the tab content from the remote location, even if cache is set to true. The second argument is the zero-based index of the tab to be reloaded."
	
	self action: 'load' arguments: (Array with: anInteger)
]

{ #category : #accessing }
JQTabsOld >> method [
	^ 'tabs'
]

{ #category : #'events-generated' }
JQTabsOld >> onAdd: anObject [
	"This event is triggered when a tab is added."

	self optionAt: 'add' put: anObject asFunction
]

{ #category : #'events-generated' }
JQTabsOld >> onDisable: anObject [
	"This event is triggered when a tab is disabled."

	self optionAt: 'disable' put: anObject asFunction
]

{ #category : #'events-generated' }
JQTabsOld >> onEnable: anObject [
	"This event is triggered when a tab is enabled."

	self optionAt: 'enable' put: anObject asFunction
]

{ #category : #'events-generated' }
JQTabsOld >> onLoad: anObject [
	"This event is triggered after the content of a remote tab has been loaded."

	self optionAt: 'load' put: anObject asFunction
]

{ #category : #'events-generated' }
JQTabsOld >> onRemove: anObject [
	"This event is triggered when a tab is removed."

	self optionAt: 'remove' put: anObject asFunction
]

{ #category : #'events-generated' }
JQTabsOld >> onSelect: anObject [
	"This event is triggered when clicking a tab."

	self optionAt: 'select' put: anObject asFunction
]

{ #category : #'events-generated' }
JQTabsOld >> onShow: anObject [
	"This event is triggered when a tab is shown."

	self optionAt: 'show' put: anObject asFunction
]

{ #category : #'options-generated' }
JQTabsOld >> panelTemplate: aString [
	"HTML template from which a new tab panel is created in case of adding a tab with the add method or when creating a panel for a remote tab on the fly."

	self optionAt: 'panelTemplate' put: aString
]

{ #category : #actions }
JQTabsOld >> remove: anInteger [
	"Remove a tab. The second argument is the zero-based index of the tab to be removed."
	
	self action: 'remove' arguments: (Array with: anInteger)
]

{ #category : #actions }
JQTabsOld >> rotate: aDuration [
	"Set up an automatic rotation through tabs of a tab pane.  The second argument is an amount of time in milliseconds until the next tab in the cycle gets activated. Use 0 or null to stop the rotation.  The third controls whether or not to continue the rotation after a tab has been selected by a user."
	
	self action: 'rotate' arguments: (Array with: aDuration)
]

{ #category : #actions }
JQTabsOld >> rotate: aDuration continuing: aBoolean [
	"Set up an automatic rotation through tabs of a tab pane.  The second argument is an amount of time in milliseconds until the next tab in the cycle gets activated. Use 0 or null to stop the rotation.  The third controls whether or not to continue the rotation after a tab has been selected by a user."
	
	self action: 'rotate' arguments: (Array with: aDuration with: aBoolean)
]

{ #category : #actions }
JQTabsOld >> select: anInteger [
	"Select a tab, as if it were clicked. The second argument is the zero-based index of the tab to be selected or the id selector of the panel the tab is associated with (the tab's href fragment identifier, e.g. hash, points to the panel's id)."
	
	self action: 'select' arguments: (Array with: anInteger)
]

{ #category : #'options-generated' }
JQTabsOld >> selected: aNumber [
	"Zero-based index of the tab to be selected on initialization. To set all tabs to unselected pass -1 as value."

	self optionAt: 'selected' put: aNumber
]

{ #category : #'options-generated' }
JQTabsOld >> spinner: aString [
	"The HTML content of this string is shown in a tab title while remote content is loading. Pass in empty string to deactivate that behavior. An span element must be present in the A tag of the title, for the spinner content to be visible."

	self optionAt: 'spinner' put: aString
]

{ #category : #'options-generated' }
JQTabsOld >> tabTemplate: aString [
	"HTML template from which a new tab is created and added. The placeholders #&#123;href&#125; and #&#123;label&#125; are replaced with the url and tab label that are passed as arguments to the add method."

	self optionAt: 'tabTemplate' put: aString
]

{ #category : #actions }
JQTabsOld >> url: aUrl at: anInteger [
	"Change the url from which an Ajax (remote) tab will be loaded. The specified URL will be used for subsequent loads. Note that you can not only change the URL for an existing remote tab with this method, but also turn an in-page tab into a remote tab.  The second argument is the zero-based index of the tab of which its URL is to be updated.  The third is a URL the content of the tab is loaded from."
	
	self action: 'url' arguments: (Array with: anInteger with: aUrl)
]
