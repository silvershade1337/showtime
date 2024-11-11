import 'package:flutter/material.dart';
import 'package:showtime/apihandler.dart';
import 'package:showtime/widgets/showcard.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchInputController = TextEditingController();
  bool initial = true;
  List searchResults = [];
  
  Widget resultsWidget(BuildContext context) {
    if (initial) {
      return const Center(
        child: Text("Search for any show and press the search icon to see results", style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
      );
    }
    else if (!initial) {
      if (searchResults.isEmpty) {
        return const Center(
        child: Text("No results containing your search terms were found", style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
      );
      }
      else {
        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return ShowCard(showinfo: searchResults[index],);
          },
      );
      }
    }
    else {
      return const Center();
    }
  }

  void startSearch([String? query]) async {
    var results = await getSearchResults(searchInputController.text);
    setState(() {
      initial = false;
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.white24,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(15),
            child: Row(
              children: [
                IconButton(
                  onPressed: startSearch, 
                  icon: const Icon(Icons.search, color: Colors.white),
                  ),
                Expanded(
                  child: TextField(
                    onSubmitted: startSearch,
                    controller: searchInputController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                      hintText: "Search",
                      suffixIcon: searchInputController.text.isNotEmpty? IconButton(
                        onPressed: () {
                          setState(() {
                            searchInputController.clear();
                            initial = true;
                          });
                        },
                        icon: const Icon(Icons.close),
                      ) : null
                    ),
                    
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: resultsWidget(context)
          )
        ],
      ),
    );
  }
}