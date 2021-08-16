// To parse this JSON data, do
//
//     final contactsResponse = contactsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:contactos/models/contacts.dart';

ContactsResponse contactsResponseFromJson(String str) => ContactsResponse.fromJson(json.decode(str));

String contactsResponseToJson(ContactsResponse data) => json.encode(data.toJson());

class ContactsResponse {
    ContactsResponse({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int count;
    dynamic next;
    dynamic previous;
    List<Result> results;

    factory ContactsResponse.fromJson(Map<String, dynamic> json) => ContactsResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

