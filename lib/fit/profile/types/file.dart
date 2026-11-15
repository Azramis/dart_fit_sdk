class File {
  /// Read only, single file. Must be in root directory.
  static const int device = 1;
  /// Read/write, single file. Directory=Settings
  static const int settings = 2;
  /// Read/write, multiple files, file number = sport type. Directory=Sports
  static const int sport = 3;
  /// Read/erase, multiple files. Directory=Activities
  static const int activity = 4;
  /// Read/write/erase, multiple files. Directory=Workouts
  static const int workout = 5;
  /// Read/write/erase, multiple files. Directory=Courses
  static const int course = 6;
  /// Read/write, single file. Directory=Schedules
  static const int schedules = 7;
  /// Read only, single file. Circular buffer. All message definitions at start of file. Directory=Weight
  static const int weight = 9;
  /// Read only, single file. Directory=Totals
  static const int totals = 10;
  /// Read/write, single file. Directory=Goals
  static const int goals = 11;
  /// Read only. Directory=Blood Pressure
  static const int bloodPressure = 14;
  /// Read only. Directory=Monitoring. File number=sub type.
  static const int monitoringA = 15;
  /// Read/erase, multiple files. Directory=Activities
  static const int activitySummary = 20;
  static const int monitoringDaily = 28;
  /// Read only. Directory=Monitoring. File number=identifier
  static const int monitoringB = 32;
  /// Read/write/erase. Multiple Files. Directory=Segments
  static const int segment = 34;
  /// Read/write/erase. Single File. Directory=Segments
  static const int segmentList = 35;
  /// Read/write/erase. Single File. Directory=Settings
  static const int exdConfiguration = 40;
  /// 0xF7 - 0xFE reserved for manufacturer specific file types
  static const int mfgRangeMin = 247;
  /// 0xF7 - 0xFE reserved for manufacturer specific file types
  static const int mfgRangeMax = 254;
  static const int tsbSonarEvents = 66;
  static const int tsbDiverConfig = 67;
}
