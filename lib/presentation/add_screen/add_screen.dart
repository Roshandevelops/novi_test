import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:novi_test/infrastructure/app_controller.dart';
import 'package:provider/provider.dart';

class AddFeedsScreen extends StatefulWidget {
  const AddFeedsScreen({super.key});

  @override
  State<AddFeedsScreen> createState() => _AddFeedsScreenState();
}

class _AddFeedsScreenState extends State<AddFeedsScreen> {
  File? _videoFile;
  File? _imageFile;
  final TextEditingController _descController = TextEditingController();
  List<int> _selectedCategories = [];

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _videoFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  void _toggleCategory(int id) {
    setState(() {
      if (_selectedCategories.contains(id)) {
        _selectedCategories.remove(id);
      } else {
        _selectedCategories.add(id);
      }
    });
  }

  void _submit(AppController controller) async {
    if (_videoFile == null ||
        _imageFile == null ||
        _descController.text.isEmpty ||
        _selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are mandatory")),
      );
      return;
    }

    final success = await controller.uploadFeed(
      desc: _descController.text,
      categoryIds: _selectedCategories,
      video: _videoFile!,
      image: _imageFile!,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Feed uploaded successfully!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload failed")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppController>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AppController>(context);

    return Scaffold(
      backgroundColor: const Color(0xff161616),
      appBar: AppBar(
        backgroundColor: const Color(0xff161616),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        ),
        title: const Text("Add Feeds", style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: controller.isLoading ? null : () => _submit(controller),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xffC70000).withOpacity(0.40),
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: controller.isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Share Post",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Video Container
            GestureDetector(
              onTap: _pickVideo,
              child: DottedBorder(
                color: Colors.grey,
                strokeWidth: 2.5,
                dashPattern: const [10, 6],
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: const Color(0xff1E1E1E),
                  child: Center(
                    child: _videoFile == null
                        ? const Text("Select a video from Gallery",
                            style: TextStyle(color: Colors.white70))
                        : Text(
                            "Video Selected: ${_videoFile!.path.split('/').last}",
                            style: const TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Thumbnail Container
            GestureDetector(
              onTap: _pickImage,
              child: DottedBorder(
                color: Colors.grey,
                strokeWidth: 2.5,
                dashPattern: const [10, 6],
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: const Color(0xff1E1E1E),
                  child: Center(
                    child: _imageFile == null
                        ? const Text("Add a Thumbnail",
                            style: TextStyle(color: Colors.white70))
                        : Image.file(_imageFile!, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Description
            const Text("Add Description",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter description",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xff1E1E1E),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 20),

            /// Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Categories This Project",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text("View All",
                    style: TextStyle(color: Colors.white54, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 12),

            controller.categoryList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white))
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: controller.categoryList.map((cat) {
                      final isSelected =
                          _selectedCategories.contains(cat.id ?? -1);
                      return GestureDetector(
                        onTap: () => _toggleCategory(cat.id ?? -1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: isSelected ? Colors.red : Colors.grey),
                            color: isSelected
                                ? Colors.red.withOpacity(0.3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cat.title ?? "No Name",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
