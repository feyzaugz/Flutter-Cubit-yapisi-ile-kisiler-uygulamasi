import 'package:bloc/bloc.dart';
import 'package:kisiler_uygulamasi_cubit/repo/kisilerdao_repository.dart';

class KisiKayitCubit extends Cubit<void> {
  KisiKayitCubit() : super(0); // 0 ilk değer, varsayılan

  var krepo = KisilerDaoRespository();

  Future<void> kayit(String kisi_ad, String kisi_tel) async {
    await krepo.kisiKayit(kisi_ad, kisi_tel);
  }
}
