import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:unit_testing_practical/src/core/services/dep_injection.dart';
import 'package:unit_testing_practical/src/features/get_news/cubit/news_cubit.dart';
import 'package:unit_testing_practical/src/features/get_news/ui/screens/get_news_screen.dart';

void main() {
  DepInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: BlocProvider(
        lazy: true,
        create: (context) => NewsCubit(),
        child: NewsScreen(),
      ),
    );
  }
}

class Counter {
  int count = 0;

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }
}
/*


#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

// تعريف الدالة لإزالة الحروف
string removeChars(const string& input) {
    string output = "";

    // تعريف الأرقام المسموح بها
    vector<char> integers = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

    // التكرار على كل حرف في النص المدخل
    for (char ch : input) {
        if (find(integers.begin(), integers.end(), ch) != integers.end() || ch == '-') {
            output += ch;
        }
    }

    return output;
}

int main() {
    // مثال على استخدام الدالة
    string input = "a1b2c-34d";
    string result = removeChars(input);

    cout << "Output: " << result << endl;

    return 0;
}

شرح التحويل:

1. تعريف الأرقام:

في Dart، استخدمت قائمة List<String>، وفي C++ استخدمنا vector<char> لتخزين الأرقام كعناصر.



2. التكرار:

في Dart استخدمت حلقة for مع الفهرس، وفي C++ استخدمنا حلقة for بنمط النطاق (range-based for loop) لسهولة القراءة.



3. التحقق من الحروف:

استخدمنا دالة find من مكتبة <algorithm> للتحقق مما إذا كان الحرف موجودًا في vector.



4. إضافة الحروف إلى الناتج:

في Dart، استخدمت += لإضافة الحروف إلى النص، وهو نفس ما فعلناه في C++.



5. التشغيل:

يمكن إدخال النص الذي تريد معالجته في متغير input، وستقوم الدالة removeChars بإرجاع النص بعد إزالة الحروف غير المرغوبة.




الناتج المتوقع:

إذا كان الإدخال:

"a1b2c-34d"

فالناتج سيكون:

"12-34"
 */
