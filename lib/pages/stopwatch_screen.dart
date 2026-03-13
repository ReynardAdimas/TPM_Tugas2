import 'package:flutter/material.dart';
import 'package:tpm_tugas2/models/stopwatch_model.dart';
import 'dart:async';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch(); 
  Timer? _timer; 

  final List<LapRecord> _laps = []; 
  Duration _previousTotal = Duration.zero; 

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_stopwatch.elapsed.inHours >= 24) {
        _stopAndResetTimer();
      } else {
        setState(() {
          
        });
      }
    }); 
    _stopwatch.start();
  } 

  void _pauseTimer() {
    _timer?.cancel(); 
    _stopwatch.stop(); 
    setState(() {
      // _laps.clear(); 
      // _previousTotal = Duration.zero;
    });
  } 

  void _stopAndResetTimer() {
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
    String hours = (duration.inHours).toString().padLeft(2,'0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0'); 
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0'); 
    String hundredths = ((duration.inMilliseconds % 1000) ~/ 10).toString().padLeft(2, '0'); 

    if (isMainTime && !_stopwatch.isRunning && _stopwatch.elapsedTicks == 0) {
      return "$hours:$minutes:$seconds.0";
    } 
    return "$hours:$minutes:$seconds.$hundredths";
  }

  @override 
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D1D1D),
        iconTheme: IconThemeData(
          color: Colors.white70
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0), 
              child: Text(
                'Stopwatch', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white70),
              ),
            ), 

            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  _formatTime(_stopwatch.elapsed, isMainTime: true), 
                  style: const TextStyle(
                    fontSize: 72, 
                    fontWeight: FontWeight.w300, 
                    color: Colors.white70,
                    fontFeatures: [FontFeature.tabularFigures()]
                  ),
                ),
              )
            ), 

            Expanded(
              flex: 4,
              child: ListView.builder(
                itemCount: _laps.length,
                itemBuilder: (context, index) {
                  final lap = _laps[index]; 
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0), 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${lap.index.toString().padLeft(2, '0')}', 
                          style: const TextStyle(fontSize: 18, color: Colors.white70),
                        ), 
                        Text(
                          '+ ${_formatTime(lap.split)}', 
                          style: const TextStyle(fontSize: 18, color: Colors.white70),
                        ), 
                        Text(
                          _formatTime(lap.total), 
                          style: const TextStyle(fontSize: 18, color: Colors.white70),
                        )
                      ],
                    ),
                  );
                }
              )
            ), 

            Padding(
              padding: const EdgeInsets.only(bottom: 48.0), 
              child: _buildControlButtons(),
            )
          ],
        )
      ),
    );
  }
  Widget _buildControlButtons() {
    final bool isInitial = !_stopwatch.isRunning && _stopwatch.elapsedTicks == 0; 
    final bool isRunning = _stopwatch.isRunning; 

    if (isInitial) {
      return Center(
        child: _CustomButton(
          icon: Icons.play_arrow_outlined,
          onTap: _startTimer,
          isWide: true,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (isRunning) ...[
          _CustomButton(icon: Icons.flag, onTap: _recordLap), 
          _CustomButton(icon: Icons.pause, onTap: _pauseTimer)
        ] else ...[
          _CustomButton(icon: Icons.stop, onTap:_stopAndResetTimer), 
          _CustomButton(icon: Icons.play_arrow_outlined, onTap: _startTimer)
        ]
      ],
    );
  }
}

class _CustomButton extends StatelessWidget {
  final IconData icon; 
  final VoidCallback onTap; 
  final bool isWide; 

  const _CustomButton({
    required this.icon, 
    required this.onTap, 
    this.isWide = false
  }); 

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isWide? 100:72, 
        height: 72,
        decoration: BoxDecoration(
          color: const Color(0xFF333333),
          borderRadius: BorderRadius.circular(48)
        ),
        child: Icon(
          icon, 
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}

