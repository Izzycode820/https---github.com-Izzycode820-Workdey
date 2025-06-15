import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/route_state_provider.dart';

class JobSectionSelector extends ConsumerWidget {
  const JobSectionSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSection = ref.watch(appSectionProvider);
    final navigator = ref.read(sectionNavigationProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5E7D5E).withOpacity(0.31),
              blurRadius: 25,
              offset: const Offset(0, 4),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => navigator.navigateToFindJobs(context),
                child: Center(
                  child: Text(
                    'Find Jobs',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: currentSection == AppSection.findJobs
                        ? const Color(0xFF07864B) 
                        : const Color(0xFF1E1E1E),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 19,
              color: const Color(0xFF1E1E1E),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => navigator.navigateToPostJobs(context),
                child: Center(
                  child: Text(
                    'Post Job',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: currentSection == AppSection.postJobs
                        ? const Color(0xFF07864B) 
                        : const Color(0xFF1E1E1E),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}