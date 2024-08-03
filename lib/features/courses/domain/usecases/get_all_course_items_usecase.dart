import 'package:dartz/dartz.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';



import 'package:moms_care/core/error/faiture.dart';
import '../repositories/courses_repository.dart';

class GetAllCourseItemsUseCase {
  
  final CoursesRepository _repository;

  GetAllCourseItemsUseCase(this._repository);
  
  @override
  Future<Either<Failure,List<CourseItem>>> call(int courseId) async {
    print("GetAllCourseItemsEvent:: ${courseId}");
    var res= await _repository.getCourseItems(courseId);
    print("getCourseItems:: ${res.length}");
    return res;
  }
  
}