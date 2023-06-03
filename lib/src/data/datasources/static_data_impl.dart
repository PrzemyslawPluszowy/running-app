import 'package:new_app/src/data/datasources/static_data.dart';

class StaticDataImpl implements StaticData {
  @override
  int calculateSimpleHrmax({required int age}) {
    int hrMax = ((202.0 - 0.53 * age.toDouble()).roundToDouble()).toInt();
    return hrMax;
  }

  @override
  double calculateBmi({required int weight, required int height}) {
    double bmi = double.parse((weight / (height * height)).toStringAsFixed(1));
    return bmi;
  }
}

class Helper {}
