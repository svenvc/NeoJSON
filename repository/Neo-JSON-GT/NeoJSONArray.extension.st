Extension { #name : #NeoJSONArray }

{ #category : #'*Neo-JSON-GT' }
NeoJSONArray >> gtJsonFor: aView [
	<gtView>
	^ aView explicit
		title: 'JSON';
		priority: 10;
		stencil: [ | editorElement textEditor text |
			textEditor := BrTextEditorModel new.
			textEditor styler: JSONParser gtStyler.
			editorElement := BrEditorElement new.
			editorElement editor: textEditor.
			text := (NeoJSONWriter toStringPretty: self) asRopedText.
			text glamorousCodeFontDo: #beNotOverwritableByStyler; glamorousCodeSizeDo: #beNotOverwritableByStyler.
			textEditor text: text.
			editorElement
				padding: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ].
			editorElement ]
]
