// ignore_for_file: constant_identifier_names
import '../../utils/function/choose_name_langauge.dart';

enum OrderStatus {
  All(label: "", arabicLabel: ""),
  New(label: "New", arabicLabel: "جديد"),
  Accept(label: "Accept", arabicLabel: "مقبول"),
  Enject(label: "Enject", arabicLabel: "مرفوض"),
  Ready(label: "Ready", arabicLabel: "جاهز"),
  Cancel(label: "Cancel", arabicLabel: "ملغي");

  final String label;
  final String arabicLabel;
  const OrderStatus({required this.label, required this.arabicLabel});
}

extension OrderStatusX on String? {
  OrderStatus toOrderStatus() {
    return switch (this) {
      "All" => OrderStatus.All,
      "New" => OrderStatus.New,
      "Accept" => OrderStatus.Accept,
      "Enject" => OrderStatus.Enject,
      "Ready" => OrderStatus.Ready,
      "Cancel" => OrderStatus.Cancel,
      _ => OrderStatus.All,
    };
  }

  String toNameOrderStatusS() {
    return switch (this) {
      "All" => "",
      "New" => chooseLableLanguage(
          englishLable: OrderStatus.New.label,
          arabicLable: OrderStatus.New.arabicLabel),
      "Accept" => chooseLableLanguage(
          englishLable: OrderStatus.Accept.label,
          arabicLable: OrderStatus.Accept.arabicLabel),
      "Enject" => chooseLableLanguage(
          englishLable: OrderStatus.Enject.label,
          arabicLable: OrderStatus.Enject.arabicLabel),
      "Ready" => chooseLableLanguage(
          englishLable: OrderStatus.Ready.label,
          arabicLable: OrderStatus.Ready.arabicLabel),
      "Cancel" => chooseLableLanguage(
          englishLable: OrderStatus.Cancel.label,
          arabicLable: OrderStatus.Cancel.arabicLabel),
      _ => "--",
    };
  }
}

extension OrderStatuseX on int? {
  OrderStatus toOrderStatus() {
    int index = this ?? 0;
    return OrderStatus.values[index];
  }

  String toNameOrderStatus() {
    print(this);
    return switch (this) {
      0 => "",
      1 => chooseLableLanguage(
          englishLable: OrderStatus.New.label,
          arabicLable: OrderStatus.New.arabicLabel),
      2 => chooseLableLanguage(
          englishLable: OrderStatus.Accept.label,
          arabicLable: OrderStatus.Accept.arabicLabel),
      3 => chooseLableLanguage(
          englishLable: OrderStatus.Enject.label,
          arabicLable: OrderStatus.Enject.arabicLabel),
      4 => chooseLableLanguage(
          englishLable: OrderStatus.Ready.label,
          arabicLable: OrderStatus.Ready.arabicLabel),
      5 => chooseLableLanguage(
          englishLable: OrderStatus.Cancel.label,
          arabicLable: OrderStatus.Cancel.arabicLabel),
      _ => "--",
    };
  }
}
