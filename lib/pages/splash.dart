import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:showtime/apihandler.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate loading data. You can replace this with your actual data loading logic.
    Future.delayed(const Duration(seconds: 1), () async {
      // Once data is loaded, navigate to the appropriate page.
      try {
        var homeItems = await getHomeItems();
        await Navigator.of(context).pushReplacementNamed("/home", arguments: homeItems);
      } catch (e) {
        if (e is DioException) {
          await Navigator.of(context).pushReplacementNamed("/home", arguments: []);
        }
      }
      
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/SHOWTIME.png'),
            const CircularProgressIndicator(), // Loading indicator
            const SizedBox(height: 20),
             // Replace with your image path
          ],
        ),
      ),
    );
  }
}
