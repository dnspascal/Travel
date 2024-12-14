import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiScreenStepper extends StatefulWidget {
  @override
  _MultiScreenStepperState createState() => _MultiScreenStepperState();
}

class _MultiScreenStepperState extends State<MultiScreenStepper> {
  PageController _pageController = PageController();
  int _currentStep = 0;

  final List<Widget> _screens = [
    FirstStepScreen(),
    SecondStepScreen(),
    ThirdStepScreen(),
  ];

  void _nextStep() {
    if (_currentStep < _screens.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Screen Stepper'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_screens.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index <= _currentStep ? Colors.blue : Colors.grey,
                  ),
                ).paddingOnly(top: 84);
              }),
            ),
          ),

          // Page View
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: _screens,
            ),
          ),

          // Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _currentStep > 0 ? _previousStep : null,
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: _nextStep,
                child: Text(
                    _currentStep == _screens.length - 1 ? 'Finish' : 'Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FirstStepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("1"),
      ),
    );
  }
}

class SecondStepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("2"),
      ),
    );
  }
}

class ThirdStepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("3"),
      ),
    );
  }
}
