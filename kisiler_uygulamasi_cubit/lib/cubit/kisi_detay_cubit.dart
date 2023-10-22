import 'package:bloc/bloc.dart';
import 'package:kisiler_uygulamasi_cubit/repo/kisilerdao_repository.dart';

class KisiDetayCubit extends Cubit<void> {
  KisiDetayCubit() : super(0); // 0 ilk değer, varsayılan

  var krepo = KisilerDaoRespository();

  Future<void> kayit(String kisi_ad, String kisi_tel) async {
    await krepo.kisiKayit(kisi_ad, kisi_tel);
  }

  Future<void> guncelle(int kisi_id, String kisi_ad, String kisi_tel) async {
    await krepo.kisiGuncelle(kisi_id, kisi_ad, kisi_tel);
  }
}
