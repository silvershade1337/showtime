import 'package:flutter/material.dart';
import 'package:showtime/widgets/showcard.dart';

class HomeView extends StatefulWidget {
  final dynamic showInfo;
  final void Function()? onSearchPressed;
  const HomeView({super.key, this.showInfo, required this.onSearchPressed});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool initial = true;
  List searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults = widget.showInfo;
  }
  
  Widget resultsWidget(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ShowCard(showinfo: searchResults[index],);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Image.asset('assets/SHOWTIMElogo.png', height: 30,),
              ),
              const Expanded(child: Text("ShowTime", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),)),
              IconButton(
                onPressed: widget.onSearchPressed, 
                icon: const Icon(Icons.search, color: Colors.white),
                ),
            ],
          ),
          Expanded(
            child: resultsWidget(context)
          )
        ],
      ),
    );
  }
}