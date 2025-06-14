import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => ref.read(currentIndexProvider.notifier).state = index,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey.shade400,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people), 
          label: 'Workers'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

  void _onItemTapped(int index, WidgetRef ref, BuildContext context) {
    ref.read(currentIndexProvider.notifier).state = index;
    
    // Optional: If you want to use named routes instead of IndexedStack
    // String route;
    // switch (index) {
    //   case 0: route = AppRoutes.home; break;
    //   case 1: route = AppRoutes.search; break;
    //   case 2: route = AppRoutes.messages; break;
    //   case 3: route = AppRoutes.savedJobs; break;
    //   case 4: route = AppRoutes.profile; break;
    //   default: route = AppRoutes.home;
    // }
    // Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }
