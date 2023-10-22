import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi {
  static final String veritabaniAdi = "rehber.sqlite";

  static Future<Database> veritabaniErisim() async {
    String veritabaniYolu = join(await getDatabasesPath(), veritabaniAdi); 

    if(await databaseExists(veritabaniYolu)) {
      print("Veritabanı zaten var. Kopyalamaya gerek yok.");
    } else {
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi"); // sqlite dosyamıza eriştik
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes); //aldığımız değeri byte'lara dönüştürdük
      await File(veritabaniYolu).writeAsBytes(bytes, flush: true); // veriTabani yoluna bu değeri kopyaladık
      print('Veritabanı kopyalandı');
    }

    return openDatabase(veritabaniYolu);
  }
}