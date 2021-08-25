import 'package:dio/dio.dart';
import 'package:restoran/data/remote/datasource/api_constant.dart';
import 'package:restoran/data/remote/model/add_review_model.dart';
import 'package:restoran/data/remote/model/detail_restoran_model.dart';
import 'package:restoran/data/remote/model/list_restoran_model.dart';

abstract class RemoteDataSource {
  Future<RestoranListModel> getRestoranList();

  Future<DetailRestoranModel> getRestoranDetail(String restoranId);

  Future<RestoranListModel> searchRestoran(String restoranName);

  Future<AddReviewsModel> addReview(
      String restoranId, String userName, String review);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  Dio dio;

  RemoteDataSourceImpl({this.dio});

  @override
  Future<RestoranListModel> getRestoranList() async {
    try {
      Response _response = await dio.get(ApiConstant.listRestoran);
      return RestoranListModel.fromJson(_response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception("Connection Timeout Exception");
      }
      throw Exception(e.message);
    }
  }

  @override
  Future<RestoranListModel> searchRestoran(String restoranName) async {
    try {
      Response _response =
          await dio.get("${ApiConstant.searchRestoran}$restoranName");
      return RestoranListModel.fromJson(_response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception("Connection Timeout Exception");
      }
      throw Exception(e.message);
    }
  }

  @override
  Future<DetailRestoranModel> getRestoranDetail(String restoranId) async {
    try {
      Response _response =
          await dio.get("${ApiConstant.detailRestoran}$restoranId");
      return DetailRestoranModel.fromJson(_response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception("Connection Timeout Exception");
      }
      throw Exception(e.message);
    }
  }

  @override
  Future<AddReviewsModel> addReview(
      String restoranId, String userName, String review) async {
    try {
      var body = {"id": restoranId, "name": userName, "review": review};
      var header = {"X-Auth-Token": "12345"};
      Response _response = await dio.post("${ApiConstant.reviewRestoran}",
          data: body,
          options: Options(
            method: "POST",
            contentType: Headers.jsonContentType,
            headers: header,
          ));
      return AddReviewsModel.fromJson(_response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception("Connection Timeout Exception");
      }
      throw Exception(e.message);
    }
  }
}
