type t = {
  title: string,
  date: string,
  body: string,
};

let fromJs = (post: ResourceIo.post) => {
  title: post##title,
  date: post##date,
  body: post##body,
};

let toJs = post: ResourceIo.post => {
  "title": post.title,
  "date": post.date,
  "body": post.body,
};

let query = slug =>
  Request.make(~url=Environment.apiUrl ++ "/" ++ slug ++ ".json", ())
  ->Future.mapOk(fromJs);
