import 'package:flutter/material.dart';

class TrendingRoutes extends StatefulWidget {
  const TrendingRoutes({super.key});

  @override
  State<TrendingRoutes> createState() => _TrendingRoutesState();
}

class _TrendingRoutesState extends State<TrendingRoutes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                'Trending Routes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 160,
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/Kandy.jpg'),
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Colombo - Kandy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Colombo Kandy rd; A1\n122km',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 160,
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/jaffna.jpg'),
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Colombo - Jaffna',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Kandy rd; Kandy Jaffna Hwy A9\n404.3km',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 160,
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/ratnapura.jpg'),
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Colombo - Rathnapura',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Highlevel rd; A4\n150km',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
