import 'package:flutter/material.dart';

class AdminW extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<AdminW> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController mobileCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController repeatPassCtrl = new TextEditingController();
  String gender = 'hombre';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: new Scaffold(
        
        appBar: new AppBar(
          
          title: new Text('Configuracion'),
          centerTitle: true,
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(60.0),
            child: new Form(
              key: keyForm,
              child: formUI(),
              
            ),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        formItemsDesign(
          Icons.person,
          TextFormField(
            controller: nameCtrl,
            decoration: InputDecoration(
              labelText: 'Nombre',
            ),
          ),
        ),
        formItemsDesign(
          Icons.phone,
          TextFormField(
            controller: mobileCtrl,
            decoration: InputDecoration(
              labelText: 'Numero de telefono',
            ),
            keyboardType: TextInputType.phone,
            maxLength: 10,
          ),
        ),
        formItemsDesign(
          null,
          Column(
            children: <Widget>[
              Text("Genero"),
              RadioListTile<String>(
                title: const Text('Hombre'),
                value: 'hombre',
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Mujer'),
                value: 'mujer',
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              )
            ],
          ),
        ),
        formItemsDesign(
          Icons.email,
          TextFormField(
            controller: emailCtrl,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 32,
          ),
        ),
        formItemsDesign(
          Icons.remove_red_eye,
          TextFormField(
            controller: passwordCtrl,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
            ),
          ),
        ),
        formItemsDesign(
          Icons.remove_red_eye,
          TextFormField(
            controller: repeatPassCtrl,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Repetir la Contraseña',
            ),
          ),
        ),
      ],
    );
  }
}
