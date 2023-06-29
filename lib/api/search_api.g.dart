// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpamNum _$SpamNumFromJson(Map<String, dynamic> json) => SpamNum(
      message: json['message'] as String?,
      numOfCall: json['numOfCall'] as int?,
    );

Map<String, dynamic> _$SpamNumToJson(SpamNum instance) => <String, dynamic>{
      'message': instance.message,
      'numOfCall': instance.numOfCall,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SearchApi implements SearchApi {
  _SearchApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://3.34.180.104:4000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SpamNum> getTasks(String spamNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'spamNumber': spamNumber};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<SpamNum>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/voice',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SpamNum.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
