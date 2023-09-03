class ProfileRequest {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profilePicture;

  ProfileRequest({
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      if (phoneNumber != null) 'phone_number': '+234${phoneNumber?.replaceRange(0, 1, '')}',
      'display_name': '$firstName $lastName',
      if (profilePicture != null) 'photo': profilePicture,
    };
  }
}
