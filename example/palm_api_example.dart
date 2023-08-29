import 'package:palm_api/palm_api.dart';

Future<void> main() async {
// Instantiate the client
  final palm = TextService(apiKey: 'YOUR_API_KEY');

// Generate a message
  final response = await palm.generateText(
    model: PalmModel.textBison001.name, // or 'text-bison-001'
    prompt: TextPrompt(text: 'Hello'),
  );

// Print the candidates
  response.candidates.forEach(print);
}
