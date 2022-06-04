import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lighthouse/screens/post_details.dart';
import 'package:lighthouse/services/post.dart';

class MissingSpottedMap extends StatefulWidget {
  const MissingSpottedMap({Key? key}) : super(key: key);

  @override
  State<MissingSpottedMap> createState() => _MissingSpottedMapState();
}

class _MissingSpottedMapState extends State<MissingSpottedMap> {
  final Completer<GoogleMapController> _controller = Completer();
  late bool _isLoading;
  late bool _isSpotted;
  late List<Marker> _spottedMarkers;
  late List<Marker> _missingMarkers;

  Future<void> fetchMarkers(bool isSpotted) async {
    setState(() {
      _isLoading = true;
    });
    var missing = await PostService().getMissingPosts(isSpotted);
    var id = 0;
    if (isSpotted) {
      _spottedMarkers = [];
    } else {
      _missingMarkers = [];
    }
    for (var post in missing) {
      var marker = Marker(
        markerId: MarkerId(id.toString()),
        position: LatLng(post.latitude, post.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(
          title: post.name,
          snippet: post.lastSeen.toString(),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostDetails(post: post),
          fullscreenDialog: true,
        )),
      );
      if (isSpotted) {
        _spottedMarkers.add(marker);
      } else {
        _missingMarkers.add(marker);
      }
      id++;
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> fetchAllMarkers() async {
    await fetchMarkers(true);
    await fetchMarkers(false);
  }

  void _toggleType() async {
    setState(() {
      _isSpotted = !_isSpotted;
    });
  }

  @override
  initState() {
    _isLoading = true;
    _isSpotted = true;
    _spottedMarkers = [];
    _missingMarkers = [];
    fetchAllMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Missing'),
                    Switch(value: _isSpotted, onChanged: (_) => _toggleType()),
                    const Text('Spotted'),
                  ],
                ),
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    mapType: MapType.normal,
                    compassEnabled: false,
                    mapToolbarEnabled: false,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(53.1688883, 8.6545086),
                      zoom: 15,
                    ),
                    markers: Set<Marker>.from(
                        _isSpotted ? _spottedMarkers : _missingMarkers),
                  ),
                ),
              ],
            ),
    );
  }
}
