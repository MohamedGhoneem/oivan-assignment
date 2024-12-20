import 'dart:async';
import 'package:app_fundamentals/app_fundamentals.dart';
import 'package:flutter/material.dart';

class PaginationHandler {
  final BehaviorSubject<RequestState> requestStateSubject;
  final VoidCallback voidCallback;
  final double _scrollThreshold = 200.0;

  bool _isLoadingMore = false;
  Timer? _debounceTimer;

  PaginationHandler({
    required this.requestStateSubject,
    required this.voidCallback,
  }) {
    _initScrollController();
  }

  /// Pagination
  final ScrollController controller = ScrollController(
    keepScrollOffset: true,
  );
  bool hasMore = true;
  int page = 1;
  int size = 30;

  void _initScrollController() {
    controller.addListener(_scrollListener);
  }

  void reset() {
    _isLoadingMore = false;
    _debounceTimer?.cancel();
    requestStateSubject.sink.add(
      RequestState(status: RequestStatus.loading, message: ''),
    );
    hasMore = true;
    page = 1;
    size = 30;
  }

  void _scrollListener() {
    if (_debounceTimer?.isActive ?? false) return;

    _debounceTimer = Timer(const Duration(milliseconds: 150), () {
      if (!controller.hasClients) return;

      final maxScroll = controller.position.maxScrollExtent;
      final currentScroll = controller.position.pixels;
      final remainingScroll = maxScroll - currentScroll;

      if (
      remainingScroll <= _scrollThreshold &&
          !_isLoadingMore &&
          hasMore &&
          requestStateSubject.value.status != RequestStatus.loadMore) {

        _loadMore();
      }
    });
  }

  void _loadMore() {
    _isLoadingMore = true;
    requestStateSubject.sink.add(
      RequestState(
        status: RequestStatus.loadMore,
        message: RequestStatus.loadMore.name,
      ),
    );
    page++;
    callPaginatedRequest();
  }

  Future<void> callPaginatedRequest() async {
    debugPrint('page: $page / hasMore: $hasMore / isLoading: $_isLoadingMore');

    try {
      if (hasMore || requestStateSubject.value.status == RequestStatus.loadMore) {
        await Future(() => voidCallback());
      }
    } catch (e) {
      debugPrint('Pagination error: $e');
      requestStateSubject.sink.add(
        RequestState(
          status: RequestStatus.error,
          message: e.toString(),
        ),
      );
    } finally {
      _isLoadingMore = false;
    }
  }

  void dispose() {
    _debounceTimer?.cancel();
    controller.removeListener(_scrollListener);
    controller.dispose();
    requestStateSubject.close();
  }
}