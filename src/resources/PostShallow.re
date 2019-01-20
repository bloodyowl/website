open Belt;

type t = {
  title: string,
  date: string,
  slug: string,
};

let fromJs = (postShallow: ResourceIo.postShallow) => {
  title: postShallow##title,
  date: postShallow##date,
  slug: postShallow##slug,
};

let toJs = (postShallow): ResourceIo.postShallow => {
  "title": postShallow.title,
  "date": postShallow.date,
  "slug": postShallow.slug,
};

let query = _ => {
  Request.make(~url=Environment.apiUrl ++ "/all.json", ())
  ->Future.mapOk(payload => Array.map(payload, fromJs));
};
