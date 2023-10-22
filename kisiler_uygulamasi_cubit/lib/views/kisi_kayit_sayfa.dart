import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_cubit/cubit/kisi_kayit_cubit.dart';

class KisiKayitSayfa extends StatefulWidget {
  const KisiKayitSayfa({super.key});

  @override
  State<KisiKayitSayfa> createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {
  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();

  Future<void> kayit(String kisi_ad, String kisi_tel) async {
    print('Kişi Kayıt: $kisi_ad, $kisi_tel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kişi Kayıt'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKisiAd,
                decoration: const InputDecoration(hintText: 'Kişi Ad'),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: const InputDecoration(hintText: 'Kişi Tel'),
              ),
              ElevatedButton(
                onPressed: () {
                 context.read<KisiKayitCubit>().kayit(tfKisiAd.text, tfKisiTel.text);
                },
                child: const Text('KAYDET'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
