part of "reader_bloc.dart";

/// `ReaderBloc` event
abstract class ReaderEvent {
  /// `ReaderBloc` event
  const ReaderEvent();
}

/// Show the next page, if it's the end of the chapter, show the next chapter
class ReaderNextEvent extends ReaderEvent {
  /// Show the next page, if it's the end of the chapter, show the next chapter
  const ReaderNextEvent();
}

/// Show the previous page, if it's the start of the chapter,
/// show the previous chapter
class ReaderPreviousEvent extends ReaderEvent {
  /// Show the previous page, if it's the start of the chapter,
  /// show the previous chapter
  const ReaderPreviousEvent();
}
