class SelectedShippingType {
  int _sellerId =0;
  String _selectedShippingType ='';

  SelectedShippingType({int? sellerId, String? selectedShippingType}) {
    if (sellerId != null) {
      this._sellerId = sellerId;
    }
    if (selectedShippingType != null) {
      this._selectedShippingType = selectedShippingType;
    }
  }

  int get sellerId => _sellerId;
  String get selectedShippingType => _selectedShippingType;

  SelectedShippingType.fromJson(Map<String, dynamic> json) {
    _sellerId = json['sellerId'];
    _selectedShippingType = json['selectedShippingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellerId'] = this._sellerId;
    data['selectedShippingType'] = this._selectedShippingType;
    return data;
  }
}
