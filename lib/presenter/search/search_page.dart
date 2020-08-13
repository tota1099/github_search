import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/presenter/search/search_bloc.dart';
import 'package:github_search/presenter/search/states/state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  Widget _buildList(List<ResultSearch> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, id) {
        final item = list[id];
        return ListTile(
          leading: item.image == null
            ? Container() 
            : CircleAvatar(
              backgroundImage: NetworkImage(item.image),
            ),
          title: Text(item.nickname ?? "")
        );
      }
    );
  }

  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search')
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, top:8),
          child: TextField(
            onChanged: bloc.add,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Search..."
            )
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: bloc,
            builder: (context, snapshot) {
              final state = bloc.state;

              if(state is SearchStart) {
                return Center(
                  child: Text("Digite um texto")
                );
              } else if(state is SearchError) {
                return Center(
                  child: Text("Aconteceu algum erro.")
                );
              } else if(state is SearchLoading) {
                return Center(
                  child: CircularProgressIndicator()
                );
              } else if(state is SearchSuccess) {
                return _buildList(state.list);
              } else {
                return Container();
              }
            }
          ),
        ),
      ]),
    );
  }
}