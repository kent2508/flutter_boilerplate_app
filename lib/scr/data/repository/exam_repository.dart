import 'package:vpb_flutter_boilerplate/scr/core/api_service/api_provider.dart';
import 'package:vpb_flutter_boilerplate/scr/core/api_service/custom_exception.dart';
import 'package:vpb_flutter_boilerplate/scr/core/api_service/list_response.dart';
import 'package:vpb_flutter_boilerplate/scr/core/api_service/response_provider.dart';
import 'package:vpb_flutter_boilerplate/scr/core/api_service/single_response.dart';
import 'package:vpb_flutter_boilerplate/scr/data/model/exam_model.dart';

abstract class ExamRepository {
  Future<SingleResponse<ExamModel>> getExamSomething();
  Future<ListResponse<ExamModel>> getListExamSomething();
}

class ExamRepositoryImp implements ExamRepository {
  ExamRepositoryImp(this._apiProvider);

  final ApiProviderRepositoryImpl _apiProvider;

  @override
  Future<SingleResponse<ExamModel>> getExamSomething() async {
    try {
      final rawRes = await _apiProvider.getRequest<Map<String, dynamic>>('path of domain api');
      final response = ResponseProvider.fromJson(rawRes.data ?? {}, keyValue: 'something or null');
      if (response.isSuccess()) {
        return SingleResponse<ExamModel>(response.data, (dynamic item) => ExamModel.fromJSON(item));
      } else {
        throw CustomException(response.code, response.message);
      }
    } catch (e) {
      throw MappingDataException(e);
    }
  }

  @override
  Future<ListResponse<ExamModel>> getListExamSomething() async {
    try {
      final rawRes = await _apiProvider.getRequest<Map<String, dynamic>>('path of domain api');
      final response = ResponseProvider.fromJson(rawRes.data ?? {}, keyValue: 'something or null');
      if (response.isSuccess()) {
        return ListResponse<ExamModel>(response.data, (dynamic item) => ExamModel.fromJSON(item));
      } else {
        throw CustomException(response.code, response.message);
      }
    } catch (e) {
      throw MappingDataException(e);
    }
  }
}
