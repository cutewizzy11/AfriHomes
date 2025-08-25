import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class KycGateScreen extends StatefulWidget {
  const KycGateScreen({super.key});

  @override
  State<KycGateScreen> createState() => _KycGateScreenState();
}

class _KycGateScreenState extends State<KycGateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _nin;
  String? _bvn;
  final Map<String, PlatformFile?> _docs = {
    'C of O': null,
    "Governor's Consent": null,
    'Survey Plan': null,
    'Deed of Assignment/Conveyance': null,
  };

  Future<void> _pickDoc(String key) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png']);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _docs[key] = result.files.first;
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final bool hasRequired = _docs['C of O'] != null || _docs["Governor's Consent"] != null;
    final bool hasSurvey = _docs['Survey Plan'] != null;
    final bool hasDeed = _docs['Deed of Assignment/Conveyance'] != null;
    if (!hasRequired || !hasSurvey || !hasDeed) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please upload required ownership documents.')));
      return;
    }
    // Later: send to backend and wait for admin approval
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('KYC submitted. Awaiting admin review.')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Verify your identity', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text('KYC is required before publishing your first listing. Your details are encrypted and reviewed by admin.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'NIN (optional but recommended)'),
                          onChanged: (v) => _nin = v,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'BVN (required)'),
                          validator: (v) => (v == null || v.isEmpty) ? 'BVN is required' : null,
                          onChanged: (v) => _bvn = v,
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 300.ms),
              const SizedBox(height: 16),
              Text('Upload ownership documents', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              ..._docs.keys.map((k) => _DocTile(title: k, file: _docs[k], onPick: () => _pickDoc(k))).toList(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.verified_user_outlined),
                  label: const Text('Submit for review'),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text('Admin typically reviews within 24–48 hours', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocTile extends StatelessWidget {
  final String title;
  final PlatformFile? file;
  final VoidCallback onPick;
  const _DocTile({required this.title, required this.file, required this.onPick});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        subtitle: Text(file == null ? 'No file selected' : file!.name,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        trailing: FilledButton.tonal(onPressed: onPick, child: const Text('Upload')),
      ),
    ).animate().fadeIn(duration: 200.ms);
  }
}

