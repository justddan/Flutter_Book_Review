import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewState());
}

class ReviewState extends Equatable {
  @override
  List<Object?> get props => [];
}
