I am NeoJSONMappingNotFound. I am signalled when no mapping is found for a schema.

Portability comment: In Pharo,  I could technically subclass from NotFound directly, avoid all my defined methods and only keep #messageText and #standardMessageText. However, NotFound exception does not exist in other dialects. To keep NeoJSON as portable as possible we duplicate some Pharo code into myself. 