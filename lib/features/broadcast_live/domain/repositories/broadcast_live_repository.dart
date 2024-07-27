import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';

abstract class BroadcastLivesRepository{

  Future<Either<Failure, List<BroadcastLive>>> getMyBroadcastLives();
  Future<Either<Failure, List<BroadcastLive>>> getActiveBroadcastLives();
  Future<Either<Failure, Unit>> addBroadcastLive(BroadcastLive BroadcastLive);
  Future<Either<Failure, Unit>> updateBroadcastLive(BroadcastLive BroadcastLive);
  Future<Either<Failure, Unit>> deleteBroadcastLive(int id);
  Future<Either<Failure, Unit>> stopBroadcastLive(int id);


}