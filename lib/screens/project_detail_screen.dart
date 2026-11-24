import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.projectImageUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  project.projectImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('Failed to load image.'),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(project.title, style: textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Tech Stack: ${project.techStack}',
              style: textTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            Text(project.description),
            if (project.projectUrl.isNotEmpty) ...[
              const SizedBox(height: 16),
              SelectableText('Project URL: ${project.projectUrl}'),
            ],
          ],
        ),
      ),
    );
  }
}
