import 'dart:convert';

PaymentModal paymentModalFromJson(String str) =>
    PaymentModal.fromJson(json.decode(str));

String paymentModalToJson(PaymentModal data) => json.encode(data.toJson());

class PaymentModal {
  PaymentModal({
    this.amount,
    this.whatFor,
    this.paidAt,
    this.mode,
  });

  String? amount;
  String? whatFor;
  DateTime? paidAt;
  String? mode;

  factory PaymentModal.fromJson(Map<String, dynamic> json) => PaymentModal(
        amount: json["amount"],
        whatFor: json["what_for"],
        paidAt: DateTime.parse(json["paid_at"]),
        mode: json["mode"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "what_for": whatFor,
        "paid_at": paidAt!.toIso8601String(),
        "mode": mode,
      };
}
