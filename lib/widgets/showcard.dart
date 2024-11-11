
import 'package:flutter/material.dart';
import 'package:showtime/pages/showdetails.dart';
import 'package:showtime/utils.dart';

class ShowCard extends StatelessWidget {
  final dynamic showinfo;
  const ShowCard({super.key, this.showinfo});

  

  @override
  Widget build(BuildContext context) {
    String name = showinfo['show']['name'];
    String summary = cleanFormatting(showinfo['show']['summary']);
    double rating = (showinfo['show']['rating']['average'] ?? 0).toDouble();
    String premiered = showinfo['show']['premiered']??'';
    String language = showinfo['show']['language']??'';
    List genres = showinfo['show']['genres'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ShowDetailsPage(showinfo: showinfo,))
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: (showinfo['show']['image'] != null) ? 
                Image.network(
                  showinfo['show']['image']['medium'], 
                  height: 150, 
                  width: 100,
                  errorBuilder: (context, error, stackTrace) => const Placeholder(fallbackHeight: 150, fallbackWidth: 100,), 
                  )
                :
                Container(
                  height: 150,
                  width: 100,
                  color: Colors.white10,
                  child: Image.asset("assets/SHOWTIME.png"),
                ),
              // Placeholder(fallbackHeight: 150, fallbackWidth: 0,),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20), maxLines: 1,),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, (120-120*(rating/10)).toInt(), (180*(rating/10)).toInt(), 0),
                              borderRadius: BorderRadius.circular(3)
                            ),
                            child: Text("★ $rating"),
                          ),
                          Text("${premiered.isNotEmpty?premiered.substring(0,4):''} ${premiered.isNotEmpty&&language.isNotEmpty?'•':''} $language"),
                        ],
                      ),
                      Text(summary, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey),),
                      OverflowBar(
                        children: [
                          ...genres.map(
                            (genre) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              margin: const EdgeInsets.only(right: 5, top: 5),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text(genre),
                            )
                          ).toList()
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}