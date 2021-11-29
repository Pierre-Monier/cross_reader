import 'package:cross_reader/service/box_service.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';
import '../utils/mock_data.dart';

void main() {
  setUpAll(() async {
    final boxService = BoxService();
    GetIt.I.registerSingleton<BoxService>(boxService);
    await GetIt.I.get<BoxService>().cleanMangas();
  });
  test('It should get a list of all persisted manga', () async {
    final mangaList = await GetIt.I.get<BoxService>().getAllMangas();

    expect(mangaList.length, 0);
  });

  test('It should add a manga to the box', () async {
    await GetIt.I.get<BoxService>().saveManga(mockManga);
    final mangaList = await GetIt.I.get<BoxService>().getAllMangas();

    expect(mangaList.length, 1);
    expect(mangaList[0].name, mockManga.name);
  });

  test('It should be able to clean mangas', () async {
    await GetIt.I.get<BoxService>().saveManga(mockManga);
    await GetIt.I.get<BoxService>().cleanMangas();

    final mangaList = await GetIt.I.get<BoxService>().getAllMangas();

    expect(mangaList.length, 0);
  });
}
