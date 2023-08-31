import 'dart:io';

import 'package:uuid/v8.dart';

const String path = 'lib/assets/models/';
Future<void> main() async {
  await generateIds(amount: 10, name: 'thread');
}

Future<void> generateIds({
  required int amount,
  required String name,
}) async {
  final ids = List.generate(
    amount,
    (index) => const UuidV8().generate(),
  );

  final File newFile = File("$path/$name/${name}_ids.txt");

  for (var element in ids) {
    await newFile.writeAsString('$element\n', mode: FileMode.append);
  }
}
