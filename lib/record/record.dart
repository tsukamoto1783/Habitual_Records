import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'record_model.dart';

class Record extends StatelessWidget {
  const Record({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("記録"),
        ),
        body: const SizedBox.expand(child: RecordBody()));
  }
}

class RecordBody extends ConsumerWidget {
  const RecordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insRecord = ref.watch(recordProvider.notifier);

    return FutureBuilder(
        future: insRecord.getTimeSet(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // 通信が失敗した場合
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          // snapshot.dataにデータが格納されていれば
          if (snapshot.hasData) {
            return AspectRatio(
              aspectRatio: 1.7,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                margin: const EdgeInsets.all(0.0),
                color: const Color(0xff2c4260),
                child: RecordBarChart(snapshot.data),
              ),
            );
          }
          return const Text('もう一度やり直してください。');
        });
  }
}
