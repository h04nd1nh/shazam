import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'About Shazam',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Text(
                'Shazam is a popular mobile application that can identify music, movies, advertising, and television shows, based on a short sample played and using the microphone on the device.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Features:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Music Recognition'),
                subtitle: Text(
                  'Identify songs by listening to a short sample.',
                ),
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('Movie and TV Show Recognition'),
                subtitle: Text(
                  'Recognize movies and TV shows by listening to audio cues.',
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings_voice),
                title: Text('Advertising Recognition'),
                subtitle: Text(
                  'Identify commercials and other advertisements.',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'How it works:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Shazam uses audio fingerprinting technology to match snippets of music or other audio to its vast database. When a user "Shazams" a song or other audio, the app creates an acoustic fingerprint based on the audio waveform and compares it against a central database for a match.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Credits:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'This Flutter application is developed for demonstration purposes only and is not affiliated with or endorsed by Shazam or its parent company.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
