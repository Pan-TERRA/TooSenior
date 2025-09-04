# TooNetworking Module

A declarative networking layer.

## Getting a NetworkClient

Use `NetworkClientFactory` to create configured network clients:

```swift
import TooNetworking

// Get the infinite feed API client
let client = NetworkClientFactory.infiniteFeedAPI()
```

## Building Requests

Use the declarative `HTTPRequest.build` syntax with request components:

```swift
let request = HTTPRequest.build {
    Path("/api/posts")
    Method(.get)
    QueryParameters([
        "_page": "1",
        "_limit": "10"
    ])
}

// For POST with JSON body
let createRequest = HTTPRequest.build {
    Path("/api/posts")
    Method(.post)
    JSONBody(postData)
    ContentType.json
    Accept.json
}
```

## Making API Calls

Use the NetworkClient's `perform` method with appropriate serializers:

```swift
// GET request returning JSON array
let response = try await client.perform(
    request: request,
    serializer: JSONSerializer<[PostDTO]>()
)
let posts = response.value

// POST request returning single object
let createResponse = try await client.perform(
    request: createRequest,
    serializer: JSONSerializer<PostDTO>()
)
let createdPost = createResponse.value
```

## Available Request Components

- **Path(String)** - API endpoint path
- **Method(HTTPMethod)** - HTTP method (.get, .post, .put, .delete, etc.)
- **QueryParameters([String: String])** - URL query parameters
- **JSONBody<T: Encodable>(T)** - JSON request body
- **Header(name: String, value: String)** - Custom headers
- **ContentType** - Content-Type header (.json, .xml, .formURLEncoded)
- **Accept** - Accept header (.json, .xml, .any)
- **Timeout(TimeInterval)** - Request timeout
- **Auth** - Authorization (.currentUser, .none)

## Response Handling

All responses are wrapped in `ApiResponse<T>`:

```swift
let response = try await client.perform(request: request, serializer: serializer)
let data = response.value           // Deserialized response data
let statusCode = response.statusCode // HTTP status code
let httpResponse = response.httpResponse // Raw HTTPURLResponse
```
