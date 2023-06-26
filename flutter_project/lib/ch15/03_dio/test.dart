import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = '';

  dioTest() async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: 'https://reqres.in/api/',
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
          },
        ),
      );
      List<Response<dynamic>> response = await Future.wait(
        [
          dio.get('https://reqres.in/api/users?page=1'),
          dio.get('https://reqres.in/api/users?page=2'),
        ],
      );
      for (var element in response) {
        if (element.statusCode == 200) {
          setState(() {
            result = element.data.toString();
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(result),
              ElevatedButton(
                onPressed: dioTest,
                child: const Text('Get Server Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
