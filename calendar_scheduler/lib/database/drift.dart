import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../model/schedule.dart';
import 'package:sqlite3/sqlite3.dart';

// 코드 제너레이션
part 'drift.g.dart';

@DriftDatabase(
  // ScheduleTable : 테이블에 대한 정의
  tables: [ScheduleTable]
)
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(_openConnection());

  // ScheduleTableData : 실제로 다루게 됨 데이터
  Future<List<ScheduleTableData>> getSchedules() => select(scheduleTable).get();

  // 업데이트나 생성할 때는 Companion을 붙인다.
  Future<int> createSchedule(ScheduleTableCompanion data) => into(scheduleTable).insert(data);


  @override
  int get schemaVersion =>1;
}

LazyDatabase _openConnection(){
  return LazyDatabase(() async
  {
    // 앱 설치를 하면 각각의 앱마다 제공해주는 폴더의 위치를 가져옴
    final dbFolder = await getApplicationDocumentsDirectory();

    // 현재 운영체제에 맞게 경로를 알아서 합쳐줌
    /// C:\\Users\flutter : 역슬래쉬
    /// /Users/flutter : 슬래쉬
    final file = File(p.join(dbFolder.path,'db.sqlite'));

    // 안드로이드에서 버그 잡아주는 역할
    if(Platform.isAndroid){
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    // 임시 폴더 가져옴
    final cachebase = await getTemporaryDirectory();

    // 임시 폴더가 어디에 있는지 sqllite에게 알려줌.
    sqlite3.tempDirectory = cachebase.path;

    // 데이터베이스를 file 위치에 생성한다.
    return NativeDatabase.createInBackground(file);
  },);
}