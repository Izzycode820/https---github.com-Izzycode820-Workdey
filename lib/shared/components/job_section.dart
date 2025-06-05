import 'package:flutter/material.dart';

class JobSectionSelector extends StatelessWidget {
  final bool isFindJobsSelected;
  final VoidCallback onFindJobsTap;
  final VoidCallback onPostJobTap;
  
  const JobSectionSelector({
    super.key,
    required this.isFindJobsSelected,
    required this.onFindJobsTap,
    required this.onPostJobTap,
  });

  @override
  Widget build(BuildContext context) {
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
                onTap: onFindJobsTap,
                child: Center(
                  child: Text(
                    'Find Jobs',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isFindJobsSelected 
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
                onTap: onPostJobTap,
                child: Center(
                  child: Text(
                    'Post Job',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: !isFindJobsSelected 
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