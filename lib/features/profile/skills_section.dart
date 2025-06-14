import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;
  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Skills', style: TextStyle(fontWeight: FontWeight.bold)),
        if (skills.isEmpty) 
          const Text('No skills added yet')
        else
          Wrap(children: skills.map((s) => Chip(label: Text(s.name))).toList()),
      ],
    );
  }
}