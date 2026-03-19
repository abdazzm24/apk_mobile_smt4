import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mahasiswa_aktif_provider.dart';
import '../widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {

  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final mahasiswaState = ref.watch(mahasiswaAktifProvider);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Mahasiswa Aktif"),
      ),

      body: mahasiswaState.when(

        loading: () =>
        const Center(child: CircularProgressIndicator()),

        error: (error, stack) =>
            Center(child: Text(error.toString())),

        data: (mahasiswaList) {

          final gradients = [

            [Colors.blue, Colors.indigo],

            [Colors.pink, Colors.redAccent],

            [Colors.green, Colors.teal],

            [Colors.orange, Colors.deepOrange],

            [Colors.purple, Colors.deepPurple],

          ];

          return ListView.builder(

            padding: const EdgeInsets.all(16),

            itemCount: mahasiswaList.length,

            itemBuilder: (context,index){

              final mahasiswa = mahasiswaList[index];

              return MahasiswaAktifCard(
                mahasiswa: mahasiswa,
                gradient: gradients[index % gradients.length],
              );
            },

          );
        },
      ),
    );
  }
}