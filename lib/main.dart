import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ListView',
    initialRoute: '/menu',
    routes: {
      '/menu': (context) => MenuPrincipal(),
      '/list1': (context) => ListViewBuilder(),
      '/list2': (context) => ListViewSepareted(),
    },
  ));
}

//
// MENU PRINCIPAL
//
class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.all(40),
        child: ListView(
          children: [
            Icon(Icons.list, size: 120, color: Colors.grey),
            Text(
              'O widget ListView permite adicionar uma ' +
                  'lista de itens roláveis',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 40),
            ListTile(
              leading: Icon(Icons.person),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
              title: Text('ListView.builder', style: TextStyle(fontSize: 24)),
              subtitle: Text('Utilizado para repetir um conjunto de itens.',
                  style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, '/list1');
              },
              hoverColor: Colors.red,
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
              title: Text('ListView.separeted', style: TextStyle(fontSize: 24)),
              subtitle: Text(
                  'Utilizado para repetir um conjunto de itens incluindo um separador.',
                  style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, '/list2');
              },
              hoverColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

//
// ListView.builder
//
class ListViewBuilder extends StatefulWidget {
  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView.builder')),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          //HORIZONTAL
          Container(
            padding: EdgeInsets.all(40),
            color: Colors.grey[300],
            height: 320,
            child: Scrollbar(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      height: 200,
                      margin: EdgeInsets.all(20),
                      color: Colors.blue,
                      child: Center(
                        child: Text('Item $index'),
                      ),
                    );
                  }),
            ),
          ),

          //VERTICAL
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              color: Colors.grey[300],
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      height: 200,
                      margin: EdgeInsets.all(20),
                      color: Colors.grey[400],
                      child: Row(children: [
                        Container(
                          width: 150,
                          child: Center(
                            child: Image.network(
                                'https://picsum.photos/id/${index + 1}/120'),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras cursus congue sem, at auctor mauris ornare vel. Nullam quis libero sit amet ante convallis ornare. '),
                                SizedBox(height: 20),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    child: Text('comprar'),
                                    onPressed: () {},
                                  ),
                                )
                              ]),
                        )),
                      ]),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

//
// ListView.separeted
//
class ListViewSepareted extends StatefulWidget {
  @override
  _ListViewSeparetedState createState() => _ListViewSeparetedState();
}

class _ListViewSeparetedState extends State<ListViewSepareted> {
  //lista dinâmica simplesmente encadeada
  var lista = [];

  var txtTarefa = TextEditingController();
  var txtDialogo = TextEditingController();

  @override
  void initState() {
    lista.add('Ir ao supermercado');
    lista.add('Comprar ração para o cachorro');
    lista.add('Trocar a lâmpada da cozinha');
    lista.add('Pagar a conta de luz');
    lista.add('Abastecer o veículo');
    lista.add('Comprar um ventilador novo');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView.separeted'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: txtTarefa,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Adicionar Tarefa',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.grey[600]),
                  onPressed: () {
                    setState(() {
                      if (txtTarefa.text.isNotEmpty) {
                        lista.add(txtTarefa.text);
                        txtTarefa.clear();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Tarefa adicionada com sucesso!'),
                          duration: Duration(seconds: 2),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Você precisa definir uma tarefa.'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                //Aparência do item da lista
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      lista[index],
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          lista.removeAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Tarefa removida com sucesso.'),
                            duration: Duration(seconds: 2),
                          ));
                        });
                      },
                    ),
                  );
                },

                //Aparência do divisor
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.blue[100],
                    thickness: 1,
                  );
                },

                //total de itens da lista
                itemCount: lista.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Adicionar tarefa'),
                  content: TextField(
                    controller: txtDialogo,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            if (txtDialogo.text.isNotEmpty) {
                              lista.add(txtDialogo.text);
                              txtDialogo.clear();

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Tarefa adicionada com sucesso!'),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Você precisa definir uma tarefa.'),
                                duration: Duration(seconds: 2),
                              ));
                            }
                          });
                          Navigator.pop(context);
                        },
                        child: Text('ok')
                    ),

                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Text('cancelar')
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
