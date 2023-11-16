# Generative Language API

## Overview

The PaLM API allows developers to build generative AI applications using the PaLM model. Large Language Models (LLMs) are a powerful, versatile type of machine learning model that enables computers to comprehend and generate natural language through a series of prompts. The PaLM API is based on Google's next generation LLM, PaLM. It excels at a variety of different tasks like code generation, reasoning, and writing. You can use the PaLM API to build generative AI applications for use cases like content generation, dialogue agents, summarization and classification systems, and more.

### API Version

By default, this project use v1beta2 version of the API. If you want to use higher version of the API select the version in the service to use

```dart
service = TextService(apiClient: PalmClient(apiVersion: PalmApiVersion.v1Beta3), ...);
```

### Service Endpoint

```
Service: generativelanguage.googleapis.com
```

To call this service, we recommend that you use the Google-provided client libraries. If your application needs to use your own libraries to call this service, use the following information when you make the API requests.

```
Service endpoint:
https://generativelanguage.googleapis.com

REST
Resource: v1beta2.models
```

### Methods

| Method                                              | Description                                                       |
| --------------------------------------------------- | ----------------------------------------------------------------- |
| `POST /v1beta2/{model=models/*}:countMessageTokens` | Runs a model's tokenizer on a string and returns the token count. |
| `POST /v1beta2/{model=models/*}:embedText`          | Generates an embedding from the model given an input message.     |
| `POST /v1beta2/{model=models/*}:generateMessage`    | Generates a response from the model given an input MessagePrompt. |
| `POST /v1beta2/{model=models/*}:generateText`       | Generates a response from the model given an input message.       |
| `GET /v1beta2/{name=models/*}`                      | Gets information about a specific Model.                          |
| `GET /v1beta2/models`                               | Lists models available through the API.                           |

### Resource: models

The `Model` resource provides information about a Generative Language Model.

```json
{
  "name": "string",
  "baseModelId": "string",
  "version": "string",
  "displayName": "string",
  "description": "string",
  "inputTokenLimit": "integer",
  "outputTokenLimit": "integer",
  "supportedGenerationMethods": ["string"],
  "temperature": "number",
  "topP": "number",
  "topK": "integer"
}
```

- `name`: Required. The resource name of the Model. Format: `models/{model}`
- `baseModelId`: Required. The name of the base model.
- `version`: Required. The version number of the model.
- `displayName`: The human-readable name of the model.
- `description`: A short description of the model.
- `inputTokenLimit`: Maximum number of input tokens allowed for this model.
- `outputTokenLimit`: Maximum number of output tokens available for this model.
- `supportedGenerationMethods[]`: The model's supported generation methods.
- `temperature`: Controls the randomness of the output.
- `topP`: For Nucleus sampling.
- `topK`: For Top-k sampling.

### Models Methods

- `countMessageTokens`: Runs a model's tokenizer on a string and returns the token count.
- `embedText`: Generates an embedding from the model given an input message.
- `generateMessage`: Generates a response from the model given an input MessagePrompt.
- `generateText`: Generates a response from the model given an input message.
- `get`: Gets information about a specific Model.
- `list`: Lists models available through the API.

## countMessageTokens

Runs a model's tokenizer on a string and returns the token count.

**HTTP Request**

```
POST https://generativelanguage.googleapis.com/v1beta2/{model=models/*}:countMessageTokens
```

**Path Parameters**

- `model`: Required. The model's resource name.

**Request Body**

```json
{
  "prompt": {
    "object": "MessagePrompt"
  }
}
```

- `prompt`: Required. The prompt whose token count is to be returned.

**Response Body**

```json
{
  "tokenCount": "integer"
}
```

- `tokenCount`: The number of tokens that the model tokenizes the prompt into.

## embedText

Generates an embedding from the model given an input message.

**HTTP Request**

```
POST https://generativelanguage.googleapis.com/v1beta2/{model=models/*}:embedText
```

**Path Parameters**

- `model`: Required. The model name to use.

**Request Body**

```json
{
  "text": "string"
}
```

- `text`: Required. The input text to generate embedding for.

**Response Body**

```json
{
  "embedding": {
    "object": "Embedding"
  }
}
```

- `embedding`: Output only. The embedding generated from the input text.

## generateMessage

Generates a response from the model given an input MessagePrompt.

**HTTP Request**

```
POST https://generativelanguage.googleapis.com/v1beta2/{model=models/*}:generateMessage
```

**Path Parameters**

- `model`: Required. The name of the model to use.

**Request Body**

```json
{
  "prompt": {
    "object": "MessagePrompt"
  },
  "temperature": "number",
  "candidateCount": "integer",
  "topP": "number",
  "topK": "integer"
}
```

- `prompt`: Required. The input prompt.
- `temperature`: Optional. Controls output randomness.
- `candidateCount`: Optional. Number of responses to return.
- `topP`: Optional. Nucleus sampling parameter.
- `topK`: Optional. Top-k sampling parameter.

**Response Body**

```json
{
  "candidates": [
    {
      "object": "Message"
    }
  ],
  "messages": [
    {
      "object": "Message"
    }
  ],
  "filters": [
    {
      "object": "ContentFilter"
    }
  ]
}
```

- `candidates[]`: Candidate response messages.
- `messages[]`: Conversation history.
- `filters[]`: Content filtering metadata.

## generateText

Generates a response from the model given an input message.

**HTTP Request**

```
POST https://generativelanguage.googleapis.com/v1beta2/{model=models/*}:generateText
```

**Path Parameters**

- `model`: Required. The model name to use.

**Request Body**

```json
{
  "prompt": {
    "object": "TextPrompt"
  },
  "safetySettings": [
    {
      "object": "SafetySetting"
    }
  ],
  "stopSequences": ["string"],
  "temperature": "number",
  "candidateCount": "integer",
  "maxOutputTokens": "integer",
  "topP": "number",
  "topK": "integer"
}
```

- `prompt`: Required. The input prompt text.
- `safetySettings[]`: Optional. Safety settings.
- `stopSequences[]`: Optional. Stop sequence strings.
- `temperature`: Optional. Controls output randomness.
- `candidateCount`: Optional. Number of responses to return.
- `maxOutputTokens`: Optional. Maximum output length.
- `topP`: Optional. Nucleus sampling parameter.
- `topK`: Optional. Top-k sampling parameter.

**Response Body**

```json
{
  "candidates": [
    {
      "object": "TextCompletion"
    }
  ],
  "filters": [
    {
      "object": "ContentFilter"
    }
  ],
  "safetyFeedback": [
    {
      "object": "SafetyFeedback"
    }
  ]
}
```

- `candidates[]`: Candidate response messages.
- `filters[]`: Content filtering metadata.
- `safetyFeedback[]`: Safety feedback.

## models.get

Gets information about a specific Model.

**HTTP Request**

```
GET https://generativelanguage.googleapis.com/v1beta2/{name=models/*}
```

**Path Parameters**

- `name`: Required. The resource name of the model.

**Response Body**

Returns a `Model` resource.

Here is the embedText documentation in Markdown format:

## embedText

Generates an embedding from the model given one or more input messages.

**HTTP Request**

```
POST https://generativelanguage.googleapis.com/v1beta2/{model=models/*}:embedText
```

**Path Parameters**

- `model`: Required. The model name to use.

**Request Body**

```json
{
  "texts": ["string"]
}
```

- `texts`: Required. One or more input texts to generate embeddings for.

**Response Body**

```json
{
  "embeddings": [
    {
      "object": "Embedding"
    }
  ]
}
```

- `embeddings[]`: Output only. The embeddings generated from the input texts, in the same order.

### Embedding

A generated embedding for text.

```json
{
  "values": ["number"]
}
```

- `values[]`: The embedding values.

Let me know if you would like me to modify or expand this embedText Markdown documentation further.

## models.list

Lists models available through the API.

**HTTP Request**

```
GET https://generativelanguage.googleapis.com/v1beta2/models
```

**Query Parameters**

- `pageSize`: Maximum number of models to return per page.
- `pageToken`: Page token received from a previous call.

**Response Body**

```json
{
  "models": [
    {
      "object": "Model"
    }
  ],
  "nextPageToken": "string"
}
```

- `models[]`: The returned Models.
- `nextPageToken`: Token to retrieve the next page.

## Objects

### CitationMetadata

Metadata about the source of generated content.

```json
{
  "citationSources": [
    {
      "object": "CitationSource"
    }
  ]
}
```

- `citationSources[]`: Citations to sources for the content.

### CitationSource

Source citation for a portion of the content.

```json
{
  "startIndex": "integer",
  "endIndex": "integer",
  "uri": "string",
  "license": "string"
}
```

- `startIndex`: Start of attributed segment.
- `endIndex`: End of attributed segment.
- `uri`: URI of attributed source.
- `license`: License for attributed code.

### ContentFilter

Content filtering metadata.

```json
{
  "reason": "enum",
  "message": "string"
}
```

- `reason`: The filtering reason.
- `message`: Description of the filtering.

### SafetySetting

Safety setting configuration.

```json
{
  "category": "enum",
  "threshold": "enum"
}
```

- `category`: Required. The safety category.
- `threshold`: Required. The blocking threshold.

### TextPrompt

Input text prompt.

```json
{
  "text": "string"
}
```

- `text`: Required. The prompt text.

### TextCompletion

Generated text response.

```json
{
  "output": "string",
  "safetyRatings": [
    {
      "object": "SafetyRating"
    }
  ],
  "citationMetadata": {
    "object": "CitationMetadata"
  }
}
```

- `output`: Output only. The generated text.
- `safetyRatings[]`: Safety ratings.
- `citationMetadata`: Attribution metadata.

### SafetyRating

Safety rating for content.

```json
{
  "category": "enum",
  "probability": "enum"
}
```

- `category`: Required. The safety category.
- `probability`: Required. The harm probability.

### SafetyFeedback

Safety feedback for the request.

```json
{
  "rating": {
    "object": "SafetyRating"
  },
  "setting": {
    "object": "SafetySetting"
  }
}
```

- `rating`: Safety rating that triggered blocking.
- `setting`: Safety setting applied.

### Message

Structured message unit.

```json
{
  "author": "string",
  "content": "string",
  "citationMetadata": {
    "object": "CitationMetadata"
  }
}
```

- `author`: Optional. Message author.
- `content`: Required. Message text.
- `citationMetadata`: Attribution metadata.

### MessagePrompt

Structured prompt with context, examples, and messages.

```json
{
  "context": "string",
  "examples": [
    {
      "object": "Example"
    }
  ],
  "messages": [
    {
      "object": "Message"
    }
  ]
}
```

- `context`: Optional. Grounding context.
- `examples[]`: Optional. Input/output examples.
- `messages[]`: Required. Conversation history.

### Example

Input/output example.

```json
{
  "input": {
    "object": "Message"
  },
  "output": {
    "object": "Message"
  }
}
```

- `input`: Example input.
- `output`: Expected output.

## Prompt Precedence

The `MessagePrompt` contains `context`, `examples`, and `messages` fields. These have the following precedence if the total input size exceeds the model's `inputTokenLimit`:

1. `context` - The context will be kept first if provided. Context gives high-level instructions and guidance to the model.

2. `examples` - Example inputs and outputs will be kept next. Examples demonstrate desired model behavior.

3. `messages` - Message history will be truncated last. Older messages are dropped to fit within limits.

This means `context` and `examples` take precedence over `messages` when the input must be truncated.

For example:

```json
{
  "context": "Translate the following sentences to French",

  "examples": [
    {
      "input": {
        "content": "Hello there!"
      },
      "output": {
        "content": "Bonjour!"
      }
    }
  ],

  "messages": [
    {
      "content": "Hello my friend."
    },
    {
      "content": "How are you today?"
    }
  ]
}
```

If this exceeds the `inputTokenLimit`, the oldest `messages` will be dropped first. The `context` and `examples` will be preserved, since they provide important guidance to the model.

Let me know if this helps explain the precedence and relationship between the different `MessagePrompt` fields!
