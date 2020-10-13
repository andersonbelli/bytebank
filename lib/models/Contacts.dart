class Contact {
  final String name;
  final int accountNumber;

  Contact(this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contacts{name: $name, accountNumber: $accountNumber}';
  }

  Contact.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'accountNumber': accountNumber};
}
