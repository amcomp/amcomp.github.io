// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  // Method to launch URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          padding: EdgeInsets.only(top: 25),
          children: [
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
                size: 30.0,
              ),
              title: const Text('Home'),
              textColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.blog,
                color: Colors.white,
                size: 30.0,
              ),
              title: const Text('Blog'),
              textColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person_2_outlined,
                color: Colors.white,
                size: 30.0,
              ),
              title: const Text('About Me'),
              textColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 25,
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.github),
            onPressed: () => _launchURL('https://github.com/amcomp'),
          ),
          Padding(padding: EdgeInsets.all(10)),
          IconButton(
            icon: Icon(FontAwesomeIcons.linkedin),
            onPressed: () => _launchURL('https://linkedin.com'),
          ),
          Padding(padding: EdgeInsets.all(10)),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Mathew Probably?',
          style: TextStyle(
            fontSize: 55,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
