class LapRecord {
  final int index; 
  final Duration split; 
  final Duration total; 

  LapRecord({
    required this.index, 
    required this.split, 
    required this.total
  });
}