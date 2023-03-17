import 'package:ditonton/data/datasources/db/tv_database_helper.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  TvDatabaseHelper
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])

void main() {}