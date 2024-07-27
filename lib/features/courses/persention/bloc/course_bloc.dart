

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/error/extination_valid.dart';
import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/core/remote/firebase/firebase_storage_actions.dart';
import 'package:moms_care/features/courses/domain/usecases/add_course_item_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/add_course_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/delete_course_item_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/delete_course_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/get_all_course_items_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/get_all_courses_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/update_course_item_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/update_course_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/upload_file_course_usecase.dart';


import 'package:moms_care/features/courses/persention/bloc/course_event.dart';
import 'package:moms_care/features/courses/persention/bloc/course_state.dart';
import 'package:path/path.dart' as Path;

class CourseBloc extends Bloc<CourseEvent,CourseState>{

  final GetAllCoursesUseCase getAllCoursesUseCase ;
  final GetAllCourseItemsUseCase getAllCourseItemsUseCase ;
  final UploadFileCourseUseCase uploadFileCourseUseCase ;
  final AddCourseUsecase addCourseUsecase ;
  final UpdateCourseUsecase updateCourseUsecase ;
  final DeleteCourseUsecase  deleteCourseUsecase ;
  final AddCourseItemUseCase addCourseItemUseCase;
  final UpdateCourseItemUseCase updateCourseItemUseCase ;
  final DeleteCourseItemUseSase  deleteCourseItemUseSase ;

  CourseBloc({
    required this.getAllCoursesUseCase,
    required this.getAllCourseItemsUseCase,
    required this.uploadFileCourseUseCase,
    required this.addCourseUsecase,
    required this.updateCourseUsecase,
    required this.deleteCourseUsecase,
    required this.addCourseItemUseCase,
    required this.updateCourseItemUseCase,
    required this.deleteCourseItemUseSase,
    }):super(const CourseInitialState()){

    on<GetAllCoursesEvent>(_getAllCourses);
    on<GetAllCourseItemsEvent>(_getAllCourseItems);
    on<AddCourseEvent>(_addCourses);
    on<AddCourseItemEvent>(_addCourseItem);
    on<UpdateCourseEvent>(_updateCourses);
    on<UpdateCourseItemEvent>(_updateCourseItem);
    on<DeleteCourseEvent>(_deleteCourses);
    on<DeleteCourseItemEvent>(_deleteCourseItem);
    on<UploadCourseImageEvent>(_uploadImage);
    on<UploadCourseFileEvent>(_uploadFile);

  }
  FutureOr<void> _getAllCourses(GetAllCoursesEvent event, Emitter<CourseState> emit) async{
    emit(const LoadingCourseState());
    var failureOrDownloadURL=await getAllCoursesUseCase();
    failureOrDownloadURL.fold(
            (failure){
          emit(ErrorCourseState(message: mapFailureToMessage(failure)));
        }, (items){
      emit(LoadedCoursesState(courses: items));
    });
  }
  FutureOr<void> _refreshCourseInfo(RefreshCoursesEvent event, Emitter<CourseState> emit) async{

    emit(const LoadingCourseState());
    // final failureOrCourseInfo=await refreshCourseInfoUseCase();
    // failureOrCourseInfo.fold(
    //     (failure){
    //       emit(ErrorCourseState(message: mapFailureToMessage(failure)));
    //     },
    //     (info){
    //       emit(LoadedCourseState(Course: info));
    //     });
  }
  FutureOr<void> _getAllCourseItems(GetAllCourseItemsEvent event, Emitter<CourseState> emit) async{

    emit(const LoadingCourseState());
    var failureOrCourseItems=await getAllCourseItemsUseCase(event.courseId);
    failureOrCourseItems.fold(
            (failure){
          emit(ErrorCourseState(message: mapFailureToMessage(failure)));
        }, (items){
        emit(LoadedCourseItemsState(courseItems: items));
    });
  }

  FutureOr<void> _uploadImage(UploadCourseImageEvent event, Emitter<CourseState> emit) async{

    emit(const LoadingUploadFileState());

      try {
            await _deleteFileFromFirebaseStorage(event.oldUrl!);
            var failureOrDownloadURL=await uploadFileCourseUseCase(event.image);
            failureOrDownloadURL.fold(
                    (failure){
                  emit(ErrorCourseState(message: mapFailureToMessage(failure)));
                }, (_downloadURL){
              emit(UploadImageSuccessfulState( downloadURL: _downloadURL));
            });

        } catch (e) {
            Get.back();
            e.printError();
        }

  }
  FutureOr<void> _uploadFile(UploadCourseFileEvent event, Emitter<CourseState> emit) async{

    emit(const LoadingUploadFileState());


      try {

        if(event.oldUrl!=null) {
          await _deleteFileFromFirebaseStorage(event.oldUrl!);
        }
        var failureOrDownloadURL=await uploadFileCourseUseCase(event.file);
        failureOrDownloadURL.fold(
          (failure){
              emit(ErrorCourseState(message: mapFailureToMessage(failure)));
          }, (_downloadURL){
          emit(UploadFileSuccessfulState( downloadURL: _downloadURL));
        });


      } catch(e){
        Get.back();
        e.printError();
      }

  }

  FutureOr<void> _addCourses(AddCourseEvent event, Emitter<CourseState> emit) async{
    emit(const LoadingCourseState());
    var failureOrSuccess=await addCourseUsecase(event.course);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorCourseState(message: mapFailureToMessage(failure)));
        }, (_){
      emit(AddUpdateDeleteCourseSuccessState(message: ADD_SUCCESS_MESSAGE));
    });
  }
  FutureOr<void> _updateCourses(UpdateCourseEvent event, Emitter<CourseState> emit) async{
    emit(const LoadingCourseState());
    var failureOrSuccess=await updateCourseUsecase(event.course);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorCourseState(message: mapFailureToMessage(failure)));
        }, (_){
      emit(AddUpdateDeleteCourseSuccessState(message: UPDATE_SUCCESS_MESSAGE));
    });
  }
  Future<void> _deleteFileFromFirebaseStorage(String oldUrlMedia) async{
    try {
        await FirebaseStorageActions.deleteFile(fileUrl: oldUrlMedia!);
    } on FirebaseException catch(e){
      e.printError();
    } catch(e){
      e.printError();
    }
  }
  FutureOr<void> _deleteCourses(DeleteCourseEvent event, Emitter<CourseState> emit) async{
    emit(const LoadingCourseState());
    try {
      await _deleteFileFromFirebaseStorage(event.oldUrlMedia!);

      var failureOrSuccess = await deleteCourseUsecase(event.id);
      failureOrSuccess.fold(
              (failure) {
            emit(ErrorCourseState(message: mapFailureToMessage(failure)));
          }, (_) {
        emit(
            AddUpdateDeleteCourseSuccessState(message: DELETE_SUCCESS_MESSAGE));
      });
    }catch(e){
      Get.back();
    }

  }
  FutureOr<void> _addCourseItem(AddCourseItemEvent event, Emitter<CourseState> emit) async{
    emit(const LoadingCourseState());
    var failureOrSuccess=await addCourseItemUseCase(event.courseItem);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorCourseState(message: mapFailureToMessage(failure)));
        }, (_){
      emit(AddUpdateDeleteCourseSuccessState(message: ADD_SUCCESS_MESSAGE));
    });

  }
 FutureOr<void> _updateCourseItem(UpdateCourseItemEvent event, Emitter<CourseState> emit) async{
    emit(const LoadingCourseState());

    await _deleteFileFromFirebaseStorage(event.courseItem.url!);

    var failureOrSuccess=await updateCourseItemUseCase(event.courseItem);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorCourseState(message: mapFailureToMessage(failure)));
        }, (_){
      emit(AddUpdateDeleteCourseSuccessState(message: UPDATE_SUCCESS_MESSAGE));
    });

  }
 FutureOr<void> _deleteCourseItem(DeleteCourseItemEvent  event, Emitter<CourseState> emit) async{
    emit(const LoadingCourseState());

    await _deleteFileFromFirebaseStorage(event.UrlMedia!);

    var failureOrSuccess=await deleteCourseItemUseSase(event.id);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorCourseState(message: mapFailureToMessage(failure)));
        }, (_){
      emit(AddUpdateDeleteCourseSuccessState(message: DELETE_SUCCESS_MESSAGE));
    });

  }



}

