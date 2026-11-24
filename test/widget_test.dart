import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/screens/project_detail_screen.dart';

void main() {
  test('Project.fromJson maps snake_case keys', () {
    final project = Project.fromJson({
      'id': 'abc',
      'title': 'Test',
      'description': 'Desc',
      'tech_stack': 'Flutter',
      'project_url': 'https://example.com',
      'project_image_url': null,
    });

    expect(project.techStack, 'Flutter');
    expect(project.projectImageUrl, '');
    expect(project.toJson().containsKey('id'), isFalse);
  });

  testWidgets('ProjectDetailScreen shows project info', (tester) async {
    const project = Project(
      title: 'My App',
      description: 'A test project',
      techStack: 'Flutter',
      projectUrl: 'https://example.com',
    );

    await tester.pumpWidget(
      const MaterialApp(home: ProjectDetailScreen(project: project)),
    );

    expect(find.text('A test project'), findsOneWidget);
    expect(find.text('Tech Stack: Flutter'), findsOneWidget);
  });
}
