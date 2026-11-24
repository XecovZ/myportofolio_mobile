import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final apiClient = context.read<ApiClient>();
    final auth = context.read<AuthState>();

    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final token = auth.token;
    if (token == null) return;

    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      final created = await apiClient.createProject(newProject, token: token);
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Project created!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Title: ${created.title}'),
                Text('Description: ${created.description}'),
                Text('Tech Stack: ${created.techStack}'),
                Text('Project URL: ${created.projectUrl}'),
                if (created.projectImageUrl.isNotEmpty)
                  Text('Image URL: ${created.projectImageUrl}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (!mounted) return;
      _formKey.currentState!.reset();
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await auth.logout();
        if (!mounted) return;
        _showSnackBar('Session expired. Please log in again.');
        await ensureLoggedIn(context);
      } else {
        _showSnackBar('Failed to save project (${e.statusCode}).');
      }
    } catch (_) {
      if (!mounted) return;
      _showSnackBar('Cannot reach the server.');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      hintText: hint ?? label,
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: _decoration('Title'),
                  onChanged: (value) => _title = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title cannot be empty!';
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: _decoration('Description'),
                  onChanged: (value) => _description = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description cannot be empty!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tech Stack ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: _decoration(
                    'Tech Stack',
                    hint: 'e.g. Flutter, Django, Figma',
                  ),
                  onChanged: (value) => _techStack = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Tech stack cannot be empty!';
                    }
                    return null;
                  },
                ),
              ),

              // === Project URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: _decoration(
                    'Project URL',
                    hint: 'https://github.com/...',
                  ),
                  onChanged: (value) => _projectUrl = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Project URL cannot be empty!';
                    }
                    if (!_isValidUrl(value.trim())) {
                      return 'Enter a valid URL (http:// or https://).';
                    }
                    return null;
                  },
                ),
              ),

              // === Project Image URL (optional) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: _decoration('Project Image URL (Optional)'),
                  onChanged: (value) => _projectImageUrl = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return null;
                    if (!_isValidUrl(value.trim())) {
                      return 'Enter a valid URL (http:// or https://).';
                    }
                    return null;
                  },
                ),
              ),

              // === Save ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
