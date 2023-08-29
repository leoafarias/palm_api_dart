#!/usr/bin/env dart

import 'dart:io';

void main() {
  final rootDirectory = Directory.current;
  final libFolder = Directory('${rootDirectory.path}/lib');
  final codebaseFile = File('${rootDirectory.path}/issues/codebase.md');

  if (codebaseFile.existsSync()) {
    codebaseFile.deleteSync(recursive: true);
  }

  codebaseFile.createSync(recursive: true);

  final files = libFolder.listSync(recursive: true, followLinks: false);
  for (final file in files) {
    if (file.path.endsWith('.dart')) {
      final relativeFilePath = file.path.substring(file.path.indexOf('lib'));
      final content = (file as File).readAsStringSync();

      codebaseFile.writeAsStringSync(
          '## $relativeFilePath\n\n```dart\n$content\n```\n\n',
          mode: FileMode.append);
    }
  }

  print('Codebase.md file created successfully!');
}
