class MessagesResponse {
    final String role;
    final String parts;

    MessagesResponse({
        required this.role,
        required this.parts,
    });

    factory MessagesResponse.fromJson(Map<String, dynamic> json) => MessagesResponse(
        role: json["role"],
        parts: json["parts"],
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "parts": parts,
    };
}
