import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});


  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Loading movies',
      'Buying popcorns',
      'Loading populars',
      'Loading itsumi power',
      'plus ultra',
      'it is taking more time than expected',
    ];

    return Stream.periodic(
      const Duration(milliseconds: 300),
      (step) => messages[step]
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Please wait'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(), 
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text('Loading..');

              return Text(snapshot.data!);
            }
          )
        ]
      ),
    );
  }
}