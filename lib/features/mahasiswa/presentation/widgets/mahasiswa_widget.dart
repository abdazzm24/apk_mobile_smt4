import 'package:flutter/material.dart';
import '../../data/models/mahasiswa_model.dart';

class MahasiswaCard extends StatelessWidget {

  final MahasiswaModel mahasiswa;
  final VoidCallback? onTap;
  final List<Color> gradientColors;
  final List<Color> avatarGradient;

  const MahasiswaCard({
    super.key,
    required this.mahasiswa,
    required this.gradientColors,
    required this.avatarGradient,
    this.onTap,
  });

  Widget buildInfo(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),

        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(

          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withOpacity(0.35),
              blurRadius: 10,
              offset: const Offset(0,5),
            )
          ],
        ),

        child: Row(
          children: [


            Container(

              width: 50,
              height: 50,

              decoration: BoxDecoration(

                gradient: LinearGradient(
                  colors: avatarGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                borderRadius: BorderRadius.circular(14),

                boxShadow: [
                  BoxShadow(
                    color: avatarGradient.first.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0,3),
                  )
                ],
              ),

              child: Center(
                child: Text(
                  mahasiswa.name.substring(0,1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    mahasiswa.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),

                  buildInfo(mahasiswa.email),

                  buildInfo(mahasiswa.body),

                ],
              ),
            ),

            Container(

              padding: const EdgeInsets.all(8),

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),

              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.black87,
              ),
            )

          ],
        ),
      ),
    );
  }
}