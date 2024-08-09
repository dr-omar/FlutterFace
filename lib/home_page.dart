import 'package:flutter/material.dart';

import 'face_detector_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Face Detection')),
      body: _body(context),
    );
  }
  Widget _body(BuildContext context) => Center(
    child: SizedBox(
        width: 350,
        height: 80,
        child: OutlinedButton(
          style: ButtonStyle(
            side: WidgetStateProperty.all(
              const BorderSide(
                color: Colors.blue,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
          ),
          onPressed: ()=>Navigator.push(context, 
            MaterialPageRoute(
              builder: (context)=>const FaceDetectorPage(),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIconWidget(Icons.arrow_forward_ios),
              const Text('Go to Face Detector',
                  style: TextStyle(
                    fontSize: 15,
                  ),
              ),
              _buildIconWidget(Icons.arrow_forward_ios),
            ],
          ),
        ),
    ),
  );

  Widget _buildIconWidget(final IconData icon) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                icon,
                size: 24,
              ),
            );
}
