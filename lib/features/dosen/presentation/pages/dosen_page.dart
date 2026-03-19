import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week4/core/widgets/common_widgets.dart';
import 'package:week4/features/dosen/presentation/providers/dosen_provider.dart';
import 'package:week4/features/dosen/presentation/widgets/dosen_widget.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(dosenNotifierProvider);
            },
            tooltip: 'Refresh',
          ), // iconbutton
        ],
      ), // appbar
      body: dosenState.when(
        // state : loading
        loading: () => const LoadingWidget(),

        // state : error
        error: (error, stack) => CustomErrorWidget(
            message: 'gagal memuat data dosen: ${error.toString()}',
            onRetry: () {
              ref.read(dosenNotifierProvider.notifier).refresh();
            },
        ), // customerrorwidget

        // state : memanggil data dari dosen list dan memanggil widget
        data: (dosenList) {
            return DosenListView(
                dosenList: dosenList,
                onRefresh: () {
                  ref.invalidate(dosenNotifierProvider);
                },
                useModernCard: true,
            ); // dosenlistview
          },
        ),
    ); // scaffold
  }
}