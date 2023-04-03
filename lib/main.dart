import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
// final helloWorldProvider = Provider((_) => 'Hello worldaaaaaa');
//제네릭으로 되어잇어서 창고에 저장될 데이터 타입을 저장 할 수 있다. 생략가능하지만 적어주자
final helloWorldProvider = Provider<String>((ref) {
  return "Hello world";
});

final byeProvider = Provider<String>((ref) {
  final String value = ref.read(helloWorldProvider);

  return "Bye world ->" + value;
});

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final String value = ref.watch(helloWorldProvider);
    final String value = ref.read(helloWorldProvider);
    final String value2 = ref.read(byeProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Text(value +" : "+ value2),
        ),
      ),
    );
  }
}
