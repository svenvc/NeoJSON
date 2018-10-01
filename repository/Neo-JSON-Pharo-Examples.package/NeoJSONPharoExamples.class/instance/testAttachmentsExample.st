tests
testAttachmentsExample
	| collectionOne json |
	"Let's create a collection of two instances:"
	collectionOne := {(Attachment new
		url: 'http://example.com/random-name.txt' asZnUrl;
		fileName: 'chapter-one.txt' yourself).
	(Attachment new
		url: 'http://example.com/random-name.png' asZnUrl;
		fileName: 'image.png';
		yourself)}.

	"And let's map it to a JSON structure:"
	json := String
		streamContents: [ :aStream | 
			(NeoJSONWriter on: aStream)
				for: #CollectionOfAttachments customDo: [ :mapping | mapping listOfElementSchema: Attachment ];
				mapAllInstVarsFor: Attachment;
				for: ZnUrl customDo: [ :mapping | mapping encoder: [ :aZnUrl | aZnUrl asString ] ];
				nextPut: collectionOne as: #CollectionOfAttachments ].


	"And read the JSON structure:"
	(NeoJSONReader on: json readStream)
		for: #CollectionOfAttachments customDo: [ :mapping | mapping listOfElementSchema: Attachment ];
		for: Attachment
			do: [ :mapping | 
			mapping mapInstVar: 'fileName'.
			(mapping mapInstVar: 'url') valueSchema: ZnUrl ];
		for: ZnUrl customDo: [ :mapping | mapping decoder: [ :string | string asZnUrl ] ];
		nextAs: #CollectionOfAttachments