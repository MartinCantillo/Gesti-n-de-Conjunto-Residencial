import 'package:flutter/material.dart';

class AdminW extends StatefulWidget {
  const AdminW({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<AdminW> {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController repeatPassCtrl = TextEditingController();
  String gender = 'hombre';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        appBar: AppBar(
          
          title: const Text('Configuracion'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(60.0),
            child: Form(
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
      padding: const EdgeInsets.symmetric(vertical: 7),
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
            decoration: const InputDecoration(
              labelText: 'Nombre',
            ),
          ),
        ),
        formItemsDesign(
          Icons.phone,
          TextFormField(
            controller: mobileCtrl,
            decoration: const InputDecoration(
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
              const Text("Genero"),
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
            decoration: const InputDecoration(
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
            decoration: const InputDecoration(
              labelText: 'Contraseña',
            ),
          ),
        ),
        formItemsDesign(
          Icons.remove_red_eye,
          TextFormField(
            controller: repeatPassCtrl,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Repetir la Contraseña',
            ),
          ),
        ),
      ],
    );
  }
}
