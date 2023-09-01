import 'package:bookreview/src/common/model/review.dart';
import 'package:bookreview/src/common/repository/review_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserReiviewCubit extends Cubit<UserReiviewState> {
  final ReviewRepository _reviewRepository;
  final String uid;
  UserReiviewCubit(
    this._reviewRepository,
    this.uid,
  ) : super(const UserReiviewState()) {
    _loadMyAllReviews();
  }

  void _loadMyAllReviews() async {
    var result = await _reviewRepository.loadMyAllReviews(uid);
    emit(state.copyWith(results: result));
  }
}

class UserReiviewState extends Equatable {
  final List<Review> results;
  const UserReiviewState({this.results = const []});

  UserReiviewState copyWith({
    List<Review>? results,
  }) {
    return UserReiviewState(
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [results];
}
