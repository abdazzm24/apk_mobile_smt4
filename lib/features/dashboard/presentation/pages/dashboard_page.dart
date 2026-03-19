import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week4/core/constants/app_constants.dart';
import 'package:week4/core/widgets/common_widgets.dart';
import 'package:week4/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:week4/features/dashboard/presentation/widgets/dashboard_widgets.dart';
import 'package:week4/features/mahasiswa/presentation/pages/mahasiswa_page.dart';
import 'package:week4/features/mahasiswa_aktif/presentation/pages/mahasiswa_aktif_page.dart';
import 'package:week4/features/dosen/presentation/pages/dosen_page.dart';
import 'package:week4/features/profile/presentation/pages/profile_page.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  // get icon
  IconData _getIconForStat(String title) {
    switch (title) {
      case 'Mahasiswa':
        return Icons.school_rounded;
      case 'Mahasiswa Aktif':
        return Icons.person_outline_rounded;
      case 'Dosen':
        return Icons.people_outline_rounded;
      case 'Profile':
        return Icons.workspace_premium_rounded;
      default:
        return Icons.analytics_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final selectedIndex = ref.watch(selectedStatIndexProvider);

    return Scaffold(
      body: dashboardState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: ${error.toString()}',
          onRetry: () {
            ref.read(dashboardNotifierProvider.notifier).refresh();
          },
        ), // CustomErrorWidget
        data: (dashboardData) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(dashboardNotifierProvider);
            },
            child: CustomScrollView(
              slivers: [
                // Modern Header with Gradient
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withBlue(220),
                        ],
                      ), // LinearGradient
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ), // BorderRadius.only
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ), // BoxShadow
                      ],
                    ), // BoxDecoration
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Selamat Datang! 👋',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ), // TextStyle
                                      ), // Text
                                      const SizedBox(height: 8),
                                      Text(
                                        dashboardData.userName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.5,
                                        ), // TextStyle
                                      ), // Text
                                    ],
                                  ), // Column
                                ), // Expanded
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 2,
                                    ), // Border.all
                                  ), // BoxDecoration
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.notifications_outlined,
                                      color: Colors.white,
                                      size: 26,
                                    ), // Icon
                                    onPressed: () {},
                                  ), // IconButton
                                ), // Container
                              ],
                            ), // Row
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ), // EdgeInsets.symmetric
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ), // Border.all
                              ), // BoxDecoration
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.white.withOpacity(0.9),
                                    size: 18,
                                  ), // Icon
                                  const SizedBox(width: 12),
                                  Text(
                                    'Update: ${_formatDate(dashboardData.lastUpdate)}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ), // TextStyle
                                  ), // Text
                                ],
                              ), // Row
                            ), // Container
                          ],
                        ), // Column
                      ), // Padding
                    ), // SafeArea
                  ), // Container
                ), // SliverToBoxAdapter

                // Stats Section with Modern Cards
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Statistik',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ), // TextStyle
                            ), // Text
                            TextButton.icon(
                              onPressed: () {
                                ref.invalidate(dashboardNotifierProvider);
                              },
                              icon: const Icon(Icons.refresh_rounded, size: 18),
                              label: const Text('Refresh'),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ), // TextButton.icon
                          ],
                        ), // Row
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.1,
                          ),
                          itemCount: dashboardData.stats.length,
                          itemBuilder: (context, index) {
                            final stat = dashboardData.stats[index];
                            return ModernStatCard(
                              stats: stat,
                              icon: _getIconForStat(stat.title),
                              gradientColors: AppConstants.dashboardGradients[
                              index % AppConstants.dashboardGradients.length],
                              isSelected: selectedIndex == index,
                              onTap: () {
                                ref.read(selectedStatIndexProvider.notifier).state = index;

                                final statTitle = stat.title;
                                Widget? targetPage;

                                if (statTitle.contains('Mahasiswa Aktif')) {
                                  targetPage = const MahasiswaAktifPage();
                                } else if (statTitle.contains('Mahasiswa')) {
                                  targetPage = const MahasiswaPage();
                                } else if (statTitle.contains('Dosen')) {
                                  targetPage = const DosenPage();
                                } else if (statTitle.contains('Profile')) {
                                  targetPage = const ProfilePage();
                                }

                                if (targetPage != null) {
                                  Navigator.push(
                                    context,
                                    _createRoute(targetPage),
                                  );
                                }
                              },
                            ); // ModernStatCard
                          },
                        ), // GridView.builder
                      ],
                    ), // Column
                  ), // SliverToBoxAdapter
                ), // SliverPadding
                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
              ],
            ), // CustomScrollView
          ); // RefreshIndicator
        },
      ), // body
    ); // Scaffold
  }

  // Helper untuk format tanggal (Asumsi implementasi)
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  // Helper untuk animasi route (Asumsi implementasi)
  Route _createRoute(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }
}