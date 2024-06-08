import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ShazamPage extends StatefulWidget {
  ShazamPage({super.key});

  @override
  State<ShazamPage> createState() => _ShazamPageState();
}

class _ShazamPageState extends State<ShazamPage> {
  FlutterSoundRecorder? _recorder;
  String? _filePath;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    // Request microphone permission
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await _recorder!.openRecorder();
  }

  Future<void> _startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/temp_audio.aac';
    await _recorder!.startRecorder(
      toFile: path,
      codec: Codec.aacADTS,
    );
    setState(() {
      _isRecording = true;
      _filePath = path;
    });

    // Stop recording after 10 seconds
    Future.delayed(Duration(seconds: 10), () async {
      await _stopRecording();
    });
  }

  Future<void> _stopRecording() async {
    if (_isRecording) {
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      _sendAudioToApi();
    }
  }

  Future<void> _sendAudioToApi() async {
    if (_filePath != null) {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        "audio": await MultipartFile.fromFile(_filePath!,
            filename: "temp_audio.aac"),
      });

      try {
        Response response = await dio.post(
            'https://18e8-42-119-162-124.ngrok-free.app/find-audio',
            data: formData);
        print('Response status: ${response.statusCode}');
        print('Response data: ${response.data}');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff089aff),
      body: Stack(
        children: [
          (_isRecording == false)
              ? Container(
                  padding: const EdgeInsets.only(top: 250),
                  child: const Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Text(
                      'Tap To Shazam',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Container(),
          (_isRecording == true)
              ? Container(
                  padding: const EdgeInsets.only(bottom: 250),
                  child: const Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Text(
                      'Shazam is listening ...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Container(),
          Center(
            child: AvatarGlow(
              startDelay: const Duration(milliseconds: 1000),
              glowColor: Colors.white,
              glowShape: BoxShape.circle,
              animate: _isRecording,
              curve: Curves.fastOutSlowIn,
              child: Material(
                elevation: 8.0,
                shape: const CircleBorder(),
                color: const Color(0xff089aff),
                child: MaterialButton(
                  padding: EdgeInsets.all(30),
                  onPressed: () {
                    _startRecording();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color(0xff089aff),
                    backgroundImage: AssetImage('assets/img/shazam-logo.png'),
                    radius: 50.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
