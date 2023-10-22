import 'package:bloc/bloc.dart';
import 'package:kisiler_uygulamasi_cubit/repo/kisilerdao_repository.dart';
import '../model/kisiler.dart';

class AnaSayfaCubit extends Cubit<List<Kisiler>> {
  AnaSayfaCubit() : super(<Kisiler>[]); //varsayılan değeri boş bir liste

  var krepo = KisilerDaoRespository();

  Future<void> kisileriYukle() async {
    var liste = await krepo.tumKisileriAl();
    emit(
        liste); // repo'dan aldığımız listeyi cubit'te alacağız ve emit ettiğimizde bu ana sayfa cubit'i dinleyen herhangi bir yere bu listeyi aktaracağız.
  }

  Future<void> ara(String aramaKelimesi) async {
    var liste = await krepo.kisiAra(aramaKelimesi);
    emit(liste);
  }

  Future<void> sil(int kisi_id) async {
    await krepo.kisiSil(kisi_id);
    await kisileriYukle();
  }
}
