import 'package:json_annotation/json_annotation.dart';

part 'exam_model.g.dart';

// to use json_annotation to generate model folowing to the link  https://pub.dev/packages/json_serializable

// @JsonSerializable to mark class used json_annotation to generate model
@JsonSerializable()
class ExamModel {
  ExamModel(this.examVariable);
  factory ExamModel.fromJSON(Map<String, dynamic> json) => _$ExamModelFromJson(json);

  String examVariable;

  Map<String, dynamic> toJSON() => _$ExamModelToJson(this);
}
