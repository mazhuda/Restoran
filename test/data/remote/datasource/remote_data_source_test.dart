import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran/data/remote/datasource/remote_data_source.dart';
import 'package:restoran/data/remote/model/add_review_model.dart';
import 'package:restoran/data/remote/model/list_restoran_model.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main() {
  Dio dio;
  DioAdapterMock dioAdapterMock;
  RemoteDataSource remoteDataSource;

  setUp(() {
    dio = Dio();
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    remoteDataSource = RemoteDataSourceImpl(dio: dio);
  });

  group('remote data source test', () {
    test(
        'method remote data source call ini untuk mengambil data restoran list',
        () async {
      final responsePayload = jsonEncode({
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      });
      final httpResponse =
          ResponseBody.fromString(responsePayload, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });
      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final response = await remoteDataSource.getRestoranList();

      expect(response, isA<RestoranListModel>());
    });

    test(
        'method remote data source call ini untuk search data restoran '
        'dengan parameter data restoran kemudian returning result berupa list restoran',
        () async {
      final responsePayload = jsonEncode({
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      });
      final httpResponse =
          ResponseBody.fromString(responsePayload, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });
      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final response = await remoteDataSource.searchRestoran("Melting Pot");

      expect(response, isA<RestoranListModel>());
    });

    test(
        'method remote data source call untuk menambahkan saran '
        'dengan parameter id, user name, dan saran kemudian mempunyai returning data saran',
        () async {
      final responsePayload =
          jsonEncode({"error": false, "message": "success"});
      final httpResponse =
          ResponseBody.fromString(responsePayload, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });
      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final response = await remoteDataSource.addReview(
          "rqdv5juczeskfw1e867", "Bang Jago", "Tempatnya enak buat ngedate");

      expect(response, isA<AddReviewsModel>());
    });
  });
}
