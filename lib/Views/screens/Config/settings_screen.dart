import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/screens/Home/HomeAdmin/HomeA.dart';

// ignore: camel_case_types
class settingsPage extends StatelessWidget {
  const settingsPage({Key? key}) : super(key: key);

  static const String nombre = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon:  Icon(Icons.arrow_back_rounded, color: Theme.of(context).secondaryHeaderColor,)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.grey, 
              ),
            ),
          ),
          child: ListView(
            children:  [
              UserAccountsDrawerHeader(
                accountName: Text('Usuario'),
                accountEmail: Text('usuario@example.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,

                  child: Icon(
                    Icons.person,
                    size: 68.0,
                    color: Colors.black,
                  ),
                  
                ),
                
              ),
            ],
            
          ),
          
        ),
        
      ),
    );
  }
}
