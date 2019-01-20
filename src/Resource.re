type t =
  | BlogPostList(
      array({
        .
        "title": string,
        "date": string,
        "slug": string,
      }),
    )
  | BlogPost(
      array({
        .
        "title": string,
        "date": string,
        "body": string,
      }),
    );
