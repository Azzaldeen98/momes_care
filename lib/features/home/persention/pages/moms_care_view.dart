import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/state/loading_widget.dart';

import '../../../../core/Animation/animation_scale_widget.dart';
import '../bloc/moms_care/moms_care_bloc.dart';
import '../widget/appber/home_widget.dart';
import '../widget/state_home_widget.dart';
import 'package:flutter/material.dart';

class MomsCareView extends StatelessWidget {
  const MomsCareView({super.key, required this.changeScreen});

  final void Function(int) changeScreen;
  @override
  Widget build(BuildContext context) {
    return HomeWidget(
      body: BlocBuilder<MomsCareBloc, MomsCareState>(
        builder: (context, state) {
          if (state is MomsCareInitial) {
            return const InitialHomeWidget();
          } else if (state is LoadingGetMomsCareItemsState) {
            return const LoadingVehicleWidget();
          } else if (state is ErrorGetMomsCareItemsState) {
            return ErrorHomeWidget(error: state.message);
          } else if (state is GetMomsCareItemsSuccessfulState) {
            return _homeWidgtet(context, state);
          } else {
            return const LoadingVehicleWidget();
          }
        },
      ),
    );
  }

  Widget _homeWidgtet(BuildContext context, GetMomsCareItemsSuccessfulState state) {
    return state.items!.isEmpty
        ? const EmptyHomeWidget()
        : AnimationSlideWidget(
            physics: const ClampingScrollPhysics(),
            children: [
              // ...List.generate(
              //     state.sparePart.length,
              //     (index) => InkWell(
              //         onTap: () => Get.to(() => DetailsView(item: state.sparePart[index])),
              //         child: ItemWidget(item: state.sparePart[index]))),
            ],
          );
  }
}

// class DetailsView extends StatefulWidget {
//   const DetailsView({super.key, required this.item});
//   final Object item;
//   @override
//   State<DetailsView> createState() => _DetailsViewState();
// }

// class _DetailsViewState extends State<DetailsView> {
//   late DetailsCubit DetailsCubit = DetailsCubit();
//   final quantityController = TextEditingController();
//   final noteController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DetailsCubit,
//       child: Scaffold(
//         backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
//         appBar: const AppBerDetails(),
//         bottomNavigationBar: Helper.buttonNavigation,
//         body: BlocListener<DetailsCubit, DetailsState>(
//           listener: (context, state) {
//             if (state is LoadingAddOrderState) {
//               MessageBox.showProgress(context, "Order in progress".tr);
//             } else if (state is ErrorAddOrderState) {
//               Get.back();
//               MessageBox.showError(context, "Order not placed".tr);
//             } else if (state is AddOrderSuccessfulState) {
//               Get.back();
//               MessageBox.showSuccess(context, "Order placed successfully".tr);
//             }
//           },
//           child: Column(
//             children: [
//               // Expanded(child: BodyDetailsWidget(sparePart: widget.sparePart)),
//               // FooterPrductWidget(
//               //     store: widget.item,
//               //     quantityController: quantityController,
//               //     noteController: noteController,
//               //     sparePartId: widget.sparePart.id ?? 0)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class DetailsCubit extends Cubit<DetailsState> {
//   DetailsCubit() : super(DetailsInitial());
//
//   void addOrder(
//       {required int sparePartId,
//         required int quantity,
//         required String note}) async {
//     emit(LoadingAddOrderState());
//
//     try {
//       final resonse = await http.post(Uri.parse("${BASE_URL}api/Orders/post"),
//           headers: HeaderServer.headerWithToken,
//           body: json.encode({
//             "sparePartId": sparePartId,
//             "quantity": quantity,
//             "note": note
//           }));
//       if (resonse.statusCode == 200 || resonse.statusCode == 201) {
//         emit(AddOrderSuccessfulState());
//       } else {
//         emit(ErrorAddOrderState());
//       }
//     } catch (e) {
//       emit(ErrorAddOrderState());
//     }
//   }
// }

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

class LoadingAddOrderState extends DetailsState {}

class ErrorAddOrderState extends DetailsState {}

class AddOrderSuccessfulState extends DetailsState {}

