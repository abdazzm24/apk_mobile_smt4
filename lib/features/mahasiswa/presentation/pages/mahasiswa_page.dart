import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mahasiswa_provider.dart';
import '../widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {

  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final mahasiswaState = ref.watch(mahasiswaProvider);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Data Mahasiswa"),
      ),

      body: mahasiswaState.when(

        loading: () =>
        const Center(child: CircularProgressIndicator()),

        error: (error, stack) =>
            Center(child: Text(error.toString())),

        data: (mahasiswaList) {

          return ListView.builder(

            itemCount: mahasiswaList.length,

            itemBuilder: (context,index){

              final mahasiswa = mahasiswaList[index];

              final gradients = [

                [Color(0xFFFFF3B0), Color(0xFFFFD6A5)],

                [Color(0xFFBDE0FE), Color(0xFFA2D2FF)],

                [Color(0xFFCDB4DB), Color(0xFFFFAFCC)],

                [Color(0xFFCAFFBF), Color(0xFF9BF6FF)],

                [Color(0xFFFFADAD), Color(0xFFFFD6A5)],

              ];

              final avatarGradients = [

                [Colors.orange, Colors.deepOrange],

                [Colors.blue, Colors.indigo],

                [Colors.purple, Colors.pink],

                [Colors.green, Colors.teal],

                [Colors.red, Colors.orange],

              ];

              return MahasiswaCard(
                mahasiswa: mahasiswa,
                gradientColors: gradients[index % gradients.length],
                avatarGradient: avatarGradients[index % avatarGradients.length],
              );
            },

          );

        },

      ),
    );
  }
}