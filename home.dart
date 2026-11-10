import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String courseName = '';
  String minutesInput = '';
  String topicsInput = '';
  String resultMessage = 'Your study plan will appear here.';

  // This function runs when the student presses the button.
  void createStudyPlan() {
    int? totalMinutes = int.tryParse(minutesInput);
    int? numberOfTopics = int.tryParse(topicsInput);

    // Make sure the input is complete and valid.
    if (courseName.trim().isEmpty ||
        totalMinutes == null ||
        numberOfTopics == null ||
        totalMinutes <= 0 ||
        numberOfTopics <= 0) {
      setState(() {
        resultMessage = 'Please enter a course name and valid numbers.';
      });
      return;
    }

    // A longer session includes one 5-minute break.
    int breakMinutes = 0;
    if (totalMinutes >= 45) {
      breakMinutes = 5;
    }

    int studyMinutes = totalMinutes - breakMinutes;
    int minutesPerTopic = studyMinutes ~/ numberOfTopics;

    if (minutesPerTopic < 5) {
      setState(() {
        resultMessage =
            'Not enough time for all topics. Add more minutes or reduce the number of topics.';
      });
      return;
    }

    String tip = '';
    if (minutesPerTopic < 15) {
      tip = 'Focus on important definitions and quick revision.';
    } else {
      tip = 'Read your notes and solve some practice questions.';
    }

    // setState updates the result shown on the screen.
    setState(() {
      resultMessage =
          'Course: ${courseName.trim()}\n'
          'Study time: $studyMinutes minutes\n'
          'Break time: $breakMinutes minutes\n'
          'Time for each topic: about $minutesPerTopic minutes\n\n'
          'Study tip: $tip';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudySprint'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Plan Your Study Session',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Enter your course, available time, and topics.'),
              const SizedBox(height: 24),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Course name (example: CSCI410)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  courseName = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Available minutes (example: 60)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  minutesInput = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Number of topics (example: 3)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  topicsInput = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: createStudyPlan,
                child: const Text('Create Study Plan'),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.deepPurple.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    resultMessage,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
