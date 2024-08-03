
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moms_care/core/constants/enam/CareSchedulesItems.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/usecases/age_group/create_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/age_group/delete_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/age_group/update_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/care_type/create_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/care_type/delete_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/care_type/update_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/daily_care_items/create_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/daily_care_items/delete_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/daily_care_items/update_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/get_all_ageGroups_careTypes_use_case.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_age_group_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_care_type_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_daily_care_times_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/care_schedules_bloc.dart';



part 'add_update_delete_care_schedules_event.dart';
part 'add_update_delete_care_schedules_state.dart';

class AddUpdateDeleteCareScheduleBloc extends Bloc<AddUpdateDeleteCareScheduleEvent,
    AddUpdateDeleteCareScheduleState>{

  /// Add
final CreateAgeGroupUseCase  createAgeGroupUseCase;
final CreateCareTypeUseCase createCareTypeUseCase;
final CreateDailyCareTimesUseCase createDailyCareTimesUseCase;
/// Update
final UpdateAgeGroupUseCase updateAgeGroupUseCase;
final UpdateCareTypeUseCase updateCareTypeUseCase;
final UpdateDailyCareTimesUseCase updateDailyCareTimesUseCase;
/// Delete
final DeleteAgeGroupUseCase deleteAgeGroupUseCase;
final DeleteCareTypeUseCase deleteCareTypeUseCase;
final DeleteDailyCareTimesUseCase deleteDailyCareTimesUseCase;


final GetAllAgeGroupsAndCareTypesUseCase getAllAgeGroupsAndCareTypesUseCase;


AddUpdateDeleteCareScheduleBloc({
  /// Add
  required this.createAgeGroupUseCase,
  required this.createCareTypeUseCase,
  required this.createDailyCareTimesUseCase,
  /// Update
  required this.updateAgeGroupUseCase,
  required this.updateCareTypeUseCase,
  required this.updateDailyCareTimesUseCase,
  /// Delete
  required this.deleteAgeGroupUseCase,
  required this.deleteCareTypeUseCase,
  required this.deleteDailyCareTimesUseCase,
  /// Care Schedules
  required this.getAllAgeGroupsAndCareTypesUseCase,
}) : super(AddUpdateDeleteCareScheduleInitial()) {



    /// Add
    on<AddAgeGroupEvent>(_addAgeGroup);
    on<AddCareTypeEvent>(_addCareType);
    on<AddDailyCareTimesEvent>(_addDailyCareTimes);
    /// Update
    on<UpdateAgeGroupEvent>(_updateAgeGroup);
    on<UpdateCareTypeEvent>(_updateCareType);
    on<UpdateDailyCareTimesEvent>(_updateDailyCareTime);
    /// Delete
    on<DeleteAgeGroupEvent>(_deleteAgeGroup);
    on<DeleteCareTypeEvent>(_deleteCareType);
    on<DeleteDailyCareTimesEvent>(_deleteDailyCareTime);
    /// Care Schedules
    on<GetAllCareTypesAndAgeGroupsEvent>(_getAllCareTypesAndAgeGroups);

  }

FutureOr<void> _getAllCareTypesAndAgeGroups(GetAllCareTypesAndAgeGroupsEvent event,
    Emitter<CareSchedulesState> emit) async{

  emit(const LoadingCareSchedulesItemsState());
  final failureOrItems= await getAllAgeGroupsAndCareTypesUseCase();
  failureOrItems.fold(
          (failure)=>emit(ErrorCareSchedulesState(message: mapFailureToMessage(failure))),
          (data) {
            List<AgeGroup> ageGroups = data.value1;
            List<CareType> careTypes = data.value2;
            emit(LoadedAgeGroupsAndCareTypesState(ageGroups:ageGroups ,careTypes:careTypes ));

      });
}


  /// Add
  FutureOr<void> _addAgeGroup(AddAgeGroupEvent event, Emitter<AddUpdateDeleteCareScheduleState> emit) async{
    emit(const LoadingAddUpdateDeleteCareScheduleState());
    final failureOrSuccess=await createAgeGroupUseCase(event.ageGroup);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorAddUpdateDeleteCareScheduleState(message: mapFailureToMessage(failure)));
        },
            (items){
           emit(AddUpdateDeleteCareScheduleSuccessfulState(careScheduleItem: CareScheduleItems.AgeGroup,message: ADD_SUCCESS_MESSAGE));
        });
  }
  FutureOr<void> _addCareType(AddCareTypeEvent event, Emitter<AddUpdateDeleteCareScheduleState> emit) async{

    emit(const LoadingAddUpdateDeleteCareScheduleState());
    final failureOrSuccess=await createCareTypeUseCase(event.careType);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorAddUpdateDeleteCareScheduleState(message: mapFailureToMessage(failure)));
        },
            (items){
          emit(AddUpdateDeleteCareScheduleSuccessfulState(careScheduleItem: CareScheduleItems.CareTypes,message: ADD_SUCCESS_MESSAGE));
        });
  }
  FutureOr<void> _addDailyCareTimes(AddDailyCareTimesEvent event, Emitter<AddUpdateDeleteCareScheduleState> emit) async{

    emit(const LoadingAddUpdateDeleteCareScheduleState());
    final failureOrSuccess=await createDailyCareTimesUseCase(event.dailyCareTimes);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorAddUpdateDeleteCareScheduleState(message: mapFailureToMessage(failure)));
        },
            (items){
          emit(AddUpdateDeleteCareScheduleSuccessfulState(careScheduleItem: CareScheduleItems.DailyCareTimes,message: ADD_SUCCESS_MESSAGE));
        });
  }
  /// Update
  FutureOr<void> _updateAgeGroup(UpdateAgeGroupEvent event, Emitter<AddUpdateDeleteCareScheduleState> emit) async{

    emit(const LoadingAddUpdateDeleteCareScheduleState());
    final failureOrSuccess=await updateAgeGroupUseCase(event.ageGroup);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorAddUpdateDeleteCareScheduleState(message: mapFailureToMessage(failure)));
        },
            (items){
          emit(AddUpdateDeleteCareScheduleSuccessfulState(careScheduleItem: CareScheduleItems.AgeGroup,message: UPDATE_SUCCESS_MESSAGE));
        });
  }
  FutureOr<void> _updateCareType(UpdateCareTypeEvent event, Emitter<AddUpdateDeleteCareScheduleState> emit) async{
    emit(const LoadingAddUpdateDeleteCareScheduleState());
    final failureOrSuccess=await updateCareTypeUseCase(event.careType);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorAddUpdateDeleteCareScheduleState(message: mapFailureToMessage(failure)));
        },
            (items){
          emit(AddUpdateDeleteCareScheduleSuccessfulState(careScheduleItem: CareScheduleItems.CareTypes,message: UPDATE_SUCCESS_MESSAGE));
        });
  }
  FutureOr<void> _updateDailyCareTime(UpdateDailyCareTimesEvent event, Emitter<AddUpdateDeleteCareScheduleState> emit) async{
    emit(const LoadingAddUpdateDeleteCareScheduleState());
    final failureOrSuccess=await updateDailyCareTimesUseCase(event.dailyCareTimes);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorAddUpdateDeleteCareScheduleState(message: mapFailureToMessage(failure)));
        },
            (items){
          emit(AddUpdateDeleteCareScheduleSuccessfulState(careScheduleItem: CareScheduleItems.DailyCareTimes,message: UPDATE_SUCCESS_MESSAGE));
        });
  }
  /// Delete
  FutureOr<void> _deleteAgeGroup(DeleteAgeGroupEvent event, Emitter<AddUpdateDeleteCareScheduleState> emit) async{
    emit(const LoadingAddUpdateDeleteCareScheduleState());
    final failureOrSuccess=await deleteAgeGroupUseCase(event.id);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorAddUpdateDeleteCareScheduleState(message: mapFailureToMessage(failure)));
        },
            (items){
          emit(AddUpdateDeleteCareScheduleSuccessfulState(careScheduleItem: CareScheduleItems.AgeGroup,message: DELETE_SUCCESS_MESSAGE));
        });
  }
  FutureOr<void> _deleteCareType(DeleteCareTypeEvent event, Emitter<AddUpdateDeleteCareScheduleState> emit) async{
    emit(const LoadingAddUpdateDeleteCareScheduleState());
    final failureOrSuccess=await deleteCareTypeUseCase(event.id);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorAddUpdateDeleteCareScheduleState(message: mapFailureToMessage(failure)));
        },
            (items){
          emit(AddUpdateDeleteCareScheduleSuccessfulState(careScheduleItem: CareScheduleItems.CareTypes,message: DELETE_SUCCESS_MESSAGE));
        });
  }
  FutureOr<void> _deleteDailyCareTime(DeleteDailyCareTimesEvent event, Emitter<AddUpdateDeleteCareScheduleState> emit) async{
    emit(const LoadingAddUpdateDeleteCareScheduleState());
    final failureOrSuccess=await deleteDailyCareTimesUseCase(event.id);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorAddUpdateDeleteCareScheduleState(message: mapFailureToMessage(failure)));
        },
            (items){
          emit(AddUpdateDeleteCareScheduleSuccessfulState(careScheduleItem: CareScheduleItems.DailyCareTimes,message: DELETE_SUCCESS_MESSAGE));
        });
  }
}
