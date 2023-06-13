import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heart_attack_prediction/models/req_models/predicts_req_model.dart';
import 'package:heart_attack_prediction/models/res_models/predicts_res_model.dart';
import 'package:heart_attack_prediction/services/api_service.dart';
import 'package:heart_attack_prediction/uis/screens/predictions.dart';

class AppStateChangeNotifier extends ChangeNotifier {
  bool _isLoading = false;

  //getter
  bool get isLoading => _isLoading;

  //get predictions
  //INPUT: buildcontext and reqModel(which contains post request body data)
  //DO: do the api call get response, error handle if error occurs, if everythings good navigate to
  //preidctions screen(with response data)
  //RETURN: none|void
  void getPredicts(BuildContext cxt, PredictReqModel reqData) async {
    //make isLoading true to show the loading indicator in ui
    _isLoading = true;
    notifyListeners();
    try {
      final res = await ApiService.postRequest("/heart-attack/predictions",
          bodyJson: reqData.toJson());

      if (res == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      PredicResModel searchResultsRes =
          PredicResModel.fromJson(jsonDecode(res.body));

      if (searchResultsRes.isError) {
        if (cxt.mounted) {
          SnackBar snackBar = SnackBar(
            content: Text(searchResultsRes.msg),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(cxt).showSnackBar(snackBar);
        }
        _isLoading = false;
        notifyListeners();
        return;
      }

      _isLoading = false;
      notifyListeners();

      PredicResModelData? data = searchResultsRes.data;
      if (cxt.mounted) {
        Navigator.push(
            cxt, MaterialPageRoute(builder: (context) => Predictions(data)));
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("error: $e -------------------");
      SnackBar snackBar = const SnackBar(
        content: Text("Some error occured fetching results"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(cxt).showSnackBar(snackBar);
      return;
    }
  }
}
