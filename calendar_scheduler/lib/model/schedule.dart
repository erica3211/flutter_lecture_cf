import 'package:drift/drift.dart';

class ScheduleTable extends Table {
  /// 1) 식별 가능한 ID
  // final int id;
  // 칼럼 선언
  IntColumn get id => integer().autoIncrement()();

  /// 2) 시작 시간
  // final int startTime;
  IntColumn get startTime => integer()();

  /// 3) 종료 시간
  // final int endTime;
  IntColumn get endTime => integer()();

  /// 4) 일정 내용
  // final String content;
  TextColumn get content => text()();


  /// 5) 날짜
  // final DateTime date;
  DateTimeColumn get date => dateTime()();

  /// 6) 카테고리
  // final String color;
  TextColumn get color => text() ();

  /// 7) 일정 생성날짜시간
  // final DateTime createdAt;
  DateTimeColumn get createdAt => dateTime().clientDefault(()=>DateTime.now().toUtc())();

  // 생성자 필요 없음
  // Schedule({
  //   required this.id,
  //   required this.startTime,
  //   required this.endTime,
  //   required this.content,
  //   required this.date,
  //   required this.color,
  //   required this.createdAt,
  // });
}
