/// Status : "200"
/// Message : "Getting All Workorders..."
/// TransactionData : [{"id":"2","account_id":"4","type":"credit","sub_type":"opening_balance","amount":"100000.0000","reff_no":"","operation_date":"2022-12-13 09:22:00","created_by":"17","transaction_id":"","transaction_payment_id":"","transfer_transaction_id":"","note":"","transaction_image":"https://vipugroup.com/final/uploads/","deleted_at":"","created_at":"2022-12-12 09:22:00","updated_at":"2022-12-12 09:22:00"}]

class GetAllTransactions {
  GetAllTransactions({
      String? status, 
      String? message, 
      List<TransactionData>? transactionData,}){
    _status = status;
    _message = message;
    _transactionData = transactionData;
}

  GetAllTransactions.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    if (json['Data'] != null) {
      _transactionData = [];
      json['Data'].forEach((v) {
        _transactionData?.add(TransactionData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<TransactionData>? _transactionData;
GetAllTransactions copyWith({  String? status,
  String? message,
  List<TransactionData>? transactionData,
}) => GetAllTransactions(  status: status ?? _status,
  message: message ?? _message,
  transactionData: transactionData ?? _transactionData,
);
  String? get status => _status;
  String? get message => _message;
  List<TransactionData>? get transactionData => _transactionData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_transactionData != null) {
      map['Data'] = _transactionData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// account_id : "4"
/// type : "credit"
/// sub_type : "opening_balance"
/// amount : "100000.0000"
/// reff_no : ""
/// operation_date : "2022-12-13 09:22:00"
/// created_by : "17"
/// transaction_id : ""
/// transaction_payment_id : ""
/// transfer_transaction_id : ""
/// note : ""
/// transaction_image : "https://vipugroup.com/final/uploads/"
/// deleted_at : ""
/// created_at : "2022-12-12 09:22:00"
/// updated_at : "2022-12-12 09:22:00"

class TransactionData {
  TransactionData({
      String? id, 
      String? accountId, 
      String? type, 
      String? subType, 
      String? amount, 
      String? reffNo, 
      String? operationDate, 
      String? createdBy, 
      String? transactionId, 
      String? transactionPaymentId, 
      String? transferTransactionId, 
      String? note, 
      String? transactionImage, 
      String? deletedAt, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _accountId = accountId;
    _type = type;
    _subType = subType;
    _amount = amount;
    _reffNo = reffNo;
    _operationDate = operationDate;
    _createdBy = createdBy;
    _transactionId = transactionId;
    _transactionPaymentId = transactionPaymentId;
    _transferTransactionId = transferTransactionId;
    _note = note;
    _transactionImage = transactionImage;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  TransactionData.fromJson(dynamic json) {
    _id = json['id'];
    _accountId = json['account_id'];
    _type = json['type'];
    _subType = json['sub_type'];
    _amount = json['amount'];
    _reffNo = json['reff_no'];
    _operationDate = json['operation_date'];
    _createdBy = json['created_by'];
    _transactionId = json['transaction_id'];
    _transactionPaymentId = json['transaction_payment_id'];
    _transferTransactionId = json['transfer_transaction_id'];
    _note = json['note'];
    _transactionImage = json['transaction_image'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _accountId;
  String? _type;
  String? _subType;
  String? _amount;
  String? _reffNo;
  String? _operationDate;
  String? _createdBy;
  String? _transactionId;
  String? _transactionPaymentId;
  String? _transferTransactionId;
  String? _note;
  String? _transactionImage;
  String? _deletedAt;
  String? _createdAt;
  String? _updatedAt;
TransactionData copyWith({  String? id,
  String? accountId,
  String? type,
  String? subType,
  String? amount,
  String? reffNo,
  String? operationDate,
  String? createdBy,
  String? transactionId,
  String? transactionPaymentId,
  String? transferTransactionId,
  String? note,
  String? transactionImage,
  String? deletedAt,
  String? createdAt,
  String? updatedAt,
}) => TransactionData(  id: id ?? _id,
  accountId: accountId ?? _accountId,
  type: type ?? _type,
  subType: subType ?? _subType,
  amount: amount ?? _amount,
  reffNo: reffNo ?? _reffNo,
  operationDate: operationDate ?? _operationDate,
  createdBy: createdBy ?? _createdBy,
  transactionId: transactionId ?? _transactionId,
  transactionPaymentId: transactionPaymentId ?? _transactionPaymentId,
  transferTransactionId: transferTransactionId ?? _transferTransactionId,
  note: note ?? _note,
  transactionImage: transactionImage ?? _transactionImage,
  deletedAt: deletedAt ?? _deletedAt,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get accountId => _accountId;
  String? get type => _type;
  String? get subType => _subType;
  String? get amount => _amount;
  String? get reffNo => _reffNo;
  String? get operationDate => _operationDate;
  String? get createdBy => _createdBy;
  String? get transactionId => _transactionId;
  String? get transactionPaymentId => _transactionPaymentId;
  String? get transferTransactionId => _transferTransactionId;
  String? get note => _note;
  String? get transactionImage => _transactionImage;
  String? get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_id'] = _accountId;
    map['type'] = _type;
    map['sub_type'] = _subType;
    map['amount'] = _amount;
    map['reff_no'] = _reffNo;
    map['operation_date'] = _operationDate;
    map['created_by'] = _createdBy;
    map['transaction_id'] = _transactionId;
    map['transaction_payment_id'] = _transactionPaymentId;
    map['transfer_transaction_id'] = _transferTransactionId;
    map['note'] = _note;
    map['transaction_image'] = _transactionImage;
    map['deleted_at'] = _deletedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}