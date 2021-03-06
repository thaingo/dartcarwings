import 'package:intl/intl.dart';

class CarwingsStatsDaily {
  DateTime dateTime;
  String mileagePerKWh;
  String KWhPerMileage;
  String mileageLevel;
  String accelerationWh;
  String accelerationLevel;
  String regenerativeWh;
  String regenerativeLevel;
  String auxWh;
  String auxLevel;
  String electricCostScale;

  CarwingsStatsDaily(Map params) {
    var summary =
        params['DriveAnalysisBasicScreenResponsePersonalData']['DateSummary'];

    NumberFormat numberFormat = new NumberFormat('0.00');

    this.dateTime = new DateFormat('yyyy-MM-dd').parse(summary['TargetDate']);
    this.electricCostScale =
        params["DriveAnalysisBasicScreenResponsePersonalData"]
            ["ElectricCostScale"];
    // For some reason electricCostScale can vary from country to country
    if (electricCostScale == 'kWh/km') {
      this.KWhPerMileage =
          numberFormat.format(double.parse(summary['ElectricMileage'])) +
              ' kWh/km';
      this.mileagePerKWh =
          numberFormat.format(1 / double.parse(summary['ElectricMileage'])) +
              ' km/kWh';
    } else if (electricCostScale == 'km/kWh') {
      this.KWhPerMileage =
          numberFormat.format(1 / double.parse(summary['ElectricMileage'])) +
              ' kWh/km';
      this.mileagePerKWh =
          numberFormat.format(double.parse(summary['ElectricMileage'])) +
              ' km/kWh';
    } else if (electricCostScale == 'kWh/100km') {
      this.KWhPerMileage =
          numberFormat.format(double.parse(summary['ElectricMileage']) / 100) +
              ' kWh/km';
      this.mileagePerKWh = numberFormat
              .format(1 / (double.parse(summary['ElectricMileage']) / 100)) +
          ' km/kWh';
    } else if (electricCostScale == 'miles/kWh') {
      this.KWhPerMileage =
          numberFormat.format(1 / double.parse(summary['ElectricMileage'])) +
              ' kWh/mi';
      this.mileagePerKWh = numberFormat
          .format(double.parse(summary['ElectricMileage'])) +
          ' mi/kWh';
    } else {
      this.KWhPerMileage =
          numberFormat.format(double.parse(summary['ElectricMileage'])) +
              ' kWh/mi';
      this.mileagePerKWh =
          numberFormat.format((1 / double.parse(summary['ElectricMileage']))) +
              ' mi/kWh';
    }
    this.mileageLevel = summary['ElectricMileageLevel'] ?? "0";
    this.accelerationWh =
        numberFormat.format(double.parse(summary['PowerConsumptMoter'])) +
            ' Wh';
    this.accelerationLevel = summary['PowerConsumptMoterLevel'] ?? "0";
    this.regenerativeWh =
        numberFormat.format(double.parse(summary['PowerConsumptMinus'])) +
            ' Wh';
    this.regenerativeLevel = summary['PowerConsumptMinusLevel'] ?? "0";
    this.auxWh =
        numberFormat.format(double.parse(summary['PowerConsumptAUX'])) + ' Wh';
    this.auxLevel = summary['PowerConsumptAUXLevel'] ?? "0";
  }
}
