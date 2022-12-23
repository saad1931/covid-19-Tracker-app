// ignore_for_file: non_constant_identifier_names

import 'package:covid_tracker/Services/countries_services.dart';
import 'package:covid_tracker/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList>
  {
 

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CountriesServices countriesServices = CountriesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  hintText: "Search with Country name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: countriesServices.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    name: snapshot.data![index]['country'], 
                                                    cases: snapshot.data![index]['cases'],
                                                    deaths:snapshot.data![index]['deaths'], 
                                                    image: snapshot.data![index]['countryInfo']['flag'], 
                                                    recovered: snapshot.data![index]['recovered'], 
                                                    todaycases: snapshot.data![index]['todayCases'], 
                                                    todaydeaths:snapshot.data![index]['todayDeaths'], )
                                                  ));
                                    },
                                    child: ListTile(
                                      title: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white,
                                      ),
                                      leading: Container(
                                        height: 50,
                                        width: 59,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (searchController.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                 DetailScreen(
                                                    name: snapshot.data![index]['country'], 
                                                    cases: snapshot.data![index]['cases'],
                                                    deaths:snapshot.data![index]['deaths'], 
                                                    image: snapshot.data![index]['countryInfo']['flag'], 
                                                    recovered: snapshot.data![index]['recovered'], 
                                                    todaycases: snapshot.data![index]['todayCases'], 
                                                    todaydeaths:snapshot.data![index]['todayDeaths'], )
                                                  ));
                                    },
                                    child: ListTile(
                                      title:
                                          Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]['countryInfo']
                                                  ['flag'])),
                                    ),
                                  )
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    name: snapshot.data![index]['country'], 
                                                    cases: snapshot.data![index]['cases'],
                                                    deaths:snapshot.data![index]['deaths'], 
                                                    image: snapshot.data![index]['countryInfo']['flag'], 
                                                    recovered: snapshot.data![index]['recovered'], 
                                                    todaycases: snapshot.data![index]['todayCases'], 
                                                    todaydeaths:snapshot.data![index]['todayDeaths'], )
                                                  ));
                                    },
                                    child: ListTile(
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }))
        ],
      )),
    );
  }
}
