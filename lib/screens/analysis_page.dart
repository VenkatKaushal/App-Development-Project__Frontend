import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:app_frontend/required_nutrition.dart';
import 'package:app_frontend/global_data.dart';

class AnalysisPage extends StatefulWidget {
  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  RequiredNutritionData requiredNutritionData = RequiredNutritionData();
  UserData userData = UserData();

  @override
  void initState() {
    super.initState();

    if(userData.gender ==  'Male'){
      final age = userData.age!;
      final weight = userData.weight!;
      if (age > 0 && age <= 1) { 
        if (weight >= 0 && weight <= 10){
          requiredNutritionData.requiredProtein = 8;
          requiredNutritionData.requiredCalcium = 300;
          requiredNutritionData.requiredCarbohydrates = 100;
          requiredNutritionData.requiredFiber = 0;
          requiredNutritionData.requiredIron = 3;
          requiredNutritionData.requiredVitaminA = 350;
          requiredNutritionData.requiredVitaminD = 400;
          requiredNutritionData.requiredVitaminE = 5;
          requiredNutritionData.requiredvitaminB6 = 0.5;
          requiredNutritionData.requiredFat = 100;
        }
        else{
          requiredNutritionData.requiredProtein = 9;
          requiredNutritionData.requiredCalcium = 320;
          requiredNutritionData.requiredCarbohydrates = 110;
          requiredNutritionData.requiredFiber = 0;
          requiredNutritionData.requiredIron = 4;
          requiredNutritionData.requiredVitaminA = 370;
          requiredNutritionData.requiredVitaminD = 420;
          requiredNutritionData.requiredVitaminE = 5.5;
          requiredNutritionData.requiredvitaminB6 = 0.6;
          requiredNutritionData.requiredFat = 100;
        }
      } 
      else if (age > 1 && age <= 3) {
        if(weight<10){
          requiredNutritionData.requiredProtein = 8;
          requiredNutritionData.requiredCalcium = 300;
          requiredNutritionData.requiredCarbohydrates = 100;
          requiredNutritionData.requiredFiber = 0;
          requiredNutritionData.requiredIron = 3;
          requiredNutritionData.requiredVitaminA = 350;
          requiredNutritionData.requiredVitaminD = 400;
          requiredNutritionData.requiredVitaminE = 5;
          requiredNutritionData.requiredvitaminB6 = 0.5;
          requiredNutritionData.requiredFat = 250;
        }
        else if (weight >= 10 && weight <= 14) {
          requiredNutritionData.requiredProtein = 13;
          requiredNutritionData.requiredCalcium = 500;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 15;
          requiredNutritionData.requiredIron = 8;
          requiredNutritionData.requiredVitaminA = 390;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 6;
          requiredNutritionData.requiredvitaminB6 = 0.9;
          requiredNutritionData.requiredFat = 300;
        }else {
          requiredNutritionData.requiredProtein = 14;
          requiredNutritionData.requiredCalcium = 525;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 17;
          requiredNutritionData.requiredIron = 9;
          requiredNutritionData.requiredVitaminA = 400;
          requiredNutritionData.requiredVitaminD = 620;
          requiredNutritionData.requiredVitaminE = 7;
          requiredNutritionData.requiredvitaminB6 = 1;
          requiredNutritionData.requiredFat = 325;
        } 
      } 
      else if (age > 3 && age <= 7) {
        if (weight < 14) {
          requiredNutritionData.requiredProtein = 14;
          requiredNutritionData.requiredCalcium = 525;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 17;
          requiredNutritionData.requiredIron = 9;
          requiredNutritionData.requiredVitaminA = 400;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 7;
          requiredNutritionData.requiredvitaminB6 = 1;
          requiredNutritionData.requiredFat = 325;
        }
        else if (weight >= 14 && weight <= 19) {
          requiredNutritionData.requiredProtein = 16;
          requiredNutritionData.requiredCalcium = 550;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 20;
          requiredNutritionData.requiredIron = 11;
          requiredNutritionData.requiredVitaminA = 510;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 8;
          requiredNutritionData.requiredvitaminB6 = 1.2;
          requiredNutritionData.requiredFat = 350;
        } else {
          requiredNutritionData.requiredProtein = 19;
          requiredNutritionData.requiredCalcium = 600;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 23;
          requiredNutritionData.requiredIron = 13;
          requiredNutritionData.requiredVitaminA = 570;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 9;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 375;
        }
      } 
      else if (age > 7 && age <= 9) {
        if (weight < 19){
          requiredNutritionData.requiredProtein = 19;
          requiredNutritionData.requiredCalcium = 600;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 23;
          requiredNutritionData.requiredIron = 13;
          requiredNutritionData.requiredVitaminA = 570;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 9;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 375;
        }
        else if (weight >= 19 && weight <= 28) {
          requiredNutritionData.requiredProtein = 23;
          requiredNutritionData.requiredCalcium = 650;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 26;
          requiredNutritionData.requiredIron = 15;
          requiredNutritionData.requiredVitaminA = 630;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 1.5;
          requiredNutritionData.requiredFat = 375;
        } else {
          requiredNutritionData.requiredProtein = 27;
          requiredNutritionData.requiredCalcium = 750;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 30;
          requiredNutritionData.requiredIron = 15;
          requiredNutritionData.requiredVitaminA = 700;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 1.7;
          requiredNutritionData.requiredFat = 375;
        }
      } 
      else if (age > 9 && age <= 12) {
        if(weight < 28){
          requiredNutritionData.requiredProtein = 27;
          requiredNutritionData.requiredCalcium = 750;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 30;
          requiredNutritionData.requiredIron = 15;
          requiredNutritionData.requiredVitaminA = 700;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 1.7;
          requiredNutritionData.requiredFat = 380;
        }
        if (weight >= 28 && weight <= 35) {
          requiredNutritionData.requiredProtein = 32;
          requiredNutritionData.requiredCalcium = 850;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 33;
          requiredNutritionData.requiredIron = 16;
          requiredNutritionData.requiredVitaminA = 770;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 2.0;
          requiredNutritionData.requiredFat = 400;
        } else {
          requiredNutritionData.requiredProtein = 38;
          requiredNutritionData.requiredCalcium = 925;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 19;
          requiredNutritionData.requiredVitaminA = 850;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 2.3;
          requiredNutritionData.requiredFat = 420;
        }
      } 
      else if (age > 12 && age <= 15) {
        if(weight <= 35){
          requiredNutritionData.requiredProtein = 38;
          requiredNutritionData.requiredCalcium = 925;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 19;
          requiredNutritionData.requiredVitaminA = 850;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 2.3;
          requiredNutritionData.requiredFat = 450;
        }
        else if (weight >= 35 && weight <= 50) {
          requiredNutritionData.requiredProtein = 45;
          requiredNutritionData.requiredCalcium = 1000;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 43;
          requiredNutritionData.requiredIron = 22;
          requiredNutritionData.requiredVitaminA = 930;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 2.6;
          requiredNutritionData.requiredFat = 500;
        } else {
          requiredNutritionData.requiredProtein = 50;
          requiredNutritionData.requiredCalcium = 1025;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 45;
          requiredNutritionData.requiredIron = 24;
          requiredNutritionData.requiredVitaminA = 960;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 2.8;
          requiredNutritionData.requiredFat = 550;
        }
      } 
      else if (age > 15 && age <= 18) {
        if (weight < 50){
          requiredNutritionData.requiredProtein = 50;
          requiredNutritionData.requiredCalcium = 1025;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 45;
          requiredNutritionData.requiredIron = 24;
          requiredNutritionData.requiredVitaminA = 960;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 2.8;
          requiredNutritionData.requiredFat = 575;
        }
        else if (weight >= 50 && weight <= 65) {
          requiredNutritionData.requiredProtein = 55;
          requiredNutritionData.requiredCalcium = 1050;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 50;
          requiredNutritionData.requiredIron = 26;
          requiredNutritionData.requiredVitaminA = 1000;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.4;
          requiredNutritionData.requiredFat = 600;
        } else {
          requiredNutritionData.requiredProtein = 52;
          requiredNutritionData.requiredCalcium = 1075;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 26;
          requiredNutritionData.requiredVitaminA = 1025;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.5;
          requiredNutritionData.requiredFat = 620;
        }
      } 
      else if (age > 18 && age <= 30) {
        if(weight < 60){
          requiredNutritionData.requiredProtein = weight;
          requiredNutritionData.requiredCalcium = 1050;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 25;
          requiredNutritionData.requiredVitaminA = 1025;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.5;
          requiredNutritionData.requiredFat = 620;
        }
        if (weight >= 60 && weight <= 80) {
          requiredNutritionData.requiredProtein = weight;
          requiredNutritionData.requiredCalcium = 1075;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 27;
          requiredNutritionData.requiredVitaminA = 1100;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 620;
        } else {
          requiredNutritionData.requiredProtein = weight;
          requiredNutritionData.requiredCalcium = 1200;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 27;
          requiredNutritionData.requiredVitaminA = 1100;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 620;
        }
      }
      else if(age > 30 && age <= 50){
        if(weight<65){
          requiredNutritionData.requiredProtein = weight;
          requiredNutritionData.requiredCalcium = 1200;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 27;
          requiredNutritionData.requiredVitaminA = 1100;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 550;
        }
        else if (weight >= 65 && weight <= 90) {
          requiredNutritionData.requiredProtein = weight*0.8;
          requiredNutritionData.requiredCalcium = 1100;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 28;
          requiredNutritionData.requiredVitaminA = 1100;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 550;
        } else {
          requiredNutritionData.requiredProtein = weight*0.8;
          requiredNutritionData.requiredCalcium = 1100;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 27;
          requiredNutritionData.requiredVitaminA = 1100;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 575;
        }
      }
      else if(age > 50){
        if(weight<55){
          requiredNutritionData.requiredProtein = weight;
          requiredNutritionData.requiredCalcium = 1100;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 27;
          requiredNutritionData.requiredVitaminA = 1100;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 500;
        }
        else if (weight >= 55 && weight <= 75) {
          requiredNutritionData.requiredProtein = weight*0.8;
          requiredNutritionData.requiredCalcium = 1200;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 35;
          requiredNutritionData.requiredIron = 25;
          requiredNutritionData.requiredVitaminA = 1000;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 500;
        } else {
          requiredNutritionData.requiredProtein = weight*0.8;
          requiredNutritionData.requiredCalcium = 1200;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 35;
          requiredNutritionData.requiredIron = 25;
          requiredNutritionData.requiredVitaminA = 1000;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 500;
        }
      }
    }
    else{
      final age = userData.age!;
      final weight = userData.weight!;
      if (age > 0 && age <= 1) { 
        if (weight >= 0 && weight <= 10){
          requiredNutritionData.requiredProtein = 8;
          requiredNutritionData.requiredCalcium = 300;
          requiredNutritionData.requiredCarbohydrates = 100;
          requiredNutritionData.requiredFiber = 0;
          requiredNutritionData.requiredIron = 3;
          requiredNutritionData.requiredVitaminA = 350;
          requiredNutritionData.requiredVitaminD = 400;
          requiredNutritionData.requiredVitaminE = 5;
          requiredNutritionData.requiredvitaminB6 = 0.5;
          requiredNutritionData.requiredFat = 100;
        }
        else{
          requiredNutritionData.requiredProtein = 9;
          requiredNutritionData.requiredCalcium = 320;
          requiredNutritionData.requiredCarbohydrates = 110;
          requiredNutritionData.requiredFiber = 0;
          requiredNutritionData.requiredIron = 4;
          requiredNutritionData.requiredVitaminA = 370;
          requiredNutritionData.requiredVitaminD = 420;
          requiredNutritionData.requiredVitaminE = 5.5;
          requiredNutritionData.requiredvitaminB6 = 0.6;
          requiredNutritionData.requiredFat = 100;
        }
      } 
      else if (age > 1 && age <= 3) {
        if(weight<10){
          requiredNutritionData.requiredProtein = 8;
          requiredNutritionData.requiredCalcium = 300;
          requiredNutritionData.requiredCarbohydrates = 100;
          requiredNutritionData.requiredFiber = 0;
          requiredNutritionData.requiredIron = 3;
          requiredNutritionData.requiredVitaminA = 350;
          requiredNutritionData.requiredVitaminD = 400;
          requiredNutritionData.requiredVitaminE = 5;
          requiredNutritionData.requiredvitaminB6 = 0.5;
          requiredNutritionData.requiredFat = 250;
        }
        else if (weight >= 10 && weight <= 14) {
          requiredNutritionData.requiredProtein = 13;
          requiredNutritionData.requiredCalcium = 500;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 15;
          requiredNutritionData.requiredIron = 8;
          requiredNutritionData.requiredVitaminA = 390;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 6;
          requiredNutritionData.requiredvitaminB6 = 0.9;
          requiredNutritionData.requiredFat = 300;
        }else {
          requiredNutritionData.requiredProtein = 14;
          requiredNutritionData.requiredCalcium = 525;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 17;
          requiredNutritionData.requiredIron = 9;
          requiredNutritionData.requiredVitaminA = 400;
          requiredNutritionData.requiredVitaminD = 620;
          requiredNutritionData.requiredVitaminE = 7;
          requiredNutritionData.requiredvitaminB6 = 1;
          requiredNutritionData.requiredFat = 325;
        } 
      } 
      else if (age > 3 && age <= 7) {
        if (weight < 14) {
          requiredNutritionData.requiredProtein = 14;
          requiredNutritionData.requiredCalcium = 525;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 17;
          requiredNutritionData.requiredIron = 9;
          requiredNutritionData.requiredVitaminA = 400;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 7;
          requiredNutritionData.requiredvitaminB6 = 1;
          requiredNutritionData.requiredFat = 325;
        }
        else if (weight >= 14 && weight <= 19) {
          requiredNutritionData.requiredProtein = 16;
          requiredNutritionData.requiredCalcium = 550;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 20;
          requiredNutritionData.requiredIron = 11;
          requiredNutritionData.requiredVitaminA = 510;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 8;
          requiredNutritionData.requiredvitaminB6 = 1.2;
          requiredNutritionData.requiredFat = 350;
        } else {
          requiredNutritionData.requiredProtein = 19;
          requiredNutritionData.requiredCalcium = 600;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 23;
          requiredNutritionData.requiredIron = 13;
          requiredNutritionData.requiredVitaminA = 570;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 9;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 375;
        }
      } 
      else if (age > 7 && age <= 9) {
        if (weight < 19){
          requiredNutritionData.requiredProtein = 19;
          requiredNutritionData.requiredCalcium = 600;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 23;
          requiredNutritionData.requiredIron = 13;
          requiredNutritionData.requiredVitaminA = 570;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 9;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 375;
        }
        else if (weight >= 19 && weight <= 28) {
          requiredNutritionData.requiredProtein = 23;
          requiredNutritionData.requiredCalcium = 650;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 26;
          requiredNutritionData.requiredIron = 15;
          requiredNutritionData.requiredVitaminA = 630;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 1.5;
          requiredNutritionData.requiredFat = 375;
        } else {
          requiredNutritionData.requiredProtein = 27;
          requiredNutritionData.requiredCalcium = 750;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 28;
          requiredNutritionData.requiredIron = 15;
          requiredNutritionData.requiredVitaminA = 700;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 1.7;
          requiredNutritionData.requiredFat = 375;
        }
      } 
      else if (age > 9 && age <= 12) {
        if(weight < 28){
          requiredNutritionData.requiredProtein = 27;
          requiredNutritionData.requiredCalcium = 750;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 28;
          requiredNutritionData.requiredIron = 15;
          requiredNutritionData.requiredVitaminA = 700;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 1.7;
          requiredNutritionData.requiredFat = 380;
        }
        if (weight >= 28 && weight <= 36) {
          requiredNutritionData.requiredProtein = 33;
          requiredNutritionData.requiredCalcium = 850;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 30;
          requiredNutritionData.requiredIron = 28;
          requiredNutritionData.requiredVitaminA = 790;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 1.9;
          requiredNutritionData.requiredFat = 400;
        } else {
          requiredNutritionData.requiredProtein = 38;
          requiredNutritionData.requiredCalcium = 925;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 33;
          requiredNutritionData.requiredIron = 29;
          requiredNutritionData.requiredVitaminA = 845;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 2.1;
          requiredNutritionData.requiredFat = 420;
        }
      } 
      else if (age > 12 && age <= 15) {
        if(weight <= 35){
          requiredNutritionData.requiredProtein = 38;
          requiredNutritionData.requiredCalcium = 925;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 33;
          requiredNutritionData.requiredIron = 29;
          requiredNutritionData.requiredVitaminA = 845;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 2.1;
          requiredNutritionData.requiredFat = 420;
        }
        else if (weight >= 35 && weight <= 50) {
          requiredNutritionData.requiredProtein = 43;
          requiredNutritionData.requiredCalcium = 1000;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 36;
          requiredNutritionData.requiredIron = 30;
          requiredNutritionData.requiredVitaminA = 890;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 2.2;
          requiredNutritionData.requiredFat = 500;
        } else {
          requiredNutritionData.requiredProtein = 44.5;
          requiredNutritionData.requiredCalcium = 1025;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 37;
          requiredNutritionData.requiredIron = 31;
          requiredNutritionData.requiredVitaminA = 875;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 2.25;
          requiredNutritionData.requiredFat = 525;
        }
      } 
      else if (age > 15 && age <= 18) {
        if (weight < 46){
          requiredNutritionData.requiredProtein = 44.5;
          requiredNutritionData.requiredCalcium = 1025;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 37;
          requiredNutritionData.requiredIron = 31;
          requiredNutritionData.requiredVitaminA = 875;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 11;
          requiredNutritionData.requiredvitaminB6 = 2.25;
          requiredNutritionData.requiredFat = 525;
        }
        else if (weight >= 46 && weight <= 55) {
          requiredNutritionData.requiredProtein = 46;
          requiredNutritionData.requiredCalcium = 1050;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 32;
          requiredNutritionData.requiredVitaminA = 860;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 2.3;
          requiredNutritionData.requiredFat = 550;
        } else {
          requiredNutritionData.requiredProtein = 47;
          requiredNutritionData.requiredCalcium = 1075;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 32;
          requiredNutritionData.requiredVitaminA = 840;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 2.3;
          requiredNutritionData.requiredFat = 600;
        }
      } 
      else if (age > 18 && age <= 30) {
        if(weight < 45){
          requiredNutritionData.requiredProtein = weight*0.9;
          requiredNutritionData.requiredCalcium = 1100;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 32;
          requiredNutritionData.requiredVitaminA = 840;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 2.3;
          requiredNutritionData.requiredFat = 450;
        }
        if (weight >= 45 && weight <= 70) {
          requiredNutritionData.requiredProtein = weight*0.9;
          requiredNutritionData.requiredCalcium = 1100;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 33;
          requiredNutritionData.requiredVitaminA = 840;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 2.3;
          requiredNutritionData.requiredFat = 450;
        } else {
          requiredNutritionData.requiredProtein = weight*0.9;
          requiredNutritionData.requiredCalcium = 1100;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 31;
          requiredNutritionData.requiredVitaminA = 850;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 2.3;
          requiredNutritionData.requiredFat = 450;
        }
      }
      else if(age > 30 && age <= 50){
        if(weight<50){
          requiredNutritionData.requiredProtein = weight*0.85;
          requiredNutritionData.requiredCalcium = 1300;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 30;
          requiredNutritionData.requiredVitaminA = 800;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 2.0;
          requiredNutritionData.requiredFat = 450;
        }
        else if (weight >= 50 && weight <= 80) {
          requiredNutritionData.requiredProtein = weight*0.85;
          requiredNutritionData.requiredCalcium = 1300;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 30;
          requiredNutritionData.requiredVitaminA = 800;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 2.0;
          requiredNutritionData.requiredFat = 450;
        } else {
          requiredNutritionData.requiredProtein = weight*0.85;
          requiredNutritionData.requiredCalcium = 1300;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 29;
          requiredNutritionData.requiredVitaminA = 800;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 2.0;
          requiredNutritionData.requiredFat = 450;
        }
      }
      else if(age > 50){
        if(weight<55){
          requiredNutritionData.requiredProtein = weight*0.8;
          requiredNutritionData.requiredCalcium = 1100;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 38;
          requiredNutritionData.requiredIron = 18;
          requiredNutritionData.requiredVitaminA = 750;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 500;
        }
        else if (weight >= 55 && weight <= 85) {
          requiredNutritionData.requiredProtein = weight*0.8;
          requiredNutritionData.requiredCalcium = 1200;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 35;
          requiredNutritionData.requiredIron = 20;
          requiredNutritionData.requiredVitaminA = 750;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 500;
        } else {
          requiredNutritionData.requiredProtein = weight*0.8;
          requiredNutritionData.requiredCalcium = 1200;
          requiredNutritionData.requiredCarbohydrates = 130;
          requiredNutritionData.requiredFiber = 35;
          requiredNutritionData.requiredIron = 22;
          requiredNutritionData.requiredVitaminA = 775;
          requiredNutritionData.requiredVitaminD = 600;
          requiredNutritionData.requiredVitaminE = 15;
          requiredNutritionData.requiredvitaminB6 = 1.3;
          requiredNutritionData.requiredFat = 500;
        }
      }
    }

    requiredNutritionData.requiredTotalNutrition = (requiredNutritionData.requiredProtein ?? 0) * 4 +
                         (requiredNutritionData.requiredCarbohydrates ?? 0) * 4 +
                         (requiredNutritionData.requiredFat ?? 0) +
                         (requiredNutritionData.requiredCalcium ?? 0) / 10 +
                         (requiredNutritionData.requiredIron ?? 0) / 10 +
                         (requiredNutritionData.requiredVitaminA ?? 0) / 100 +
                         (requiredNutritionData.requiredvitaminB6 ?? 0) * 10 +
                         (requiredNutritionData.requiredVitaminD ?? 0) / 10 +
                         (requiredNutritionData.requiredFiber ?? 0) * 2;
  }

  @override
Widget build(BuildContext context) {
  // Access data from singleton instances
  final List<FlSpot> spots = [
    FlSpot(0, requiredNutritionData.requiredTotalNutrition ?? 0),
    FlSpot(1, (requiredNutritionData.requiredTotalNutrition ?? 0) + 10),  // Example variation
    FlSpot(2, (requiredNutritionData.requiredTotalNutrition ?? 0) + 20),  // Example variation
    FlSpot(3, (requiredNutritionData.requiredTotalNutrition ?? 0) + 30),  // Example variation
    FlSpot(4, (requiredNutritionData.requiredTotalNutrition ?? 0) + 40),  // Example variation
    FlSpot(5, (requiredNutritionData.requiredTotalNutrition ?? 0) + 50),  // Example variation
    FlSpot(6, (requiredNutritionData.requiredTotalNutrition ?? 0) + 60),  // Example variation
  ];

  final List<String> deficitNutrients = [
    'Protein',
    'Fat',
    'Calcium',
    'Iron',
  ];

  return Scaffold(
    appBar: AppBar(
      title: Text('Analysis Page'),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Line Graph Section
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: 6, // Adjust to match number of data points
                  minY: 0,
                  maxY: (requiredNutritionData.requiredTotalNutrition ?? 0) + 1300, // Adjust based on max value
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: true),  // Show plot points
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Data Card Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildHeaderCell('Nutrient'),
                        buildHeaderCell('Required'),
                        buildHeaderCell('Yours'),
                        buildHeaderCell('Deficit'),
                      ],
                    ),
                    Divider(),
                    // Data Rows
                    buildDataRow('Calories', '500 IU', '5000 IU', '4500 IU'),
                    buildDataRow('Protein', '${requiredNutritionData.requiredProtein ?? 0}g', '40g', '20g'),
                    buildDataRow('Carbs', '${requiredNutritionData.requiredCarbohydrates ?? 0}g', '200g', '100g'),
                    buildDataRow('Fat', '${requiredNutritionData.requiredFat ?? 0}kcal', '70g', '55g'),
                    buildDataRow('Fiber', '${requiredNutritionData.requiredFiber ?? 0}g', '30g', '25g'),
                    buildDataRow('Calcium', '${requiredNutritionData.requiredCalcium ?? 0}mg', '1000mg', '700mg'),
                    buildDataRow('Iron', '${requiredNutritionData.requiredIron ?? 0}mg', '18mg', '14mg'),
                    buildDataRow('Vitamin A', '${requiredNutritionData.requiredVitaminA ?? 0} microg', '5000 IU', '4500 IU'),
                    buildDataRow('Vitamin B6', '${requiredNutritionData.requiredvitaminB6 ?? 0} mg', '5000 IU', '4500 IU'),
                    buildDataRow('Vitamin D', '${requiredNutritionData.requiredVitaminD ?? 0} IU', '5000 IU', '4500 IU'),
                    buildDataRow('Vitamin E', '${requiredNutritionData.requiredVitaminE ?? 0} microg', '5000 IU', '4500 IU'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Suggestions Card Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Suggestions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Displaying bullet points for each nutrient in deficit
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: deficitNutrients.map((nutrient) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "• ",
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Consider increasing your intake of $nutrient-rich foods.',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget buildHeaderCell(String title) {
    return Expanded(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildDataRow(String name, String yours, String required, String deficit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              yours,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              required,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              deficit,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.redAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}