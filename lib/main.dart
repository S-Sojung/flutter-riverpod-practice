import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class NumCounter extends StateNotifier<int> {
//   NumCounter(int num) : super(num);
//
//   void increment(){
//     state++;
//   }
// }
//
// final numCounter = StateNotifierProvider<NumCounter, int>((ref) {
//   return NumCounter(0);
// });


// class Person{
//   String name;
//   int age;
//   Person(this.name, this.age);
// }
// class PersonCounter extends StateNotifier<Person> {
//   PersonCounter() : super(null);
//
//   void increment(){
//     state.name="dd";
//     state.age = 11;
//   }
// }
//
// final personProvider = StateNotifierProvider<PersonCounter, Person>((ref) {
//   return PersonCounter();
// });


class Counter extends StateNotifier<int> {
  //창고를 만들 때 클래스로 만들어야 함 : 값을 변경 할 수 있기 때문에
  //얘가 관리할 창고 데이터타입 (다운 받을 DTO 타입을 넣어주면됨) : int

  Counter() : super(0); //부모클래스에 0을 넣어 생성자 생성

  void increment(){
    state++;
  }
}

final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  //변경 가능한 데이터를 가지고 있는 클래스가 필요함 : StateNotifier 얘를 상속 받은
  //얘가 관리하는 데이터의 상태가 state
  return Counter();
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
    final int value = ref.watch(counterProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Text("$value"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // ref.read(counterProvider.notifier).state++;
            ref.read(counterProvider.notifier).increment();
            //일반적인 Provider라면 .notifier 가 나오지 않는다.
            //.notifier를 통해서 해당 메서드를 사용가능
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
