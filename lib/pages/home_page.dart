import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String _informacoes = "Informe seus dados acima!";
  GlobalKey<FormState> _chaveForm = GlobalKey<FormState>();

  void _resetarCampos() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _informacoes = "Informe seus dados acima!";
      _chaveForm = GlobalKey<FormState>();
    });
  }

  void _calcularImc() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;
    double imc = peso / (altura * altura);

    setState(() {
      if (imc < 18.6) {
        _informacoes = "Abaixo do Peso, IMC: ";
      } else if (imc >= 18.6 && imc < 24.9) {
        _informacoes = "Peso Ideal, IMC: ";
      } else if (imc >= 24.9 && imc < 29.9) {
        _informacoes = "Levemente acima do Peso, IMC: ";
      } else if (imc >= 29.9 && imc < 34.9) {
        _informacoes = "Obesidade Grau I, IMC: ";
      } else if (imc >= 34.9 && imc < 39.9) {
        _informacoes = "Obesidade Grau II, IMC: ";
      } else {
        _informacoes = "Obesidade Grau III, IMC: ";
      }

      _informacoes += imc.toStringAsPrecision(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 255, 255, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetarCampos,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _chaveForm,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                Icon(Icons.person, size: 150),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.black54)),
                  controller: pesoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira seu Peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (Cm)",
                      labelStyle: TextStyle(color: Colors.black54)),
                  controller: alturaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_chaveForm.currentState!.validate()) {
                            _calcularImc();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(0, 255, 255, 1),
                        ),
                      ),
                    )),
                Text(_informacoes)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
