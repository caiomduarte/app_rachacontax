import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Variaveis
  double taxa = 0;
  double totalconta, totalpagar, comissao;
  int qtdpessoas;

  //Criando os TextControllers
  TextEditingController txttotal = TextEditingController();
  TextEditingController txtqtd = TextEditingController();

  //criando a chave do form
  final _formkey = GlobalKey<FormState>();

  //metodo que calula a conta
  void calcularConta() {
    //1 passo - Receber os valores
    setState(() {
      totalconta = double.parse(txttotal.text);
      qtdpessoas = int.parse(txtqtd.text);

      //2 passo - Calcular a comissao do garçon
      comissao = (taxa * totalconta) / 100;

      //3 passo - Calcular o total por pessoa
      totalpagar = (totalconta + comissao) / qtdpessoas;

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Total a Pagar por Pessoa"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/icon_smile.png",
                      width: 60,
                    ),
                    Text("O TOTAL DA CONTA: R\$ $totalconta"),
                    Text("TAXA DO GARÇON: R\$ $comissao"),
                    Text("O TOTAL POR PESSOA: R\$ $totalpagar"),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color(0xffFF6600),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RACHA CONTA"),
          centerTitle: true,
          backgroundColor: Color(0xffFF6600),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: SvgPicture.asset("assets/icon_money.svg"),
                    ),
                    TextFormField(
                      controller: txttotal,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(labelText: "Total da conta"),
                      style: TextStyle(fontSize: 18),
                      validator: (valor){
                        if(valor.isEmpty) return "Campo obrigatório";
                        else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Taxa de Serviços %:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Slider(
                          value: taxa,
                          min: 0,
                          max: 10,
                          label: "$taxa%",
                          divisions: 10,
                          activeColor: Color(0xffFF6600),
                          inactiveColor: Colors.grey,
                          onChanged: (double valor) {
                            setState(() {
                              taxa = valor;
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: txtqtd,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(labelText: "Qtd Pessoas"),
                      style: TextStyle(fontSize: 18),
                      validator: (valor){
                        if(valor.isEmpty) return "Campo obrigatório";
                        else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        child: Text(
                          "Calcular",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xffFF6600),
                            onPrimary: Colors.white),
                        onPressed: (){
                          if(_formkey.currentState.validate()){
                            calcularConta();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
