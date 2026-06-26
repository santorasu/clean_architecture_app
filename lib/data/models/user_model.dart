class UserModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Data>? data;
  Support? support;
  Meta? mMeta;

  UserModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
    this.mMeta,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    support = json['support'] != null
        ? Support.fromJson(json['support'])
        : null;
    mMeta = json['_meta'] != null ? Meta.fromJson(json['_meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    if (mMeta != null) {
      data['_meta'] = mMeta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Data({this.id, this.email, this.firstName, this.lastName, this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    return data;
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['text'] = text;
    return data;
  }
}

class Meta {
  String? poweredBy;
  String? docsUrl;
  String? upgradeUrl;
  String? exampleUrl;
  String? variant;
  String? message;
  Cta? cta;
  String? context;

  Meta({
    this.poweredBy,
    this.docsUrl,
    this.upgradeUrl,
    this.exampleUrl,
    this.variant,
    this.message,
    this.cta,
    this.context,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    poweredBy = json['powered_by'];
    docsUrl = json['docs_url'];
    upgradeUrl = json['upgrade_url'];
    exampleUrl = json['example_url'];
    variant = json['variant'];
    message = json['message'];
    cta = json['cta'] != null ? Cta.fromJson(json['cta']) : null;
    context = json['context'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['powered_by'] = poweredBy;
    data['docs_url'] = docsUrl;
    data['upgrade_url'] = upgradeUrl;
    data['example_url'] = exampleUrl;
    data['variant'] = variant;
    data['message'] = message;
    if (cta != null) {
      data['cta'] = cta!.toJson();
    }
    data['context'] = context;
    return data;
  }
}

class Cta {
  String? label;
  String? url;

  Cta({this.label, this.url});

  Cta.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['label'] = label;
    data['url'] = url;
    return data;
  }
}
