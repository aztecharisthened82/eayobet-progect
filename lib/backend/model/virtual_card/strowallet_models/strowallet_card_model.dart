class StrowalletCardModel {
  Message message;
  Data data;

  StrowalletCardModel({
    required this.message,
    required this.data,
  });

  factory StrowalletCardModel.fromJson(Map<String, dynamic> json) =>
      StrowalletCardModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  String baseCurr;
  int baseCurrRate;
  GetRemainingFields getRemainingFields;
  List<SupportedCurrency> supportedCurrency;
  bool cardCreateAction;
  bool strowalletCustomerInfo;
  CardBasicInfo cardBasicInfo;
  List<MyCard> myCards;
  User user;
  List<UserWallet> userWallet;
  CardCharge cardCharge;
  List<dynamic> transactions;

  Data({
    required this.baseCurr,
    required this.baseCurrRate,
    required this.getRemainingFields,
    required this.supportedCurrency,
    required this.cardCreateAction,
    required this.strowalletCustomerInfo,
    required this.cardBasicInfo,
    required this.myCards,
    required this.user,
    required this.userWallet,
    required this.cardCharge,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        baseCurr: json["base_curr"],
        baseCurrRate: json["base_curr_rate"],
        getRemainingFields:
            GetRemainingFields.fromJson(json["get_remaining_fields"]),
        supportedCurrency: List<SupportedCurrency>.from(
            json["supported_currency"]
                .map((x) => SupportedCurrency.fromJson(x))),
        cardCreateAction: json["card_create_action"],
        strowalletCustomerInfo: json["strowallet_customer_info"],
        cardBasicInfo: CardBasicInfo.fromJson(json["card_basic_info"]),
        myCards:
            List<MyCard>.from(json["myCards"].map((x) => MyCard.fromJson(x))),
        user: User.fromJson(json["user"]),
        userWallet: List<UserWallet>.from(
            json["userWallet"].map((x) => UserWallet.fromJson(x))),
        cardCharge: CardCharge.fromJson(json["cardCharge"]),
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "base_curr": baseCurr,
        "base_curr_rate": baseCurrRate,
        "get_remaining_fields": getRemainingFields.toJson(),
        "supported_currency":
            List<dynamic>.from(supportedCurrency.map((x) => x.toJson())),
        "card_create_action": cardCreateAction,
        "strowallet_customer_info": strowalletCustomerInfo,
        "card_basic_info": cardBasicInfo.toJson(),
        "myCards": List<dynamic>.from(myCards.map((x) => x.toJson())),
        "user": user.toJson(),
        "userWallet": List<dynamic>.from(userWallet.map((x) => x.toJson())),
        "cardCharge": cardCharge.toJson(),
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
      };
}

class MyCard {
  int id;
  String name;
  String cardNumber;
  String cardId;
  String expiry;
  String cvv;
  int balance;
  String cardStatus;
  String cardBackDetails;
  String siteTitle;
  String siteLogo;
  String siteFav;
  bool status;
  bool isDefault;
  MyCardStatusInfo statusInfo;

  MyCard({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.cardId,
    required this.expiry,
    required this.cvv,
    required this.balance,
    required this.cardStatus,
    required this.cardBackDetails,
    required this.siteTitle,
    required this.siteLogo,
    required this.siteFav,
    required this.status,
    required this.isDefault,
    required this.statusInfo,
  });

  factory MyCard.fromJson(Map<String, dynamic> json) => MyCard(
        id: json["id"],
        name: json["name"],
        cardNumber: json["card_number"],
        cardId: json["card_id"],
        expiry: json["expiry"],
        cvv: json["cvv"],
        balance: json["balance"],
        cardStatus: json["card_status"],
        cardBackDetails: json["card_back_details"],
        siteTitle: json["site_title"],
        siteLogo: json["site_logo"],
        siteFav: json["site_fav"],
        status: json["status"],
        isDefault: json["is_default"],
        statusInfo: MyCardStatusInfo.fromJson(json["status_info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "card_number": cardNumber,
        "card_id": cardId,
        "expiry": expiry,
        "cvv": cvv,
        "balance": balance,
        "card_status": cardStatus,
        "card_back_details": cardBackDetails,
        "site_title": siteTitle,
        "site_logo": siteLogo,
        "site_fav": siteFav,
        "status": status,
        "is_default": isDefault,
        "status_info": statusInfo.toJson(),
      };
}

class MyCardStatusInfo {
  int block;
  int unblock;

  MyCardStatusInfo({
    required this.block,
    required this.unblock,
  });

  factory MyCardStatusInfo.fromJson(Map<String, dynamic> json) =>
      MyCardStatusInfo(
        block: json["block"],
        unblock: json["unblock"],
      );

  Map<String, dynamic> toJson() => {
        "block": block,
        "unblock": unblock,
      };
}

class CardBasicInfo {
  int cardCreateLimit;
  String cardBackDetails;
  String cardBg;
  String siteTitle;
  String siteLogo;
  String siteFav;

  CardBasicInfo({
    required this.cardCreateLimit,
    required this.cardBackDetails,
    required this.cardBg,
    required this.siteTitle,
    required this.siteLogo,
    required this.siteFav,
  });

  factory CardBasicInfo.fromJson(Map<String, dynamic> json) => CardBasicInfo(
        cardCreateLimit: json["card_create_limit"],
        cardBackDetails: json["card_back_details"],
        cardBg: json["card_bg"],
        siteTitle: json["site_title"],
        siteLogo: json["site_logo"],
        siteFav: json["site_fav"],
      );

  Map<String, dynamic> toJson() => {
        "card_create_limit": cardCreateLimit,
        "card_back_details": cardBackDetails,
        "card_bg": cardBg,
        "site_title": siteTitle,
        "site_logo": siteLogo,
        "site_fav": siteFav,
      };
}

class CardCharge {
  int id;
  String slug;
  String title;
  int fixedCharge;
  int percentCharge;
  int minLimit;
  int maxLimit;
  int dailyLimit;
  int monthlyLimit;

  CardCharge({
    required this.id,
    required this.slug,
    required this.title,
    required this.fixedCharge,
    required this.percentCharge,
    required this.minLimit,
    required this.maxLimit,
    required this.dailyLimit,
    required this.monthlyLimit,
  });

  factory CardCharge.fromJson(Map<String, dynamic> json) => CardCharge(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        fixedCharge: json["fixed_charge"],
        percentCharge: json["percent_charge"],
        minLimit: json["min_limit"],
        maxLimit: json["max_limit"],
        dailyLimit: json["daily_limit"],
        monthlyLimit: json["monthly_limit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "fixed_charge": fixedCharge,
        "percent_charge": percentCharge,
        "min_limit": minLimit,
        "max_limit": maxLimit,
        "daily_limit": dailyLimit,
        "monthly_limit": monthlyLimit,
      };
}

class GetRemainingFields {
  String transactionType;
  String attribute;

  GetRemainingFields({
    required this.transactionType,
    required this.attribute,
  });

  factory GetRemainingFields.fromJson(Map<String, dynamic> json) =>
      GetRemainingFields(
        transactionType: json["transaction_type"],
        attribute: json["attribute"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_type": transactionType,
        "attribute": attribute,
      };
}

class SupportedCurrency {
  int id;
  String name;
  String mobileCode;
  String currencyName;
  String currencyCode;
  String currencySymbol;
  int rate;
  int status;

  SupportedCurrency({
    required this.id,
    required this.name,
    required this.mobileCode,
    required this.currencyName,
    required this.currencyCode,
    required this.currencySymbol,
    required this.rate,
    required this.status,
  });

  factory SupportedCurrency.fromJson(Map<String, dynamic> json) =>
      SupportedCurrency(
        id: json["id"],
        name: json["name"],
        mobileCode: json["mobile_code"],
        currencyName: json["currency_name"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
        rate: json["rate"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile_code": mobileCode,
        "currency_name": currencyName,
        "currency_code": currencyCode,
        "currency_symbol": currencySymbol,
        "rate": rate,
        "status": status,
      };
}

class User {
  int id;
  String firstname;
  String lastname;
  String username;
  String email;
  String? mobileCode;
  String mobile;
  String fullMobile;
  dynamic refferalUserId;
  dynamic image;
  int status;
  Address address;
  int emailVerified;
  int smsVerified;
  int kycVerified;
  dynamic verCode;
  dynamic verCodeSendAt;
  int twoFactorVerified;
  dynamic deviceId;
  dynamic emailVerifiedAt;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic sudoCustomer;
  dynamic sudoAccount;
  dynamic strowalletCustomer;
  dynamic stripeCardHolders;
  dynamic stripeConnectedAccount;
  int twoFactorStatus;
  dynamic twoFactorSecret;
  String fullname;
  String userImage;
  Status stringStatus;
  Status emailStatus;
  String lastLogin;
  Status kycStringStatus;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
     this.mobileCode,
    required this.mobile,
    required this.fullMobile,
    required this.refferalUserId,
    required this.image,
    required this.status,
    required this.address,
    required this.emailVerified,
    required this.smsVerified,
    required this.kycVerified,
    required this.verCode,
    required this.verCodeSendAt,
    required this.twoFactorVerified,
    required this.deviceId,
    required this.emailVerifiedAt,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.sudoCustomer,
    required this.sudoAccount,
    required this.strowalletCustomer,
    required this.stripeCardHolders,
    required this.stripeConnectedAccount,
    required this.twoFactorStatus,
    required this.twoFactorSecret,
    required this.fullname,
    required this.userImage,
    required this.stringStatus,
    required this.emailStatus,
    required this.lastLogin,
    required this.kycStringStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        mobileCode: json["mobile_code"] ?? '',
        mobile: json["mobile"],
        fullMobile: json["full_mobile"],
        refferalUserId: json["refferal_user_id"],
        image: json["image"],
        status: json["status"],
        address: Address.fromJson(json["address"]),
        emailVerified: json["email_verified"],
        smsVerified: json["sms_verified"],
        kycVerified: json["kyc_verified"],
        verCode: json["ver_code"],
        verCodeSendAt: json["ver_code_send_at"],
        twoFactorVerified: json["two_factor_verified"],
        deviceId: json["device_id"],
        emailVerifiedAt: json["email_verified_at"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sudoCustomer: json["sudo_customer"],
        sudoAccount: json["sudo_account"],
        strowalletCustomer: json["strowallet_customer"],
        stripeCardHolders: json["stripe_card_holders"],
        stripeConnectedAccount: json["stripe_connected_account"],
        twoFactorStatus: json["two_factor_status"],
        twoFactorSecret: json["two_factor_secret"],
        fullname: json["fullname"],
        userImage: json["userImage"],
        stringStatus: Status.fromJson(json["stringStatus"]),
        emailStatus: Status.fromJson(json["emailStatus"]),
        lastLogin: json["lastLogin"],
        kycStringStatus: Status.fromJson(json["kycStringStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "mobile_code": mobileCode ?? '',
        "mobile": mobile,
        "full_mobile": fullMobile,
        "refferal_user_id": refferalUserId,
        "image": image,
        "status": status,
        "address": address.toJson(),
        "email_verified": emailVerified,
        "sms_verified": smsVerified,
        "kyc_verified": kycVerified,
        "ver_code": verCode,
        "ver_code_send_at": verCodeSendAt,
        "two_factor_verified": twoFactorVerified,
        "device_id": deviceId,
        "email_verified_at": emailVerifiedAt,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sudo_customer": sudoCustomer,
        "sudo_account": sudoAccount,
        "strowallet_customer": strowalletCustomer,
        "stripe_card_holders": stripeCardHolders,
        "stripe_connected_account": stripeConnectedAccount,
        "two_factor_status": twoFactorStatus,
        "two_factor_secret": twoFactorSecret,
        "fullname": fullname,
        "userImage": userImage,
        "stringStatus": stringStatus.toJson(),
        "emailStatus": emailStatus.toJson(),
        "lastLogin": lastLogin,
        "kycStringStatus": kycStringStatus.toJson(),
      };
}

class Address {
  String country;
  String state;
  String city;
  String zip;
  String address;

  Address({
    required this.country,
    required this.state,
    required this.city,
    required this.zip,
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"],
        state: json["state"],
        city: json["city"],
        zip: json["zip"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "state": state,
        "city": city,
        "zip": zip,
        "address": address,
      };
}

class Status {
  String statusClass;
  String value;

  Status({
    required this.statusClass,
    required this.value,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        statusClass: json["class"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "class": statusClass,
        "value": value,
      };
}

class UserWallet {
  dynamic balance;
  int status;
  Currency currency;

  UserWallet({
    required this.balance,
    required this.status,
    required this.currency,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
        balance: json["balance"],
        status: json["status"],
        currency: Currency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "status": status,
        "currency": currency.toJson(),
      };
}

class Currency {
  String code;
  int rate;
  String flag;
  String symbol;
  String type;
  int currencyDefault;
  String country;
  String name;
  bool both;
  bool senderCurrency;
  bool receiverCurrency;

  Currency({
    required this.code,
    required this.rate,
    required this.flag,
    required this.symbol,
    required this.type,
    required this.currencyDefault,
    required this.country,
    required this.name,
    required this.both,
    required this.senderCurrency,
    required this.receiverCurrency,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        code: json["code"],
        rate: json["rate"],
        flag: json["flag"],
        symbol: json["symbol"],
        type: json["type"],
        currencyDefault: json["default"],
        country: json["country"],
        name: json["name"],
        both: json["both"],
        senderCurrency: json["senderCurrency"],
        receiverCurrency: json["receiverCurrency"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "rate": rate,
        "flag": flag,
        "symbol": symbol,
        "type": type,
        "default": currencyDefault,
        "country": country,
        "name": name,
        "both": both,
        "senderCurrency": senderCurrency,
        "receiverCurrency": receiverCurrency,
      };
}

class Message {
  List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
