import 'package:flutter/material.dart';

import '../home/mock_data.dart';

class Util {
  static double finalAmountHistoryCalculate(
      List<CustomerAmount> customerAmount) {
    double finalAmount = 0.0;
    for (int i = 0; i < customerAmount.length; i++) {
      if (customerAmount[i].isCredit) {
        finalAmount -= customerAmount[i].amount;
      } else {
        finalAmount += customerAmount[i].amount;
      }
    }
    return finalAmount;
  }

  static double finalCustomerAmountCalculate(List<Customer> customerAmount) {
    double finalAmount = 0.0;
    for (int i = 0; i < customerAmount.length; i++) {
      if (customerAmount[i].finalAmount > 0) {
        finalAmount += customerAmount[i].finalAmount;
      } else {
        finalAmount -= customerAmount[i].finalAmount;
      }
    }
    return finalAmount;
  }

  static double finalAmountCalculateGet(List<Customer> customerAmount) {
    double finalAmount = 0.0;
    for (int i = 0; i < customerAmount.length; i++) {
      if (customerAmount[i].finalAmount > 0) {
        finalAmount += customerAmount[i].finalAmount;
      }
    }
    return finalAmount;
  }

  static double finalAmountCalculateGive(List<Customer> customerAmount) {
    double finalAmount = 0.0;
    for (int i = 0; i < customerAmount.length; i++) {
      if (customerAmount[i].finalAmount < 0) {
        finalAmount -= customerAmount[i].finalAmount;
      }
    }
    return finalAmount;
  }

  static String dateSelection(DateTime dateTime) {
    //days calculations
    int day = dateTime.day;
    String resultDay = "";
    if (day < 10) {
      resultDay = "0$day";
    } else {
      resultDay = day.toString();
    }

    //months calculations
    int month = dateTime.month;
    String resultMonth = "";
    if (month < 10) {
      resultMonth = "0$month";
    } else {
      resultMonth = month.toString();
    }

    return "$resultDay-$resultMonth-${dateTime.year}";
  }

  static String timeSelection(TimeOfDay dateTime) {
    String amPm = "AM";
    int hours = dateTime.hour;

    if (hours > 11) {
      amPm = "PM";
      hours = 24 - hours;
    } else {
      amPm = "AM";
    }

    String resultHours = "";
    if (hours < 10) {
      resultHours = "0$hours";
    } else {
      resultHours = hours.toString();
    }

    int minute = dateTime.minute;
    String resultMinutes = "";
    if (minute < 10) {
      resultMinutes = "0$minute";
    } else {
      resultMinutes = minute.toString();
    }

    return "$resultHours:$resultMinutes $amPm";
  }
}
