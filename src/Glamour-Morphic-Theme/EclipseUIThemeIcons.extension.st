Extension { #name : #EclipseUIThemeIcons }

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousAccept [ 
	^ self smallOkIcon
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousAdd [
	^ self icons
			at: #'glamorousAdd'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousAddIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousAddIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQANUAADV2VDh6Vzh5Vzt+Wjx+WkCFXkSLYkWMY0WLYkWLY0WMYkqTZ0qTaE+a
bFCabFShcVWhcVShcFindVWicVyseV+we12seY20U420VJa5VZa5VqDAWKHAWKzHWqzHW63H
Wq3GWq3HW8XWYMbWYMXVYMbVYMXVYdDbY9riZdrhZeDlZv///wAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAACsALAAA
AAAQABAAAAZbwJVwSCwaj0hhZVlJDisqVdO5oqRQFupKcpUgJxHI40Q+Pc4PokMkMpHapRG7
QWSEQqAOKOT5+BdEBgkKChscGxsKCAcHSAUZGgVaBBgXA1oBlQJaAJ0AWqCgQQA7'
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousAlarm [
	^ self icons
			at: #'glamorousAlarm'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousAlarmIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousAlarmIconContents [
	"Private - Method generated"
	^ 'R0lGODlhFAAUAOYAAIigxA9RhBBShRBThRJThS9qljVvmjpwmj52n0d6oUh6oVWHrF6KrG+Y
uHWbuHSat42sxLrN29/o70F5oUR6oUZ7oGqYuHiiwHijwHumw32nxICpxYSqxYisxImsxIqt
xYutxdfl74CqxYOrxYesxJ6/07TM28zi8Ofy+TRvj6vK28zi79Xq9tbq9tXp9djs99bq9dvv
+uL0/uP0/ufy+KbG16XF1qjI2dfs99Xq9d7y/OL1/9/y/OL0/eP0/d7s89/s8+/5/u33/Oz2
++Tu867N3LHP3dvw+t/z/OL1/ur1+rTR3d7z/Nvw+eL1/ef4/97z++b4/+34/Ob5//X7/fT6
/LbU3fT7/ev7//X9//H7/fL7/fn+/+r8/+v8//f+/+7//+////L///X//////wAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAGQALAAAAAAUABQAAAf1gGSCg4SFhoeIiWQRDwcE
BAcPEYoSDgogRFVVRB8VDhKHEgweVGOmplxXHQyghQ4AX2KyKbKyXyQOhREJW2EjYWEEVsBg
I1oUk4MPHFleWF1eBEtYz15eIw+EB0BP3U9TBEZPUeNRQAaEBENJPj09TgRFMk5OMjNDAuko
OSM5LDAEbLRoAcPFCBoBtIU4wfDEihIEVjRcEaIAoQcXcGh8obEGAY0aMWQbFAGBkiZHRhxp
EuNGihgxlChINqhBhiBQmOhAwgOJCh5BIOQqJGGBBiFJkozYkVQIBFahLEwQ8UOKlB8bFHxS
ZMKCgQEDDEhSRLas2UAAOw=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousBookmark [
	^ self icons
			at: #'glamorousBookmark'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousBookmarkIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousBookmarkIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAOYAADpIYzxKZj1LZmhziWx1hzxLZj1LZUVTbU9eeEpZclVkfVppgl9uhnF4
g2V1jGNyib/J1tHW3WOq/2So/2Sq/2ar/22w/26w/+bx/8rR2mCq/2mw/2qv/3G0/wBTpABP
ogBPoQBNnXK3/3K5/3S6/+n0/+32/wBdsABZqgBVo3G6/3a9/+j0/wBluABktgBitQBer3fB
/3jC/wBpvABnuXfD/3h8f/L6//b9//v//36Be4aEdo2IcoFzPp2SaJmPa5SMbv///////wAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAEIALAAAAAAQABAAAAewgEI9g4NChjOIM4VCPkGO
QYMzMpMzQT4OjI+PkpSWmD9BERmbkzKVP5hAjxAQQTMxMTWVQA9CPDmiObotK700OTwMQjs4
xaw4LyTKLjg7C0I6N6I31CciKiMwNzoKQjYm4KwmKB3lKCY2CEINJe3uHhcWFiksDQlCBPn5
GBgfGxscQOQ7YMiAwQEIQ1SYQCFEAAMCDEksAABACAkhNISQyJFjiI0fO4oUspHkyJMcAwEA
Ow=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousBrowse [ 
	^ self glamorousEdit
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousBug [ 
	^ self smallDebugIcon 
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousCancel [
	^ self smallCancelIcon
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousDown [
	^ self icons
			at: #'glamorousDown'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousDownIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousDownIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQANUAAP776P366P753v343/310/766fztuf3xxv3xx/zxx/300/vfivzik/vi
k/vilPzln/zmn/vln/vmn/zpq/zprP700/vdg/zfivvhk/zilL2EFrl/FLh+FLd8FLR6E7J4
E7F3E7F4E7uBFbqBFbZ9FLR6FLyCFqhuEKxzEatwEa91Eq1yEqtwErJ3E691E6dsEKZrEP//
/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAADEALAAA
AAAQABAAAAZpwJhwSCwaY5qk5kjUAACBwpIZMz2jJmpMNBgIBiPthqAgVDhaUuKAQHS0HoPc
UDqCPq0PZcIPgfJELhGDDw8QDxIPESpFKAwZGBkODQ0ZK0cpC5oXCxcsVCcWohYnWjEvoi+m
QjAwq6ZBADs='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousEdit [
	^ self icons
			at: #'glamorousEdit'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousEditIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousEditIconContents [
	"Private - Method generated"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAABgFBMVEXz9fv4+fxjeqfu8vry
9fv5+vz4+ftedqNmfqhqgqxthK1xiLFzibJ8krh+k7qMoMPw9PuBl7yEmr+JnsGRpcfe6Pjd
5/ff6Pfk7Pnn7vnt8vrz9vvc5/ff6fje6Pfh6vjq8Pn2+Pvm7vnw9fvy9vv1+Pv3+ft8cD56
bj56bz55bj56bz+FdTx9bz56bj+KdzuBcT2QejmLdzulhDSlhTSggjWbfzabfzeWfDjgyI+y
ijCuiDGqhjPUsmjUsmnavXzVsmn///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACDaxknAAAA
QnRSTlP/////////////////////////////////////////////////////////////////
/////////////////////wBEFhAAAAAAAWJLR0R/SL9x5QAAAAlwSFlzAAAASAAAAEgARslr
PgAAAJRJREFUGNNdyusWgUAUhuEZ5/NxpMNQQkwlhciIuP+bktnTsnj32n+e9aHXXyh/LvtC
VfTgBdwcXHMwzp5cQromw1Z9cc3uKcCxYqwMZOSdAOIl6Y+6nWZpEAOcdb2siy4AiSUXVgIQ
2ZrI1iKAvSoX6gHAN4t8gHBGxr12YzqfhAAbSpXPKXQHEHjM9RhzWbAF+OkNnyItNqJnYTsA
AAAASUVORK5CYII='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousExample [
	^ self icons
			at: #'glamorousExample'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousExampleIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousExampleIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAMQAAICQqFh4mEhgeLC4wGiAkHCoyDCYWDiYWEigYMDgyFioaGCoaHCweIC4
gJjAiKjImLjQoNjouNjosNzqtN3qtOPsuOPsueruv/Hyxfjzyvj0y/z1zv///////wAAAAAA
ACH5BAEAAB0ALAAAAAAQABAAAAVeYCeKXGmOKJkYrJFwqXpItHS8MYdEtRQhsBRnQaNMaIog
isOQTCyVI0M54jQmlcsl2qCqHBcM5uLA5RIPTeZhjnU4kM0G4hUGAARBfVngDPRuVXd5e0sC
gIFLhYkxIQA7'
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousFolder [
	^ self smallOpenIcon
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousGo [
	^ self icons
			at: #'glamorousGo'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousGoIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousGoIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAOYAAA1jQg9mQxBmQxJoRBJoRRNoRhRpRhxxThNoRBZrRxhsRxlsSCF2USJ3
UhxwShxtSB5ySyF1TyJ3USR6UyN2UCJ0TyR5Uyh9Vil9Vit/WSx/WS1/WSZ7Uyd6UyZ3UTCC
WlSqcVWrcVSpcVWqcUmmZUqnZkmlZVqvdFqvdVirckqnZE6raF6zd0yoZU+pZmO3eVGuZ2Wy
YWSxYWi1Y4jAhGi2YYjAgoa+gYe/govBhWy5Yo7EhY/Eh5TJiXS7YXa8YZfIiHm/YXi+YZjI
iJ7Ni5rJiZ7MjKPQjojHYozIYazRj67SkLHUkbTWkcLdl8Dblv///wAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAFAALAAAAAAQABAAAAdtgFCCg4SFhoeIiYUfGxmK
gxpOTxMYjxdMSktNEh2JFkRDQEVGRwwchw07Njc4NDk8PRUehREnISIiICMpKCwvFIQHKyUm
JCotLjAOEIULMzIyMTU6Cg+HBkI+P0EFCYkDSUgABI8IAgGP6eqHgQA7'
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousHelp [
	^ self icons
			at: #'glamorousHelp'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousHelpIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousHelpIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAOYAAP78/f7+//Lz9/Hy9vv8/46Zr/z9/4+arpKdr7W9yvf6/9zj7cvT3tzk
79vj7rO9ybS+ytrk8Cphl1N/rJaxzKO706K60o2esLO9x9vl79rk7tnj7dzl7tvk7fn8//3+
/yZimClimShhlilil0Z1oU9/rVGAqlB/qVJ/qFOAqV6KsW2Tt3icvpSz0JSyzpWzz6G71Nvl
7trk7SZilidjlyhkmCdjlShilCljlU2Aq0+Aq1CBrE+AqFCAqFyJsGmUt5SyzJWzzZezy5ay
yiZjkk2BqU+Bpl2NsZSyytvk69rj6ufw9/b7/62xtPj8//f7/u7y9ZOzypSzyNnm79jl7tvm
7Obv9Kuws/f8//n9//j9//b9//X9//T8/ury9Pr+//n9/vj8/fb+//T+//L8/fj+/vf9/ezy
8vz//6iysfv//vj8+6izr/3//v///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAG4ALAAAAAAQABAAAAfLgG6Cg4SFhR1DOSMSOkML
hm4QOkIdAgMyQjsJhQ8ISQFaY1pcAA0XGINVJxpoGyQhIjYOAR0mj25AFG1PRzYrQDc4WGpS
LYI9VAYEFSxaWCYzWB9KE4IjZ1oeWV9aKiIqBltQN4I2Xk5lYlg+Nz8EYmtnNYImEQpOXGBE
IFphZh4MSgiKQgHLEy1ZYFjoIoYLliBIBGXgMYUJEyzBulikYiTGoCYFOjDUIoYJGQ4HrhRi
U8RFgyVWOLzIkQaSBiApaNBAMcQjpJ+EAgEAOw=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousInspect [ 
	^ self smallInspectItIcon
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousInto [
	^ self icons
			at: #'glamorousInto'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousIntoIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousIntoIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAMQAADpDX2d8lVaJtE9ZX9bAfdK6d/zjn9nFj/zlp/712/745/767/zos/3s
wP3wz7OAG6t4GaJtFf///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
ACH5BAEAABIALAAAAAAQABAAAAVCoCSOZGmeaFo+bHugzyLPTwG3D6E86vgkvJ7k4QimWo1W
CsJoNiGqCGIaEUYMVZMgEBCMspJtVzIAAAan8lnIPoUAADs='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousLeft [
	^ self icons
			at: #'glamorousLeft'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousLeftIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousLeftIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAOYAAP//0v//4P//5///6P//7v//7///8P//8v//9v//+f///P/8wf/7zP/1
mv/2uv/61//85v/wnP/wnf/0tv/1uf/63v/74f/wqP/ytP/ztf/1w/720P/41P/sof/uo//w
sf/zwf3zyv/2z//20P7sq//ur/3uuv/xvf7wvf3vvP7zzP70zf/1z//srf7uuv/vvLp/DbuB
EbN0ALFyAK9wALR2AbJ0AbZ2ArJ0AqZqArN1A7J2B7V4CLF1CLh6Ca1sAKRkAKJjAKFjAKNk
AaNlAaNmA69wBKlrBqVpBqdpB59gAaBiBJ9hBKJlCaJmC6RoDZ5cAP///////wAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAFIALAAAAAAQABAAAAd6gFKCg4SFhoeIgjAxiYQ3
UT6NgjJRUTWSM1EICT8zNjg4OjyENAcQFRYDBAQGBQcKO4I9Ag8rISorLCMbIhwBRoJHABop
LiYvKMknIAw5g0AOJSQtHxgZGRMUC0mEQhcdHlBBQ0RERUiGShESS5KCTA1N7oJOT/P384EA
Ow=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousLeftSide [
	^ self icons
			at: #'glamorousLeftSide'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousLeftSideIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousLeftSideIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAOYAAIWTroiTpoqXrI2ZqoyZqn2Gko+aqJOcppKcppaeo2xzd+r4/5efo+n4
/+v4/tXz/+35/u/5/PH6/PP6+5uhofX6+l5kY5uhoPf7+fn7+KCjnqCknfr8+Nbtq9jur9rv
s93wuuTzyOHxwOz21/D43+n00PP55fb66/j78MbibqSnmqSmmqmql6mpl/z8962slPz6266s
lP7977KvkJOMXraxjrKukb21ifvyubmyjLmzjKigdfvusL+2iL20ibiwhfvll7qCFb2EFrqC
Frh+FLN6E7uBFbR6FLd+FbuBFruCFqxxEatxEa91EqxxEqltEKZrEKhtEf///wAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAFIALAAAAAAQABAAAAe8gFKCg4SFUj2IiYqLPT4P
j5CQPymUKTc6Dw2am5qTHZ85NQ8LpKRCQgs7KR6sNTMPDrEOQjJCDjQpH7o2MQ8Qv0EyMkNJ
SkZKICAvLA8REUQw0dLRSCItKw8SRzw43d7dRSEqGw8TE01A6erpTSUaFA8V8kzpS072SyMj
FwkPGP8YogB5gsFCChIIGRx4kKFhQyhQMihIYaIiAgMPOGjcqLFAihMgDRB44KKkyZIBUqBY
OUCAy5cwAcAUEAgAOw=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousMore [
	^ self icons
			at: #'glamorousMore'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousMoreIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousMoreIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQALMAAKnKl464dZG6eZ7CiKXGkarKmEtzEWuMO3OSRnSTR0ZvCmCDLGaINP//
/wAAAAAAACH5BAEAAA0ALAAAAAAQABAAAAQpsMlJq7046827z4EiSANDSEBSTIpiSAtzSEiS
TOHYlGeTrp+gcEjcRAAAOw=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousOpen [
	^ self smallOpenIcon
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousOpenFromUrl [
	^ self icons
			at: #'glamorousOpenFromUrl'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousOpenFromUrlIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousOpenFromUrlIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQANUAAD8/nz9fn1FtnlFsnVRvoVBtnVNwoVFtnVh0pFh0o1h1o1l1o1x4p198
q2B9q2N/rWR/rWaCr4WhzYahzZ2z1l99q199qmOArYWizYaizYaizJCq0qe72qe82q/B3TNw
pDNwo0B3pw1cmv///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAACMALAAA
AAAQABAAAAZkwJFwSCwaj8YAEglYHpXOYjNKFAlDxog2MhSFPsKt1uPhXj/WUYQcuXgujytI
lH48PJAGx+G0dCoMFAxOgQwLGwkICgmMjY2IBhkZGBkTlBgYGhkSkwQHBQUCn5+gB6YDplRE
QQA7'
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousOver [
	^ self icons
			at: #'glamorousOver'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousOverIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousOverIconContents [
	"Private - Method generated"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAQlBMVEX///9nfJVWibRPWV/S
unf845/YxIrZxY/85afq2Kf+9dv++u/86LP97MDt4L798M+zgBu+ji7FlzqreBmibRU6Q19f
4ZNEAAAAAXRSTlMAQObYZgAAAGJJREFUeNqdj1kOgCAMRFmsCCIWKPe/qmUx6J9xkibzuqSt
EL9kElYlc3MMe1WIy2BnW4d1ca0JZG4VzjSDJ47Z4fKROyIeHOyo1zN47yE/thNsQK97aLKS
Us1hli5Ff37sAmH9BCU7deY1AAAAAElFTkSuQmCC'
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousPlay [ 
	^ self glamorousGo
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousRedo [
	^ self smallRedoIcon
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousRefresh [
	^ self icons
			at: #'glamorousRefresh'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousRefreshIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousRefreshIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQANUAAPj46P797/jwsPvwtPnolPjomPvpnvndevDYgPHag/jgiPDgqPHTc/ve
hcOWHcKZIPjQYPjYePjYgPnNX72EFrF4E7uBFbqBFbZ8FLZ9FLZ9FbqBFqhuEK1yEaluEahu
Ea1yEq1zEqxyEqxzEqZrEP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAACUALAAA
AAAQABAAAAZlwJJwOKRQiEgiJXBMIi2BwGWzcQoxhIF2kNBYKweDWMx4WEGTBgjdGFlLnomn
9JlwikKjkETaF5klFABNToICRgALhEgUCgKPjwgOVhkRBZcFERhvISAiEhAdb0MkEH2je6eo
q0EAOw=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousRemove [
	^ self icons
			at: #'glamorousRemove'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousRemoveIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousRemoveIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQALMAADV2VEGIX0KHYFOfb1OfcF+we6XDWaXCWabCWabDWqXCWqbCWuDlZv//
/////wAAACH5BAEAAA4ALAAAAAAQABAAAAQl0MlJq7046807LmAoFhXBnCg6VEJiLAqMHEhQ
AXiuA17v/0BgBAA7'
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousRestart [
	^ self icons
			at: #'glamorousRestart'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousRestartIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousRestartIconContents [
	"Private - Method generated"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAADAFBMVEUldVAtfFg2gl5BnmNY
q3FYqnFNp2ZNp2VNpmVhr2FhsGBttV9ttV6TxYeTxYZ4ul6iy4ujy4qsz474+Oj48LD46Ji4
mCj44Ijw4Ki+nCjQuGi4kCD42ICogBigeBiwiCDAoGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACu
YUApAAAAInRSTlP///////////////////////////////////////////8ADdDDcQAAAAFi
S0dEIcRsDRYAAAAJcEhZcwAAAEgAAABIAEbJaz4AAAB6SURBVBjTnc/NDoIwEATgacXWghS0
y49gC/v+L+mWoAdPhDl+yc5kwX/BGZhefT+x1j+YQwgz6+dOAkQk0LaPjcALdbSw9t7Xtbpk
GN+jQJFzLdQXlDHG2pvNQIOcwDlXlsgnUUojo6ruwFYaZVagAfbZNaW0MnD4lw/7fxlPz+3/
uAAAAABJRU5ErkJggg=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousRight [
	^ self icons
			at: #'glamorousRight'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousRightIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousRightIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAOYAAP//0v//4P//5///6P//7v//7///8P//8v//9v//+f///P/8wf/7zP/1
mv/2uv/61//85v/wnP/wnf/0tv/1uf/63v/74f/wqP/ytP/ztf/1w/720P/41P/sof/uo//w
sf/zwf3zyv/2z//20P7sq//ur/3uuv/xvf7wvf3vvP7zzP70zf/1z//srf7uuv/vvLp/DbuB
EbN0ALFyAK9wALR2AbJ0AbZ2ArJ0AqZqArN1A7J2B7V4CLF1CLh6Ca1sAKRkAKJjAKFjAKNk
AaNlAaNmA69wBKlrBqVpBqdpB59gAaBiBJ9hBKJlCaJmC6RoDZ5cAP///////wAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAFIALAAAAAAQABAAAAd6gFKCg4SFhoeIhDEwiYU+
UTeNgzVRUTKGPDo4ODYzPwkIUTOEOwoHBQYEBAMWFRAHNINGARwiGyMsKyohKw8CPYI5DCAn
KMYvJi4pGgBHgkkLFBMZGRgfLSQlDkCESEVERENBUB4dF0KSSxIRSpJSTQ1M7lJPTvP3koEA
Ow=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousRightSide [
	^ self icons
			at: #'glamorousRightSide'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousRightSideIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousRightSideIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAOYAAIWTroiTpoqXrI2ZqoyZqn2Gko+aqJOcppKcppaeo2xzd+r4/5efo+n4
/+v4/u34/dXz/+r5/+r4/u35/uz5/ur5/u35/e/6/e/5/PH6/PP6+5uhofX6+l5kY5uhoPX7
+vf7+vf7+fj7+fn7+fn7+KCjnqCknfr8+Pr7+dbtq9jurtjur9rvs9rus93wud3wuuTzyO/4
3tjtruHxwOz21/D43/r7+On00PD43vP55fb76vj87/P55Pb66/j78Pb66vj77/v8+MbibqSn
mvv896Smmqmql6mpl/z89/z8+Pv79/v7+K2slPz6266slP7977KvkJOMXraxjrKukb21ifvy
ubmyjLmzjKigdfvusL+2iL20ibiwhf389/z79/vll/z7+L2EFrmBFbqBFbV7FLR7FKpvEalv
Ea90EqZrEKpuEf///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAGsALAAAAAAQABAAAAfOgGuCg4SFa1qIiYqLWlRC
j0JcEJOUlFtWQimakg2dnp1XUkIrKjJYEAthYRILFRELUlNCLC0tURAOYU9hDg4UDlBMQi8u
qsZPuw8WE05HQjNiTdLT0mMXGEZDQjBlVd7f3llkGUUlQjdoX+rr6mgaGiYeQjQ0amZn9+pm
HB8cGwxCauCI0QGCiDRf0oAIwTABAiE5cvBQAAFFmjQjSNjIeMCAkB46fhSAQOSEjSVBiCg5
YWCAEB87gASA4KULGC9JkIBBQkCAT58Afgr9GQgAOw=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousSave [ 
	^ self smallSaveIcon
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousSaveToUrl [
	^ self icons
			at: #'glamorousSaveToUrl'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousSaveToUrlIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousSaveToUrlIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQANUAAD8/nz9fn0xnl1FtnlFsnVRvoVBtnVNwoVFtnVJunVh0pFh0o1h1o1l1
o1x4p198q2B9q197qGN/rWR/rWaCr4WhzYahzZ2z1l99q199qmOArYWizYaizYaizJCq0qe7
2qe82q/B3TNwpDNwo0B3pw1cmv///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAACYALAAA
AAAQABAAAAZmQJNwSCwaj0gjaVQqJYkkkfMpLEWppimJCjBGKGBiYAguh0KUYZd8pmhCGolw
TJRIQpPHB/LMgDAOFw5PgQ4NHgkKDAuMjY0eCwccHBscFpUbGx0cFZQFAgYGAwgGpKEIqASo
WERBADs='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousSearch [
	^ self smallFindIcon
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousSpawn [
	^ self icons
			at: #'glamorousSpawn'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousSpawnIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousSpawnIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQALMAACd2UjSAXDOEXDSEXDKDWVircU2nZmGvYYO9gG21Xnm6XaPLiqzPjv//
/wAAAAAAACH5BAEAAA0ALAAAAAAQABAAAARIsMlJq2SB2R1QoIPAYSBDWJk3DQwDVN1iBHSw
3O/EGEjv/zlJoEAsGgtBjGHJbAYbmIN0Kn3qANiE1moBKBTcLnjTDZPPaEoEADs='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousThrough [
	^ self icons
			at: #'glamorousThrough'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousThroughIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousThroughIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAMQAADpDX2d8lVaJtE9ZX9bAfdK6d/zhlvzlp/znrf712/745/767/zos/3s
wP3wz/7z1/724f746bJ/GrB+GrOAG698Gq56Gap2GKx4Gat4GaJtFf///wAAAAAAAAAAAAAA
ACH5BAEAABsALAAAAAAQABAAAAVa4CaOZGmaFHWeEiKNaUxNNB0h00YtfM9DQKChopMRFAWL
8mGwnCgK1QZjwKwoCenlstI5pN1YI9bNGBhoQ6a70RgOBg1b5JabBIGAYGQX4fUDAAADK4GD
cyUhADs='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousTrash [
	^ self smallDeleteIcon
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousUndo [ 
	^ self smallUndoIcon
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousUp [
	^ self icons
			at: #'glamorousUp'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousUpIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousUpIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQANUAAP797/765P321f765f311P755f3wwv3ww/zww/711P711fvgjvvhjvzl
nfvknfvlnf3qr/zqr/3qsPzqsPvdg/zgjr2EFryDFrR6E7F4E7Z8FLZ9FLR6FLR7FLyCFrl/
Fbh/FbuBFrqBFqluEKtwEapwEaluEa91Eq1yEq91E6dsEKZrEP///wAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAACwALAAA
AAAQABAAAAZgQJZwSCwahRbL0WgBAJRLoadQCAwuUVFCIFAQCKEj6EBGGAzkT3EzkUQk7QlE
riFyMBiOw/Fo5DscRxkVDAsVGVEsKRSMFCeJKI0UKIklkiSJJpIjiSqSKoksK6MroaFBADs='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousZoomIn [
	^ self icons
			at: #'glamorousZoomIn'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousZoomInIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousZoomInIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAOYAAPf1+Pb098rE0ufm7PX19/T09uvr7S08rys9qy0/rSpAryo/rKu616q5
1vLz9ebn6aq61Km50qi506m61Km706i81Ke7066ytfD09+Xp7OTo6+Ln6vL29+To6ePn6PL2
9ePp53F0bff48+rt3L/BttjazXFybOrr5dzd14iJeYeIeoiIfHJyauTk2MDAtu/v49nZz+7u
5uvr6auqmOrp1KCZY8C+r+Hf0Lu1k4mHeoqIe9LPvImHe+zp1qyqnefl2NzazqKYZ7u1lYqH
eMC9ruDdzuzp2uvo2XJxbKemoff28aOXZ/n49KSWZc7JtrywiLyvjIuHe4qGe4qHfomGfcC8
sKSJRIqGfYuHfsK8sN3c2qmmofr38oZWMoRWMoZUM+zs7P///wAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAGEALAAAAAAQABAAAAeMgGGCg4SFhkJBVktPhoNO
TTZHLyNZNTuNSzRKXCIiTEZLhlBVHwUEAAQBHEQ4hTktGAwRFhUSDj9YhTwxEAgKBwsJECcp
hUM3YBMTDQ0UMkVUhTMuGwMdGhoZBhc+hiooDx4dGyAwUY0CKyQlWkAXPD1TjWFbPDpXSWFS
XSHzhkhfWPgrZMLLwIMIAwEAOw=='
]

{ #category : #'*Glamour-Morphic-Theme' }
EclipseUIThemeIcons >> glamorousZoomOut [
	^ self icons
			at: #'glamorousZoomOut'
			ifAbsentPut:[ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self glamorousZoomOutIconContents readStream) ].
]

{ #category : #'*Glamour-Morphic-Theme-contents' }
EclipseUIThemeIcons >> glamorousZoomOutIconContents [
	"Private - Method generated"
	^ 'R0lGODlhEAAQAOYAAO3r8Ovo8cfF0/X19yw9ry09rC4+rSk9rSs/ryw+rCs9qSw+qrCxtfT1
+ejp7aq51vT19/P09qm61qm50+Xo7am61Km706i81aa60+Hp666ys+To6ePp6fT29ers6dze
2d/i2e3v4oiJe+nq3IeHfcHBtaenn+Tk2vj49rm2k4qIeYmHeKupmuHf0O3r3ImHe4qIfNXS
wdfUw7+9sOro2+jm2ru1lYuIeYqHeMC9ruDdzvDt3uzp2uvo2XNybXFwa6OXZaKWZruyi3Jx
bff28qSWZ6WXaL2xi4uHe4qGeoqGe6yonYmGfYiFfMC8sMO/tN7azt/b0O7q3+Pf1KSJRIVY
MYJWMYZUL6qlofr28/b29vX19f///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAFwALAAAAAAQABAAAAeMgFyCg4SFhilAVEBChoMx
RjM9OyNORTKNQTREKBhZDTxAhkdOA1sTCxJaHTk2hU0nEBISCQ8PETUwhSIhFQoIBwsEFlI4
hS9TABUPBhgSHi1MhSxPHBwXBRUOGwxLhkofGQEWHBQ6N40CKyVQIFEaJC5JjVxYSC84Jlwq
Vj7zhkNXfvgrNKTKwIMIAwEAOw=='
]
