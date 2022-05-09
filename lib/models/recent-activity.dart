
class RecentActivity {
  int id;
  String item;
  String from;
  String to;
  String price;
  String sender;
  String recieverName;
  String trackingNo;
  String status;
  String createdAt;

  RecentActivity(
      {this.id,
        this.item,
        this.from,
        this.to,
        this.price,
        this.sender,
        this.recieverName,
        this.trackingNo,
        this.status,
        this.createdAt});

  RecentActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    from = json['from'];
    to = json['to'];
    price = json['price'];
    sender = json['sender'];
    recieverName = json['reciever_name'];
    trackingNo = json['tracking_no'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item'] = this.item;
    data['from'] = this.from;
    data['to'] = this.to;
    data['price'] = this.price;
    data['sender'] = this.sender;
    data['reciever_name'] = this.recieverName;
    data['tracking_no'] = this.trackingNo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }

  static List<RecentActivity> fromJsonList(List<dynamic> _list) {
    return _list.map((_his) => RecentActivity.fromJson(_his)).toList();
  }
}


