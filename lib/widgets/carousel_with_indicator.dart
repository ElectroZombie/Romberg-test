import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import 'carousel_text.dart';

final List<String> imgList = [
  'assets/images/image_1.png',
  'assets/images/image_2.jpg',
  'assets/images/image_3.png',
  'assets/images/image_4.png',
  'assets/images/image_5.png',
  'assets/images/image_6.png',
  'assets/images/image_7.png',
  'assets/images/image_8.jpg',
  'assets/images/image_9.jpg',
  'assets/images/image_10.png',
];

final List<String> textList = [
  'La fuente de las antillas',
  'Nuestros muertos alzando los brazos',
  'Monumento al trabajo',
  'Trovador campesino',
  'Columna Taína',
  'Cabezas contrapuestas de los indios Maniabo y Jibacoa',
  'Caballo',
  "Liberación de los pueblos",
  "Plaza Martiana"
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({super.key});

  @override
  CarouselWithIndicatorState createState() => CarouselWithIndicatorState();
}

class CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: screenWidth,
          height: screenHeight - 600,
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              pauseAutoPlayOnTouch: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: imgList.map<Widget>((item) {
              int index = imgList.indexOf(item);
              return Container(
                width: screenWidth - 84,
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: Stack(
                    children: [
                      GestureDetector(
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                          width: screenWidth - 84,
                          height: orientation == Orientation.portrait
                              ? screenHeight / 2
                              : screenWidth / 2,
                        ),
                        onTap: () => (),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0),
                          child: carouselText(textList[index]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(
            imgList,
            (index, url) {
              return Expanded(
                child: Container(
                  height: 3.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: _current == index
                        ? const Color(0xFF1BBC9B)
                        : const Color(0xFF707070),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
