import 'package:dio/dio.dart';
import 'package:kisiler_uygulamasi_cubit/model/kisiler_cevap.dart';
import 'package:kisiler_uygulamasi_cubit/sqlite/veritabani_yardimcisi.dart';
import 'dart:convert';
import '../model/kisiler.dart';

class KisilerDaoRespository {
  List<Kisiler> parseKisilerCevap(String cevap) {
    return KisilerCevap.fromJson(json.decode(cevap)).kisiler;
  } //gelen String cevabı alıp parse edip kisiler listesine dönüştürecek

  // verileri alma işlemleri
  Future<void> kisiKayit(String kisi_ad, String kisi_tel) async {
    var url = "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php";
    var veri = {"kisi_ad: ": kisi_ad, "kisi_tel": kisi_tel}; //Map oluşumu
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Kişi ekle : ${cevap.data.toString()}");

    //DB İŞLEMİ
    // var db = await VeritabaniYardimcisi.veritabaniErisim();
    // var bilgiler = Map<String, dynamic>();
    // bilgiler["kisi_ad"] = kisi_ad;
    // bilgiler["kisi_tel"] = kisi_tel;
    // await db.insert("kisiler", bilgiler);
    // }
  }

  Future<void> kisiGuncelle(
      int kisi_id, String kisi_ad, String kisi_tel) async {
    // var url = "http://kasimadalan.pe.hu/kisiler/update_kisiler.php";
    // var veri = {"kisi_ad: ": kisi_ad, "kisi_tel": kisi_tel}; //Map oluşumu
    // var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    // print("Kişi ekle : ${cevap.data.toString()}");

    //DB İŞLEMİ
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var bilgiler = Map<String, dynamic>();
    bilgiler["kisi_ad"] = kisi_ad;
    bilgiler["kisi_tel"] = kisi_tel;
    await db.update("kisiler", bilgiler,
    where: "kisi_id=?", whereArgs: [kisi_id]);
  }

  Future<List<Kisiler>> tumKisileriAl() async {
    // var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php";
    // var cevap = await Dio().get(url);
    // return parseKisilerCevap(cevap.data.toString());

    //DB İŞLEMİ
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
    "SELECT * FROM kisiler",
    ); 
    // key(String) - değer(her türlü değer olabilir bizim db için) - rawQuery ile sorgu oluşturduk. Veritabanındaki bilgileri satır satır getirecek

    return List.generate(maps.length, (i) {
    var satir = maps[i];
    return Kisiler(
    kisi_id: satir["kisi_id"],
    kisi_ad: satir["kisi_ad"],
    kisi_tel: satir["kisi_tel"]);
    }); //Her bir satırı kişi nesnesine dönüştürdük
  }

  Future<List<Kisiler>> kisiAra(String aramaKelimesi) async {
    // var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php";
    // var veri = {"kisi_ad: ": aramaKelimesi}; //Map oluşumu
    // var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    // return parseKisilerCevap(cevap.data.toString());

    //DB İŞLEMİ
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
    "SELECT * FROM kisiler WHERE kisi_ad like '%$aramaKelimesi%'"); // kişi adı ile aramaKelimesi arasında benzerlik aranıyor
    return List.generate(maps.length, (i) {
    var satir = maps[i];
    return Kisiler(
    kisi_id: satir["kisi_id"],
    kisi_ad: satir["kisi_ad"],
    kisi_tel: satir["kisi_tel"]);
    }); //Her bir satırı kişi nesnesine dönüştürdük
  }

  Future<void> kisiSil(int kisi_id) async {
    // var url = "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php";
    // var veri = {"kisi_id: ": kisi_id}; //Map oluşumu
    // var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    // print("Kişi sil : ${cevap.data.toString()}");

    //DB İŞLEMİ
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("kisiler", where: "kisi_id=?", whereArgs: [
    kisi_id
    ]); // whereArgs ile ? yerine kisi_id geleceğini söylemiş olduk
  }
}
