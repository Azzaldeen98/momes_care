# moms_care

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# 	Bottoms Navigation Bar Libraries
    `motion_tab_bar`
    `awesome_bottom_bar`
    `floating_bottom_bar`
    `curved_navigation_bar`



[//]: # (لمعالجة التحذيرات والأخطاء المتعلقة بحجم العناصر التي تتجاوز المساحة المحددة لها في Flutter، يمكنك اتباع عدة استراتيجيات لضمان أن العناصر تتكيف بشكل صحيح مع المساحة المتاحة. فيما يلي بعض الطرق الشائعة لمعالجة هذه المشكلة:)

[//]: # ()
[//]: # (### 1. استخدام `Flexible` و `Expanded`)

[//]: # (تأكد من استخدام `Flexible` و `Expanded` بشكل صحيح لضمان أن العناصر تتكيف مع المساحة المتاحة بدلاً من تجاوزها.)

[//]: # ()
[//]: # (```dart)

[//]: # (Column&#40;)

[//]: # (  children: [)

[//]: # (    Expanded&#40;)

[//]: # (      child: Container&#40;)

[//]: # (        color: Colors.red,)

[//]: # (        child: Text&#40;)

[//]: # (          'This is some text',)

[//]: # (          style: TextStyle&#40;color: Colors.white&#41;,)

[//]: # (        &#41;,)

[//]: # (      &#41;,)

[//]: # (    &#41;,)

[//]: # (    Expanded&#40;)

[//]: # (      child: Container&#40;)

[//]: # (        color: Colors.green,)

[//]: # (        child: Text&#40;)

[//]: # (          'This is more text',)

[//]: # (          style: TextStyle&#40;color: Colors.white&#41;,)

[//]: # (        &#41;,)

[//]: # (      &#41;,)

[//]: # (    &#41;,)

[//]: # (  ],)

[//]: # (&#41;;)

[//]: # (```)

[//]: # ()
[//]: # (### 2. استخدام `SingleChildScrollView`)

[//]: # (إذا كان لديك محتوى يمكن أن يتجاوز حجم الشاشة، يمكنك وضع هذا المحتوى داخل `SingleChildScrollView` للسماح بالتمرير.)

[//]: # ()
[//]: # (```dart)

[//]: # (SingleChildScrollView&#40;)

[//]: # (  child: Column&#40;)

[//]: # (    children: [)

[//]: # (      Container&#40;)

[//]: # (        height: 500,)

[//]: # (        color: Colors.red,)

[//]: # (      &#41;,)

[//]: # (      Container&#40;)

[//]: # (        height: 500,)

[//]: # (        color: Colors.green,)

[//]: # (      &#41;,)

[//]: # (      Container&#40;)

[//]: # (        height: 500,)

[//]: # (        color: Colors.blue,)

[//]: # (      &#41;,)

[//]: # (    ],)

[//]: # (  &#41;,)

[//]: # (&#41;;)

[//]: # (```)

[//]: # ()
[//]: # (### 3. استخدام `Wrap` لعناصر متعددة في صف أو عمود)

[//]: # (إذا كان لديك عناصر متعددة في صف أو عمود قد تتجاوز المساحة المتاحة، يمكنك استخدام `Wrap` بدلاً من `Row` أو `Column`.)

[//]: # ()
[//]: # (```dart)

[//]: # (Wrap&#40;)

[//]: # (  children: [)

[//]: # (    Container&#40;)

[//]: # (      width: 100,)

[//]: # (      height: 100,)

[//]: # (      color: Colors.red,)

[//]: # (    &#41;,)

[//]: # (    Container&#40;)

[//]: # (      width: 100,)

[//]: # (      height: 100,)

[//]: # (      color: Colors.green,)

[//]: # (    &#41;,)

[//]: # (    Container&#40;)

[//]: # (      width: 100,)

[//]: # (      height: 100,)

[//]: # (      color: Colors.blue,)

[//]: # (    &#41;,)

[//]: # (  ],)

[//]: # (&#41;;)

[//]: # (```)

[//]: # ()
[//]: # (### 4. استخدام `FittedBox` لتعديل حجم الطفل)

[//]: # (استخدام `FittedBox` لضمان أن الطفل يتناسب مع المساحة المتاحة له.)

[//]: # ()
[//]: # (```dart)

[//]: # (Container&#40;)

[//]: # (  width: 100,)

[//]: # (  height: 100,)

[//]: # (  color: Colors.red,)

[//]: # (  child: FittedBox&#40;)

[//]: # (    child: Text&#40;)

[//]: # (      'This is some long text that will fit inside the container',)

[//]: # (      style: TextStyle&#40;color: Colors.white&#41;,)

[//]: # (    &#41;,)

[//]: # (  &#41;,)

[//]: # (&#41;;)

[//]: # (```)

[//]: # ()
[//]: # (### 5. التأكد من عدم وجود حجم ثابت كبير جدًا)

[//]: # (تأكد من أن الحجم الثابت المحدد للعناصر ليس كبيرًا جدًا بالنسبة للمساحة المتاحة. استخدم الوحدات المرنة بدلاً من الوحدات الثابتة كلما كان ذلك ممكنًا.)

[//]: # ()
[//]: # (```dart)

[//]: # (Container&#40;)

[//]: # (  width: MediaQuery.of&#40;context&#41;.size.width * 0.8, // 80% من عرض الشاشة)

[//]: # (  height: MediaQuery.of&#40;context&#41;.size.height * 0.2, // 20% من ارتفاع الشاشة)

[//]: # (  color: Colors.red,)

[//]: # (&#41;;)

[//]: # (```)

[//]: # ()
[//]: # (### 6. استخدام `LayoutBuilder` للحصول على القياسات الديناميكية)

[//]: # (استخدام `LayoutBuilder` لتحديد حجم العنصر بناءً على المساحة المتاحة.)

[//]: # ()
[//]: # (```dart)

[//]: # (LayoutBuilder&#40;)

[//]: # (  builder: &#40;context, constraints&#41; {)

[//]: # (    return Container&#40;)

[//]: # (      width: constraints.maxWidth * 0.8, // 80% من العرض المتاح)

[//]: # (      height: constraints.maxHeight * 0.2, // 20% من الارتفاع المتاح)

[//]: # (      color: Colors.red,)

[//]: # (    &#41;;)

[//]: # (  },)

[//]: # (&#41;;)

[//]: # (```)

[//]: # ()
[//]: # (### 7. تجنب وضع `Expanded` داخل عناصر غير مرنة مباشرة)

[//]: # (تأكد من أن `Expanded` أو `Flexible` توضع داخل عناصر مرنة مثل `Column` أو `Row`.)

[//]: # ()
[//]: # (### 8. التحقق من الأخطاء في التصميم)

[//]: # (استخدم أدوات التصميم مثل Flutter Inspector للتأكد من أن التصميم الخاص بك لا يحتوي على أخطاء في التسلسل الهرمي للعناصر.)

[//]: # ()
[//]: # (### مثال شامل:)

[//]: # (```dart)

[//]: # (import 'package:flutter/material.dart';)

[//]: # ()
[//]: # (void main&#40;&#41; {)

[//]: # (  runApp&#40;MyApp&#40;&#41;&#41;;)

[//]: # (})

[//]: # ()
[//]: # (class MyApp extends StatelessWidget {)

[//]: # (  @override)

[//]: # (  Widget build&#40;BuildContext context&#41; {)

[//]: # (    return MaterialApp&#40;)

[//]: # (      home: Scaffold&#40;)

[//]: # (        appBar: AppBar&#40;)

[//]: # (          title: Text&#40;'Flutter Layout Example'&#41;,)

[//]: # (        &#41;,)

[//]: # (        body: SingleChildScrollView&#40;)

[//]: # (          child: Column&#40;)

[//]: # (            children: [)

[//]: # (              Container&#40;)

[//]: # (                height: 200,)

[//]: # (                color: Colors.red,)

[//]: # (                child: Center&#40;)

[//]: # (                  child: Text&#40;)

[//]: # (                    'This is some text',)

[//]: # (                    style: TextStyle&#40;color: Colors.white&#41;,)

[//]: # (                  &#41;,)

[//]: # (                &#41;,)

[//]: # (              &#41;,)

[//]: # (              Container&#40;)

[//]: # (                height: 200,)

[//]: # (                color: Colors.green,)

[//]: # (                child: Center&#40;)

[//]: # (                  child: Text&#40;)

[//]: # (                    'This is more text',)

[//]: # (                    style: TextStyle&#40;color: Colors.white&#41;,)

[//]: # (                  &#41;,)

[//]: # (                &#41;,)

[//]: # (              &#41;,)

[//]: # (              Container&#40;)

[//]: # (                height: 200,)

[//]: # (                color: Colors.blue,)

[//]: # (                child: Center&#40;)

[//]: # (                  child: Text&#40;)

[//]: # (                    'This is even more text',)

[//]: # (                    style: TextStyle&#40;color: Colors.white&#41;,)

[//]: # (                  &#41;,)

[//]: # (                &#41;,)

[//]: # (              &#41;,)

[//]: # (              Wrap&#40;)

[//]: # (                children: [)

[//]: # (                  Container&#40;)

[//]: # (                    width: 100,)

[//]: # (                    height: 100,)

[//]: # (                    color: Colors.orange,)

[//]: # (                  &#41;,)

[//]: # (                  Container&#40;)

[//]: # (                    width: 100,)

[//]: # (                    height: 100,)

[//]: # (                    color: Colors.purple,)

[//]: # (                  &#41;,)

[//]: # (                  Container&#40;)

[//]: # (                    width: 100,)

[//]: # (                    height: 100,)

[//]: # (                    color: Colors.teal,)

[//]: # (                  &#41;,)

[//]: # (                ],)

[//]: # (              &#41;,)

[//]: # (              LayoutBuilder&#40;)

[//]: # (                builder: &#40;context, constraints&#41; {)

[//]: # (                  return Container&#40;)

[//]: # (                    width: constraints.maxWidth * 0.8,)

[//]: # (                    height: constraints.maxHeight * 0.2,)

[//]: # (                    color: Colors.yellow,)

[//]: # (                  &#41;;)

[//]: # (                },)

[//]: # (              &#41;,)

[//]: # (            ],)

[//]: # (          &#41;,)

[//]: # (        &#41;,)

[//]: # (      &#41;,)

[//]: # (    &#41;;)

[//]: # (  })

[//]: # (})

[//]: # (```)

[//]: # ()
[//]: # (بهذه الطرق، يمكنك معالجة المشاكل المتعلقة بتجاوز حجم العناصر للمساحة المتاحة في واجهة المستخدم الخاصة بتطبيقك في Flutter بشكل فعال.)