import 'package:dartz/dartz.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/domain/models/failure.dart';
import 'package:nfc_mobile_prototype/domain/models/usecase.dart';

class UpdateIndex implements Usecase<Either<Failure, bool>, int> {
  final AppBloc bloc;

  UpdateIndex({required this.bloc});

  @override
  Future<Either<Failure, bool>> call(int index) async {
    bloc.add(AppUpdateIndex(index: index));
    return const Right(true);
  }
}