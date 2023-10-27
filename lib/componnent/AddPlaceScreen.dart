import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Place',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AddPlaceScreen(),
    );
  }
}

class AddPlaceScreen extends StatefulWidget {
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _selectedDate;
  List<XFile>? _selectedImages = [];
  XFile? _selectedVideo;
  VideoPlayerController? _videoPlayerController;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImages!.add(image);
      });
    }
  }

  Future<void> _pickVideo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      _videoPlayerController = VideoPlayerController.file(File(video.path))
        ..initialize().then((_) {
          setState(() {
            _selectedVideo = video;
          });
          _videoPlayerController!.play();
        });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(_selectedDate == null
                  ? 'Select Date'
                  : _selectedDate!.toLocal().toString().split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (pickedDate != null && pickedDate != _selectedDate) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.image),
              label: Text('Add Images'),
            ),
            Wrap(
              spacing: 8,
              children: _selectedImages!
                  .map((img) =>
                      Image.file(File(img.path), width: 100, height: 100))
                  .toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickVideo,
              icon: Icon(Icons.videocam),
              label: Text('Add Video'),
            ),
            if (_selectedVideo != null)
              SizedBox(
                width: 300,
                height: 200,
                child: VideoPlayer(_videoPlayerController!),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Logic to save the data, e.g., to a list or database
                // For now, just pop the screen
                Navigator.pop(context);
              },
              child: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
