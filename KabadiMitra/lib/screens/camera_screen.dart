import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';
import 'add_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String? preview;

  Future<void> _pick(ImageSource src) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: src, maxWidth: 800, imageQuality: 70);
    if (file != null) {
      setState(() => preview = file.path);
    }
  }

  void _keep() {
    if (preview == null) return;
    context.read<AppStore>().setPendingPhoto(preview);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AddScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<AppStore>().language;
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "cameraTitle"))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ScreenTitle(title: I18n.t(lang, "cameraTitle"), sub: I18n.t(lang, "cameraSub")),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: preview != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          File(preview!),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return const Center(
                              child: Icon(Icons.image, size: 64, color: AppColors.muted),
                            );
                          },
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.camera_alt, size: 56, color: AppColors.muted),
                          const SizedBox(height: 8),
                          Text(
                            I18n.t(lang, "noPhoto"),
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),
            BigButton(
              label: I18n.t(lang, "takePhoto"),
              icon: Icons.camera_alt,
              onPressed: () => _pick(ImageSource.camera),
            ),
            const SizedBox(height: 10),
            BigButton(
              label: I18n.t(lang, "fromGallery"),
              primary: false,
              icon: Icons.photo_library,
              onPressed: () => _pick(ImageSource.gallery),
            ),
            if (preview != null) ...[
              const SizedBox(height: 10),
              BigButton(label: I18n.t(lang, "next"), onPressed: _keep),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
