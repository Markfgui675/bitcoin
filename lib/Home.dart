import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{

  dynamic _preco = 'Preço';

  void _recuperarPreco() async{

    String url = 'https://blockchain.info/ticker';
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    print("Resultado: "+ retorno.toString());

    var brl = retorno['BRL'];

    setState((){
      _preco = brl['buy'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              //imagem
              Image.asset('imagens/bitcoin.png'),

              //resultado do preço do bitcoin
              Padding(padding: EdgeInsets.only(top: 32, bottom: 32),
                child: Text('R\$ '+ _preco.toString(), style: TextStyle(fontSize: 25),),),

              //botão atualizar
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange
                  ),
                  onPressed: _recuperarPreco, child: Text('Atualizar'))

            ],
          ),
        ),
      ),

    );
  }
}