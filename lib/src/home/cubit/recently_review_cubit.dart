import 'package:bookreview/src/common/model/book_review_info.dart';
import 'package:bookreview/src/common/repository/book_review_info_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentlyReviewCubit extends Cubit<RecentlyReviewState> {
  final BookReviewInfoRepository _bookReviewInfoRepository;
  RecentlyReviewCubit(this._bookReviewInfoRepository)
      : super(const RecentlyReviewState()) {
    _loadBookReviewInfos();
  }

  void _loadBookReviewInfos() async {
    var results = await _bookReviewInfoRepository.loadBookReviewRecentlyData();
    emit(state.copyWith(results: results));
  }

  refresh() {
    _loadBookReviewInfos();
  }
}

class RecentlyReviewState extends Equatable {
  final List<BookReviewInfo>? results;
  const RecentlyReviewState({this.results});

  RecentlyReviewState copyWith({
    List<BookReviewInfo>? results,
  }) {
    return RecentlyReviewState(results: results ?? this.results);
  }

  @override
  List<Object?> get props => [];
}
