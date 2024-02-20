class OwnProfile {
  late String userId;
  late String name;
  late String phoneNumber;
  late double totalAmountGet;
  late double totalAmountGive;
  late List<OtherUser>? otherUsers;

  OwnProfile(
      {required this.userId,
      required this.name,
      required this.phoneNumber,
      required this.totalAmountGet,
      required this.totalAmountGive,
      required this.otherUsers});

  OwnProfile.fromJson(Map<dynamic, dynamic> json)
      : this(
            userId: (json['userId'] as String),
            name: (json['name'] as String),
            phoneNumber: (json['phoneNumber'] as String),
            totalAmountGet: (json['totalAmountGet'] as num).toDouble(),
            totalAmountGive: (json['totalAmountGive'] as num).toDouble(),
            otherUsers: json['otherUsers'] == null
                ? []
                : (json['otherUsers'] as List<dynamic>)
                    .map((record) => OtherUser.fromJson(record))
                    .toList());

  static Map<String, dynamic> toJson(OwnProfile ownProfile) {
    return {
      'userId': ownProfile.userId,
      'name': ownProfile.name,
      'phoneNumber': ownProfile.phoneNumber,
      'totalAmountGet': ownProfile.totalAmountGet,
      'totalAmountGive': ownProfile.totalAmountGive,
      'otherUsers': ownProfile.otherUsers
    };
  }
}

class OtherUser {
  late String? userId;
  late String name;
  late String phoneNumber;
  late double totalAmountGet;
  late double totalAmountGive;
  late List<AmountHistory>? amountHistory;

  OtherUser(
      {required this.userId,
      required this.name,
      required this.phoneNumber,
      required this.totalAmountGive,
      required this.totalAmountGet,
      required this.amountHistory});

  OtherUser.fromJson(Map<dynamic, dynamic> json)
      : this(
            userId: (json['userId'] as String),
            name: (json['name'] as String),
            phoneNumber: (json['phoneNumber'] as String),
            totalAmountGet: (json['totalAmountGet'] as num).toDouble(),
            totalAmountGive: (json['totalAmountGive'] as num).toDouble(),
            amountHistory: json['amountHistory'] == null
                ? []
                : (json['amountHistory'] as List<dynamic>)
                    .map((record) => AmountHistory.fromJson(record))
                    .toList());

  static Map<String, dynamic> toJson(OtherUser otherUser) {
    return {
      'userId': otherUser.userId,
      'name': otherUser.name,
      'phoneNumber': otherUser.phoneNumber,
      'totalAmountGet': otherUser.totalAmountGet,
      'totalAmountGive': otherUser.totalAmountGive,
      'amountHistory': otherUser.amountHistory
    };
  }
}

class AmountHistory {
  late double amount;
  late bool isCredit;
  late String dateTime;
  late String description;

  AmountHistory(
      {required this.amount,
      required this.isCredit,
      required this.dateTime,
      required this.description});

  AmountHistory.fromJson(Map<dynamic, dynamic> json)
      : this(
          amount: (json['amount'] as num).toDouble(),
          isCredit: (json['isCredit'] as bool),
          dateTime: (json['dateTime'] as String),
          description: (json['description'] as String),
        );

  static Map<String, dynamic> toJson(AmountHistory amountHistory) {
    return {
      'amount': amountHistory.amount,
      'isCredit': amountHistory.isCredit,
      'dateTime': amountHistory.dateTime,
      'description': amountHistory.description,
    };
  }
}
