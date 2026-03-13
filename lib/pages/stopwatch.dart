import 'package:flutter/material.dart';
import 'package:tpm_tugas2/models/stopwatch_model.dart';
import 'dart:async';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  final Stopwatch _stopwatch = Stopwatch(); 
  Timer? _timer; 

  List<LapRecord> _laps = []; 
  Duration _previousTotal = Duration.zero; 

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        
      }); 
    }); 
    _stopwatch.start();
  } 

  void _pauseTimer() {
    _timer?.cancel(); 
    _stopwatch.reset(); 
    setState(() {
      _laps.clear(); 
      _previousTotal = Duration.zero;
    });
  } 

  void _recordLap() {
    final currentTotal = _stopwatch.elapsed; 
    final splitTime = currentTotal - _previousTotal; 

    setState(() {
      _laps.insert(
        0, 
        LapRecord(
          index: _laps.length + 1, 
          split: splitTime, 
          total: currentTotal
        )
      );
      _previousTotal = currentTotal;
    });
  } 

  String _formatTime(Duration duration, {bool isMainTime= false}) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0'); 
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0'); 
    String hundredths = ((duration.inMilliseconds % 1000) ~/ 10).toString().padLeft(2, '0'); 

    if (isMainTime && !_stopwatch.isRunning && _stopwatch.elapsedTicks == 0) {
      return "$minutes:$seconds.0";
    } 
    return "$minutes:$seconds.$hundredths";
  }

  @override 
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  } 
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}