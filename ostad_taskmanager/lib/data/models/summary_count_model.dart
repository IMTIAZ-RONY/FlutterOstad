class SummaryCountModel {
  String? status;
  List<SummaryData>? data;

  SummaryCountModel({this.status, this.data});

  SummaryCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SummaryData>[];
      json['data'].forEach((v) {
        data!.add(new SummaryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SummaryData {
  String? sId;
  int? sum;

  SummaryData({this.sId, this.sum});

  SummaryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sum'] = this.sum;
    return data;
  }
}
