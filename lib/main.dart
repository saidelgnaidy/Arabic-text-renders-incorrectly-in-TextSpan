import 'dart:convert';
import 'package:arabic_json_proplem/surah_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<Modle> readArabicJson() async {
      var surahContent = await DefaultAssetBundle.of(context).loadString('assets/surah_2.json',cache: true);
      return  Modle.fromJson(json: json.decode(surahContent));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('arabic json problem'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<Modle>(
                future: readArabicJson(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return SelectableText.rich(
                      TextSpan(
                        children: snapshot.data!.verse.verses.map((text) {
                          return TextSpan(
                            children: [
                              TextSpan(
                                text: text,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontFamily: 'font4',
                                ),
                              ),
                              const TextSpan(
                                text: ' ﴿1﴾ ',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontFamily: 'font3',
                                ),
                              ),
                            ],
                          );
                        },
                        ).toList(),
                      ),
                      textAlign: TextAlign.center,
                    );

                  }else
                    {
                      return const Center(child: CircularProgressIndicator());
                    }

                }
              ),
            ],
          ),
        ),
      ),
    );
  }


}
