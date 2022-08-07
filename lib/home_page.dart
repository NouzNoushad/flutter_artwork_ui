import 'package:flutter/material.dart';
import 'package:flutter_artwork_ui/login.dart';

class HomePage extends StatefulWidget {
  final String name;
  const HomePage({Key? key, required this.name}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List categories = ["Trending", "Music", "Sports", "Utility"];

  List<Map<String, dynamic>> categoriesDetails = [
    {
      "image": "art2.jpg",
      "profile": "profile1.png",
      "name": "rocket",
    },
    {
      "image": "art3.jpg",
      "profile": "profile2.png",
      "name": "storm",
    },
  ];

  List<Map<String, dynamic>> latestCollections = [
    {
      "image": "art1.jpg",
      "profile": "profile2.png",
      "name": "storm",
      "price": 400,
    },
    {
      "image": "art4.jpg",
      "profile": "profile1.png",
      "name": "rocket",
      "price": 600,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 116, 79, 117),
              Color.fromARGB(255, 228, 150, 193),
              Color.fromARGB(255, 232, 162, 200),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 232, 162, 200).withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  artworkAppBar(),
                  searchTextField(),
                ],
              ),
            ),
            titlesRow("Categories"),
            Container(
              height: 40,
              // color: Colors.white,
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 162, 200)
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.white10),
                    ),
                    child: Text(
                      categories[index],
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 220,
              // color: Colors.white,
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesDetails.length,
                itemBuilder: (context, index) {
                  return categoryGallery(index);
                },
              ),
            ),
            titlesRow("Latest Collection"),
            Container(
              height: 110,
              // color: Colors.white,
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: latestCollections.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 110,
                    width: 230,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 232, 162, 200),
                      border: Border.all(width: 1, color: Colors.white24),
                    ),
                    child: latestCollectionDetails(index),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget latestCollectionDetails(int index) {
    final latest = latestCollections[index];
    return Row(
      children: [
        ClipPath(
          clipper: CustomClipperImage(),
          child: Container(
            width: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/${latest["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 232, 162, 200),
                        radius: 10,
                        backgroundImage: AssetImage(
                          "assets/${latest["profile"]}",
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        latest["name"],
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$${latest["price"]}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Align(alignment: Alignment.bottomRight, child: backIconDesign())
            ],
          ),
        ),
      ],
    );
  }

  Widget categoryGallery(int index) {
    final category = categoriesDetails[index];
    return ClipPath(
      clipper: CustomClipperDesign(),
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 15),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage("assets/${category["image"]}"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 50,
          width: 180,
          color: const Color.fromARGB(255, 232, 162, 200).withOpacity(0.3),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 232, 162, 200),
                    radius: 13,
                    backgroundImage: AssetImage(
                      "assets/${category["profile"]}",
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    category["name"],
                  ),
                ],
              ),
              backIconDesign(),
            ],
          ),
        ),
      ),
    );
  }

  Widget backIconDesign() => ClipPath(
        clipper: CustomClipperBox(),
        child: Container(
          height: 20,
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Color.fromARGB(255, 249, 173, 190),
            ),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 120, 48, 102),
              Color.fromARGB(255, 252, 172, 180),
              Color.fromARGB(255, 249, 173, 190),
            ]),
          ),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 13,
          ),
        ),
      );

  Widget titlesRow(String title) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      );

  Widget searchTextField() => TextField(
        cursorColor: Color.fromARGB(255, 120, 48, 102),
        // text style
        style: const TextStyle(
          color: Color.fromARGB(255, 120, 48, 102),
          fontSize: 13,
        ),
        decoration: InputDecoration(
          hintText: "Search..",
          hintStyle: const TextStyle(
            color: Colors.white24,
            fontSize: 12,
          ),
          // remove extra padding
          isDense: true,
          // for background color
          filled: true,
          fillColor: Color.fromARGB(255, 232, 162, 200).withOpacity(0.2),
          // border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.white10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.white10),
          ),
          suffixIcon: const Icon(Icons.search,
              size: 20, color: Color.fromARGB(255, 232, 162, 200)),
        ),
      );

  Widget artworkAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 232, 162, 200),
                radius: 18,
                backgroundImage: AssetImage("assets/profile3.png"),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Welcome, ${widget.name}",
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          GestureDetector(
              onTap: () {
                // navigate back to login page
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ArtWorkLogin()),
                );
              },
              child: const Icon(Icons.logout, size: 18, color: Colors.white)),
        ],
      );
}

class CustomClipperImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(0, height - 60);
    path.lineTo(0, height);
    path.lineTo(width - 20, height);
    path.lineTo(width, height - 20);
    path.lineTo(width, 0);
    path.lineTo(width - 60, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipperBox extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(0, height - 8);
    path.lineTo(0, height);
    path.lineTo(width - 10, height);
    path.lineTo(width, height - 12);
    path.lineTo(width, 0);
    path.lineTo(width - 30, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipperDesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(0, height - 180);
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, 0);
    path.lineTo(width - 140, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
