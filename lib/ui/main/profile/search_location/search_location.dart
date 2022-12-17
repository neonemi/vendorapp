import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:location/location.dart';
import 'package:vendorapp/core/core.dart';


class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  late final SearchLocationCubit _cubit;
  final double latitudevalue=28.0325;
  final  double longitudevalue=73.3295;
  final zoomvalue = 16.0;
  @override
  void initState() {
    super.initState();
    getLocation();
  }
  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers={};
  void getLocation() async{
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc){

      _controller?.animateCamera(CameraUpdate.newCameraPosition( CameraPosition(
        target: LatLng(latitudevalue , longitudevalue),
        zoom:zoomvalue,
      )));
      if (kDebugMode) {
        print(loc.latitude);
      }//current latitude
      if (kDebugMode) {
        print(loc.longitude);
      }//current longitude
      // setState(() {
        _markers.add( Marker(markerId: const MarkerId(''),
            position: LatLng(latitudevalue , longitudevalue),infoWindow: const InfoWindow(
                title: ''
            )
        ));

      // });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchLocationCubit>(
      create: (context) {
        _cubit = SearchLocationCubit(context.read<CoreRepository>());

        return _cubit;
      },
      child: BlocListener<SearchLocationCubit, SearchLocationState>(
        listener: (context, state) {
          if (state is SearchLocationLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state is SearchLocationSuccess) {

          }
          if (state is SearchLocationError) {
            context.showToast(state.message);
          }
        },
        child:
        BlocBuilder<SearchLocationCubit,SearchLocationState>(builder: (context, state) {

            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.appRed,
                centerTitle: true,
                elevation: 0.0,
                iconTheme: IconThemeData(color: AppTheme.appWhite),
                title: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Search Location',
                    style: TextStyle(
                        color: AppTheme.appWhite,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body: SizedBox(
                height: 200,
                width: 200,
                child:
                GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  initialCameraPosition:  CameraPosition(
                    target: LatLng(latitudevalue , longitudevalue),
                    zoom:zoomvalue,
                  ),
                  onMapCreated: (GoogleMapController controller){
                    setState((){
                      _controller = controller;
                    });

                  },
                  minMaxZoomPreference: const MinMaxZoomPreference(13,20),
                  // gestureRecognizers: Set()
                  //   ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer())),
                  // onTap: (value){
                  //   _launchMapsUrl(value.latitude,value.longitude);
                  // },
                  markers: _markers,
                ) ,
              )

            );
        }),
      ),
    );
    //const Center(child: Text("profile",style: TextStyle(color: Colors.red),));
  }


}
