import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class AppConfigs {
  static const url = "http://gateway.marvel.com/v1/public/";

  static const String publicAPIkey = '9601245ca63b0d24e9db62c1a150cfef';
  static const String privateAPIkey =
      'dac466fe24c73df23c251bdc009c3e3d9bdb8038';
  static const String ts = '1';

  /// timestamp

  static const md5 = ts + privateAPIkey + publicAPIkey;

  static getMD5() {
    var bytes = utf8.encode(md5);
    crypto.Digest md5Hash = crypto.md5.convert(bytes);

    return 'ts=1&apikey=$publicAPIkey&hash=$md5Hash';
  }

  // static const apiKey =
  //     '?ts=1&apikey=$publicAPIkey&hash=139072c792d31c109c653c8d8ffdbe93';

  ///Authentication for Server-Side Applications
  ///
  /// Server-side applications must pass two parameters in addition to the apikey parameter:
  ///
  ///     ts - a timestamp (or other long string which can change on a request-by-request basis)
  ///     hash - a md5 digest of the ts parameter, your private key and your public key (e.g.
  ///
  ///
  ///
  ///     md5(ts+privateKey+publicKey)
  ///
  ///
  ///
  ///
  /// For example, a user with a public key of "1234" and a private key of "abcd"
  /// could construct a valid call as follows: http://gateway.marvel.com/v1/public/comics?ts=1&apikey=1234&hash=ffd275c5130566a2916217b101f26150
  /// (the hash value is the md5 digest of 1abcd1234)
}
