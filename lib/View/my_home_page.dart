import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Model/password_details.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String generatorpassword = 'Generator Password';
  Set passwordSet = {};
  List passwordList = [];
  int currentValue = 12, maxValue = 30;

  TextEditingController newNumber = TextEditingController();
  List<TextEditingController> myDataFiled = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  static final choose = [false, false, false, false, false, false];
  List<int> asciiCode = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('First Windows App')),
        backgroundColor: const Color.fromARGB(255, 70, 36, 0),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              curve: Curves.easeInOutCirc,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 105, 54, 0),
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: box(0),
            child: Column(
              children: [
                Container(
                  decoration: box(1),
                  child: textSelected(),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  buton(1),
                  const SizedBox(width: 15),
                  buton(0),
                ]),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 200,
                    decoration: box(1),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 20),
                          rowd(0),
                          rowd(1),
                          rowd(2),
                          rowd(3),
                          rowd(4),
                          const SizedBox(height: 10),
                          const Text('Length of password:'),
                          const SizedBox(height: 10),
                          tickNumber(),
                          const SizedBox(height: 20),
                        ]),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: Column(children: [
                    textSelected(),
                    field(const Icon(Icons.link_rounded), myDataFiled[0]),
                    field(const Icon(Icons.email_rounded), myDataFiled[1]),
                    field(const Icon(Icons.comment_rounded), myDataFiled[2]),
                  ]),
                ),
                const SizedBox(height: 20),
                saveBtn(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  box(n) {
    return BoxDecoration(
        borderRadius:
            n == 0 ? BorderRadius.circular(0) : BorderRadius.circular(10),
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 155, 121, 85),
          Color.fromARGB(120, 155, 121, 85)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight));
  }

  chkBox(int i) {
    return Checkbox(
      activeColor: Colors.green,
      hoverColor: const Color.fromARGB(120, 70, 36, 0),
      value: choose[i],
      onChanged: (newvale) {
        setState(() {
          choose[i] = newvale!;
        });
      },
    );
  }

  rowd(int i) {
    final lable = ['A-Z', 'a-z', '0-9', '!@#...', 'No repet'];
    return Row(
      children: [const SizedBox(width: 50), chkBox(i), Text(lable[i])],
    );
  }

  newRecord() {
    return setState(() {
      for (int i = 0; i < choose.length; i++) {
        choose[i] = false;
      }
      currentValue = 12;
      newNumber.text = '';
      currentValue = 12;
      generatorpassword = 'Generator Password';
    });
  }

  buton(i) {
    return FloatingActionButton(
        child: i == 1
            ? const Icon(Icons.add)
            : const Icon(Icons.published_with_changes_outlined),
        backgroundColor: const Color.fromARGB(255, 70, 36, 0),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        hoverColor: const Color.fromARGB(120, 70, 36, 0),
        onPressed: i == 1 ? (newRecord) : (resetResult));
  }

  tickNumber() {
    return Column(children: [
      CustomNumberPicker(
        initialValue: currentValue,
        maxValue: maxValue,
        minValue: 8,
        step: 1,
        onValue: (value) {
          setState(() {
            currentValue = int.parse(value.toString());
          });
        },
      ),
      SizedBox(
        width: 50,
        child: TextFormField(
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            iconColor: Colors.black,
          ),
          keyboardType: TextInputType.number,
          controller: newNumber,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      )
    ]);
  }

  resetResult() {
    // 33-47 && 58-64 && 91-95 && 123-125 =>  !@#....
    // 48-57 => 0-9
    // 65-90 => A-Z
    // 97-122 => a-z
    passwordSet.clear();
    passwordList.clear();
    asciiCode.clear();

    if (newNumber.text.isNotEmpty &&
        (currentValue < int.parse(newNumber.text))) {
      return setState(() {
        if (int.parse(newNumber.text) > 1000) {
          currentValue = 1000;
          maxValue = currentValue + 10;
        } else {
          currentValue = int.parse(newNumber.text);
          maxValue = currentValue + 10;
        }
      });
    }
    if (choose[0]) {
      for (var i = 65; i <= 90; i++) {
        asciiCode.add(i);
      }
    }
    if (choose[1]) {
      for (var i = 97; i <= 122; i++) {
        asciiCode.add(i);
      }
    }
    if (choose[2]) {
      for (var i = 48; i <= 57; i++) {
        asciiCode.add(i);
      }
    }
    if (choose[3]) {
      for (var i = 33; i <= 47; i++) {
        asciiCode.add(i);
      }
      for (var i = 58; i <= 64; i++) {
        asciiCode.add(i);
      }
      for (var i = 91; i <= 96; i++) {
        asciiCode.add(i);
      }
      for (var i = 123; i <= 126; i++) {
        asciiCode.add(i);
      }
    }
    if (asciiCode.isNotEmpty) {
      generatorpassword = '';
      getSelectPassword();
    } else {
      setState(() {
        generatorpassword = 'Generator Password';
      });
    }
  }

  random(min, max) {
    return min + Random().nextInt(max - min);
  }

  getSelectPassword() {
    int max = asciiCode.length;
    for (var i = 0; i < currentValue; i++) {
      int lengthOfPassword = random(0, max);

      int target = asciiCode.elementAt(lengthOfPassword);
      if (!choose[4]) {
        passwordList.add(String.fromCharCode(target));
      } else {
        passwordSet.add(String.fromCharCode(target));
        if (i != passwordSet.length - 1) {
          --i;
          if (passwordSet.length == asciiCode.length) {
            break;
          }
        }
      }
    }
    setState(() {
      if (passwordList.isNotEmpty) {
        for (int i = 0; i < passwordList.length; i++) {
          generatorpassword += passwordList.elementAt(i);
        }
      } else {
        for (int i = 0; i < passwordSet.length; i++) {
          generatorpassword += passwordSet.elementAt(i);
        }
      }
      newNumber.text = generatorpassword.length.toString();
    });
  }

  textSelected() {
    return SelectableText(
      generatorpassword,
      showCursor: true,
      toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  field(Icon i, f) {
    return TextField(
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black),
        fillColor: Colors.brown,
        focusColor: Colors.brown,
        iconColor: Colors.black,
        icon: i,
      ),
      controller: f,
      keyboardType: TextInputType.number,
    );
  }

  saveBtn() {
    return FloatingActionButton(
      child: const Icon(Icons.save_alt_rounded),
      backgroundColor: const Color.fromARGB(255, 70, 36, 0),
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      hoverColor: const Color.fromARGB(120, 70, 36, 0),
      onPressed: saveRecord(),
    );
  }

  saveRecord() {
    PasswordDetails newRecord = PasswordDetails(
      password: myDataFiled[1].text,
      url: myDataFiled[1].text,
      email: myDataFiled[1].text,
      remark: myDataFiled[1].text,
    );
    
  }
}
