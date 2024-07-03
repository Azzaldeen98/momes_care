import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../constants/enam/enam_type_image_in_marker.dart';
import '../../theme/color_app.dart';
import 'markart_google_map_domin.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

// ignore: must_be_immutable
class MarkerGoogleMapImp extends MarkerGoogleMap {
  MarkerGoogleMapImp();
  Set<Circle>? circles = {};

  void listenchangeLocationMarker() {
    streamSubscription = Geolocator.getPositionStream().listen((position) {
      changeLocationMarker(
          latLng: LatLng(position.latitude, position.longitude), markerId: "1");
    });
  }

  @override
  Future<void> changeLocationMarker(
      {required String markerId, required LatLng latLng}) async {
    marker.remove(Marker(markerId: MarkerId(markerId)));
    marker.add(await _addNewMarker(markerId: markerId, latLng: latLng));
    circles?.remove(Circle(circleId: CircleId(markerId)));
    circles?.add(
      Circle(
          circleId: CircleId(markerId),
          fillColor: AppColors.mainOneColor.withOpacity(0.3),
          strokeWidth: 1,
          strokeColor: AppColors.mainOneColor.withOpacity(0.5),
          center: latLng,
          radius: 80),
    );
    await addNewMarker(markerId: markerId, latLng: latLng);
    await cameraUpdate(latLng: latLng);
  }

  Future<void> cameraUpdate({required LatLng latLng}) async {
    await googleMapController!
        .animateCamera(CameraUpdate.newLatLngZoom(latLng, 17));
  }

  Future<void> cameraUpdateShowTowPoints({
    required LatLng startPoint,
    required LatLng endPoint,
  }) async {
    final LatLng southwest = LatLng(
      min(startPoint.latitude, endPoint.latitude),
      min(startPoint.longitude, endPoint.longitude),
    );
    final LatLng northeast = LatLng(
      max(startPoint.latitude, endPoint.latitude),
      max(startPoint.longitude, endPoint.longitude),
    );
    LatLngBounds bounds = LatLngBounds(
      southwest: southwest,
      northeast: northeast,
    );
    await googleMapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 100),
    );
  }

  void updateCamera(
      {required LatLng startPoint, required LatLng endPoint}) async {
    LatLngBounds bound;
    if (startPoint.latitude >= endPoint.latitude) {
      LatLng temp = endPoint;
      endPoint = startPoint;
      startPoint = temp;
    }
    bound = LatLngBounds(southwest: startPoint, northeast: endPoint);
    CameraUpdate towPoints = CameraUpdate.newLatLngBounds(bound, 100);
    await googleMapController!.animateCamera(CameraUpdate.zoomTo(13));
    await googleMapController!
        .animateCamera(towPoints)
        .then((value) => check(towPoints, googleMapController!));
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    googleMapController?.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      check(u, c);
    }
  }

  Future<Marker> _addNewMarker(
      {required String markerId,
      required LatLng latLng,
      TypeImageInMarker typeImageInMarker =
          TypeImageInMarker.ME_LOCATION}) async {
    await cameraUpdate(latLng: latLng);

    return Marker(
        markerId: MarkerId(markerId),
        position: latLng,
        anchor: const Offset(0.5, 0.5),
        // icon: await BitmapDescriptor.fromAssetImage(
        //   ImageConfiguration.empty,
        //   typeImageInMarker.value(),
        // ),

        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(typeImageInMarker.value(), 110)));
  }

  @override
  Future<void> addNewMarker(
      {required String markerId,
      required LatLng latLng,
      TypeImageInMarker typeImageInMarker =
          TypeImageInMarker.ME_LOCATION}) async {
    marker.add(await _addNewMarker(
        markerId: markerId,
        latLng: latLng,
        typeImageInMarker: typeImageInMarker));
    if (typeImageInMarker != TypeImageInMarker.ME_LOCATION) {
      circles?.add(
        Circle(
            circleId: CircleId(markerId),
            fillColor: AppColors.mainOneColor.withOpacity(0.3),
            strokeWidth: 1,
            strokeColor: AppColors.mainOneColor.withOpacity(0.5),
            center: latLng,
            radius: 80),
      );
    }
    // polyline.add(Polyline(polylineId: PolygonId(markerId),points: ));
  }

  @override
  List<Object?> get props => [googleMapController, marker, streamSubscription];
}
