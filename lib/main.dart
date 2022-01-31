import "package:cross_reader/error/error_view.dart";
import "package:cross_reader/library/bloc/backup_bloc.dart";
import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/library/widget/library_page.dart";
import "package:cross_reader/reader/bloc/reader_bloc.dart";
import "package:cross_reader/reader/model/reader_arguments.dart";
import "package:cross_reader/reader/widget/reader_page.dart";
import "package:cross_reader/repository/chapter_repository.dart";
import "package:cross_reader/repository/manga_repository.dart";
import "package:cross_reader/service/archive_service.dart";
import "package:cross_reader/service/backup_service.dart";
import "package:cross_reader/service/box_service.dart";
import "package:cross_reader/service/file_picker_wrapper.dart";
import "package:cross_reader/service/share_service.dart";
import "package:cross_reader/util/app_color.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";
import "package:path_provider/path_provider.dart";

/// Register all services and repositories
Future<void> registerServices() async {
  final _cacheDirectory = await getTemporaryDirectory();
  GetIt.I.registerSingleton<BoxService>(BoxService());
  GetIt.I.registerSingleton<MangaRepository>(MangaRepository());
  GetIt.I.registerSingleton<ChapterRepository>(ChapterRepository());
  GetIt.I.registerSingleton<ArchiveService>(ArchiveService());
  GetIt.I.registerSingleton<BackupService>(BackupService(_cacheDirectory));
  GetIt.I.registerSingleton<FilePickerWrapper>(
    FilePickerWrapper(FilePicker.platform),
  );
  GetIt.I.registerSingleton<ShareService>(ShareService());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerServices();
  runApp(const CrossReaderApp());
}

/// cross_reader entry point
class CrossReaderApp extends StatelessWidget {
  /// cross_reader entry point
  const CrossReaderApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CrossReader",
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
        appBarTheme: const AppBarTheme(
          color: mainColor,
        ),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: mainColor),
        primaryColor: mainColor,
        scaffoldBackgroundColor: backgroundColor,
        cardTheme: const CardTheme(
          color: secondColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          shadowColor: textColor,
        ),
      ),
      home: LibraryPage(
        libraryBloc: LibraryBloc(),
        backupBloc: BackupBloc(),
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case "/reader":
            final args = settings.arguments as ReaderArguments?;
            return MaterialPageRoute<ReaderPage>(
              builder: (context) {
                if (args != null) {
                  final readerBloc = ReaderBloc(
                    manga: args.manga,
                    currentChapterIndex: args.chapterIndex,
                    currentPageIndex: args.pageIndex,
                  );
                  return ReaderPage(
                    readerBloc: readerBloc,
                  );
                }

                return const ErrorView();
              },
            );
          case "/library":
          default:
            return MaterialPageRoute<LibraryPage>(
              builder: (context) => LibraryPage(
                libraryBloc: LibraryBloc(),
                backupBloc: BackupBloc(),
              ),
            );
        }
      },
    );
  }
}
