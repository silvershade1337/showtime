

import 'package:flutter/material.dart';
import 'package:showtime/utils.dart';

class ShowDetailsPage extends StatelessWidget {
  final dynamic showinfo;
  const ShowDetailsPage({super.key, this.showinfo});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String name = showinfo['show']['name'];
    String summary = cleanFormatting(showinfo['show']['summary']);
    String status = showinfo['show']['status'];
    String ended = showinfo['show']['ended']??'';
    double rating = (showinfo['show']['rating']['average'] ?? 0).toDouble();
    String premiered = showinfo['show']['premiered']??'';
    String language = showinfo['show']['language']??'';
    String type = showinfo['show']['type'];
    String runtime = (showinfo['show']['runtime'] ?? showinfo['show']['averageRuntime'] ?? '').toString();
    List genres = showinfo['show']['genres'];
    String scheduleTime = showinfo['show']['schedule']['time'];
    List scheduleDays = showinfo['show']['schedule']['days'];
    String networkName = '';
    String networkCountry = '';
    if (showinfo['show']['network'] != null) {
      networkName = showinfo['show']['network']['name'];
      networkCountry = showinfo['show']['network']['country']['name'];
    }
    
    
    
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: size.height / 3
                    ),
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: (showinfo['show']['image'] != null) ? 
                        Image.network(
                          showinfo['show']['image']['medium'],
                          width: size.width/2,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) => const Placeholder(fallbackHeight: 150, fallbackWidth: 100,), 
                          )
                        :
                        Container(
                          height: 300,
                          width: 150,
                          color: Colors.white10,
                          child: Image.asset("assets/SHOWTIME.png"),
                        ),
                    ),
                  ),
                  
                // Placeholder(fallbackHeight: 150, fallbackWidth: 0,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: size.width*0.70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30)),
                        const SizedBox(height: 8,),
                        if (premiered.isNotEmpty) Row(children: [const Icon(Icons.calendar_month), Text("  Premiered $premiered")],),
                        const SizedBox(height: 3,),
                        if (language.isNotEmpty) Row(children: [const Icon(Icons.public), Text("  $language")],),
                        Container(
                            margin: const EdgeInsets.only(right: 5, top:10),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, (120-120*(rating/10)).toInt(), (180*(rating/10)).toInt(), 0),
                              borderRadius: BorderRadius.circular(3)
                            ),
                            child: Text("★ $rating", style: const TextStyle(fontSize: 15),),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 5, top:10),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(3)
                            ),
                            child: Text("Type: $type", style: const TextStyle(color: Colors.black),),
                        ),
                        const SizedBox(height: 8,),
                        if (genres.isNotEmpty) const Text("GENRES", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        Wrap(
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
                
              ]
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 0,),
                  const Text("SUMMARY", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text(summary, style: const TextStyle(color: Colors.grey),),
                  if (scheduleDays.isNotEmpty || scheduleTime.isNotEmpty) ...[
                    const SizedBox(height: 20,),
                    const Text("SCHEDULE", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    if (scheduleDays.isNotEmpty) Text("On ${scheduleDays.join(", ")}", style: const TextStyle(color: Colors.grey),),
                    if (scheduleTime.isNotEmpty) Text("At $scheduleTime", style: const TextStyle(color: Colors.grey),),
                  ],
                  if (runtime.isNotEmpty) ...[
                    const SizedBox(height: 20,),
                    const Text("RUNTIME", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    Text("$runtime Minutes", style: const TextStyle(color: Colors.grey),),
                  ],
                  if (status.isNotEmpty) ...[
                    const SizedBox(height: 20,),
                    const Text("STATUS", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    Text("$status $ended", style: const TextStyle(color: Colors.grey),),
                  ],
                  if (networkName.isNotEmpty) ...[
                    const SizedBox(height: 20,),
                    const Text("TV NETWORK", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    Text("$networkName ${networkCountry.isNotEmpty?'($networkCountry)':''}", style: const TextStyle(color: Colors.grey),),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
