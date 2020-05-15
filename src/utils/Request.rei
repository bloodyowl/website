type httpMethod = [ | `DELETE | `GET | `PATCH | `POST];

let make:
  (
    ~url: string,
    ~httpMethod: httpMethod=?,
    ~body: 'a=?,
    ~contentType: string=?,
    ~responseType: string=?,
    unit
  ) =>
  Future.t(Belt.Result.t('b, Errors.t));
