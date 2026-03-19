import 'package:flutter/material.dart';
import '../../data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifCard extends StatelessWidget {

  final MahasiswaAktifModel mahasiswa;
  final List<Color> gradient;

  const MahasiswaAktifCard({
    super.key,
    required this.mahasiswa,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.only(bottom: 14),

      decoration: BoxDecoration(

        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: gradient.first.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0,3),
          )
        ],
      ),

      child: ListTile(

        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

        leading: CircleAvatar(

          backgroundColor: Colors.white,

          child: Text(
            mahasiswa.id.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        title: Text(
          mahasiswa.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        subtitle: Text(
          mahasiswa.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.white,
        ),

      ),
    );
  }
}