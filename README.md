# PaLM API Client

A Dart client for interacting with the PaLM API, allowing developers to build generative AI applications.

## About PaLM

The [PaLM API](https://developers.generativeai.google) is based on Google's next-generation LLM, PaLM. It excels at a variety of different tasks like code generation, reasoning, and writing. You can use the PaLM API to build generative AI applications for use cases like content generation, dialogue agents, summarization and classification systems, and more.

For more information, refer to the official PaLM API documentation:

- [PaLM API Guide](https://developers.generativeai.google/guide/palm_api_overview)
- [PaLM API Documentation](https://developers.generativeai.google/api)

## Installation

To use this package, add `palm_api` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

```yaml
dependencies:
  palm_api: latest
```

## Usage

To use this package, you need to:

1. Obtain an [API key](https://developers.generativeai.google/tutorials/setup) for the Google Palm API 
2. Instantiate the service by passing your API key.
3. Use the client to access the API endpoints.

For example:

```dart
import 'package:palm_api/palm_api.dart';

// Instantiate the client
final palm = TextService(apiKey: 'YOUR_API_KEY');

// Generate a message 
final response = await palm.generateText(
  model: PalmModel.textBison001.name, // or 'text-bison-001',
  prompt: TextPrompt(text: 'Hello'), 
);

// Print the candidates
response.candidates.forEach(print);
```

## Features

ModelService:

- `listModel`: Lists available models.  
- `getModel`: Get the `Model` for the given model name.  

DiscussService:

- `generateMessage`: Generates message responses for chatbots and assistants.
- `countMessageTokens`: Counts the number of tokens in a prompt for a given model.

TextService:  

- `generateText`: Generates text completions
- `embedText`: Gets text embeddings for a given text input.

## Model Parameters

The PaLM API allows you to customize the generated text by specifying various parameters. Below are some of the key parameters that you can set when sending a request to the API:

- `model`: (Required) The model name to use with the format
- `prompt`: (Required) The free-form input text given to the model as a prompt. Given a prompt, the model will generate a TextCompletion response it predicts as the completion of the input text.
- `temperature`: Controls the randomness of the output. Values can range from 0.0 to 1.0, inclusive. A value closer to 1.0 will produce responses that are more varied and creative, while a value closer to 0.0 will typically result in more straightforward responses from the model.
- `candidateCount`: Number of generated responses to return. This value must be between 1 and 8, inclusive. If unset, this will default to 1.
- `maxOutputTokens`: The maximum number of tokens to include in a candidate. If unset, this will default to 64.
- `topP`: The maximum cumulative probability of tokens to consider when sampling. The model uses combined Top-k and nucleus sampling. Tokens are sorted based on their assigned probabilities so that only the most likely tokens are considered.
- `topK`: The maximum number of tokens to consider when sampling. The model uses combined Top-k and nucleus sampling. Top-k sampling considers the set of `top_k` most probable tokens. Defaults to 40.
- `stopSequences`: The set of character sequences (up to 5) that will stop output generation. If specified, the API will stop at the first appearance of a stop sequence. The stop sequence will not be included as part of the response.

## TODO:
- [ ] Makersuite jSON export support
- [ ] Proxy using for API KEY security

