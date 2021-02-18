import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sultan_pizza/bloc/order/order_bloc.dart';
import 'package:sultan_pizza/config/constants.dart';

class MapLocation extends StatefulWidget {
  @override
  _MapLocationState createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  GoogleMapController googleMapController;

  final CameraPosition _initial_position =
      CameraPosition(target: LatLng(24.903623, 67.198367));
  List<Marker> marker = List<Marker>();
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<OrderBloc>(context, listen: true);
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) {
                bloc.finalAddress = value;
              },
              style: TextStyle(color: Colors.black, fontSize: 17.0),
              textAlign: TextAlign.end,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: kSecondColor,
                ),
                hintText: 'أدخل عنوانك بالتفصيل',
                alignLabelWithHint: true,
                hintStyle:
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  borderSide: BorderSide(color: kSecondColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  borderSide: BorderSide(color: kSecondColor, width: 1.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'أو',
              style: TextStyle(
                  fontFamily: 'Tajwal',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
          ),
          Expanded(
            child: GoogleMap(
              markers: marker.toSet(),
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              mapToolbarEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: _initial_position,
              mapType: MapType.normal,
              onMapCreated: (controller) {
                setState(() {
                  googleMapController = controller;
                  BlocProvider.of<OrderBloc>(context).marker == null
                      ? marker = []
                      : marker.add(BlocProvider.of<OrderBloc>(context).marker);
                  googleMapController.animateCamera(
                      CameraUpdate.newLatLng(marker[0].position));
                });
              },
              onTap: (coordinate) {
                setState(() {
                  googleMapController
                      .animateCamera(CameraUpdate.newLatLng(coordinate));
                  marker = [];
                  marker.add(Marker(
                      markerId: MarkerId(coordinate.toString()),
                      position: coordinate));
                  bloc.add(SendMarker(marker[0]));
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              ' رجاء حدد مكان التوصيل عبر الخريطه',
              style: TextStyle(
                  fontFamily: 'Tajwal',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
