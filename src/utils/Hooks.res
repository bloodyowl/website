module IntersectionObserver = {
  type options = {"threshold": array<float>}
  type t
  @new external make: (array<{..}> => unit, options) => t = "IntersectionObserver"
  @send external observe: (t, Dom.element) => unit = "observe"
  @send external unobserve: (t, Dom.element) => unit = "observe"
  @send external disconnect: t => unit = "disconnect"
}

let threshold =
  Array.from({"length": 500})
  ->Array.mapWithIndex((_, index) => index->Float.fromInt /. 500.0)
  ->Array.concat([1.0])

external elementAsObject: Dom.element => {..} = "%identity"

let isIOS =
  %external(window) != None &&
    (window["navigator"]["platform"]->String.includes("iPhone") ||
      window["navigator"]["platform"]->String.includes("iPod"))

let useScrollProgress = isIOS
  ? (
      ~containerRef: React.ref<Nullable.t<Dom.element>>,
      ~scrollRef: React.ref<Nullable.t<Dom.element>>,
    ) => {
      React.useEffect0(() => {
        switch (containerRef.current->Nullable.toOption, scrollRef.current->Nullable.toOption) {
        | (Some(container), Some(scroll)) =>
          let onScroll = () => {
            let scroll = scroll->elementAsObject
            let root = container->elementAsObject
            let boundingClientRect = scroll["getBoundingClientRect"](.)

            root["style"]["setProperty"](.
              "--scroll-progress",
              Math.min(
                Math.max(0.0, 1.0 -. boundingClientRect["top"] /. window["innerHeight"]),
                1.0,
              ),
            )
          }
          let () = window["addEventListener"](. "scroll", onScroll, {"passive": true})
          let () = onScroll()
          Some(() => window["removeEventListener"](. "scroll", onScroll, {"passive": true}))
        | _ => None
        }
      })
    }
  : (
      ~containerRef: React.ref<Nullable.t<Dom.element>>,
      ~scrollRef: React.ref<Nullable.t<Dom.element>>,
    ) => {
      React.useEffect0(() => {
        switch (containerRef.current->Nullable.toOption, scrollRef.current->Nullable.toOption) {
        | (Some(container), Some(scroll)) =>
          let intersectionObserver = IntersectionObserver.make(entries => {
            entries->Array.forEach(entry => {
              let root = container->elementAsObject
              switch entry["rootBounds"]->Nullable.toOption {
              | Some(rootBounds) =>
                if entry["boundingClientRect"]["top"] >= 0.0 {
                  if entry["boundingClientRect"]["top"] >= rootBounds["height"] {
                    let () = root["style"]["setProperty"](. "--scroll-progress", 0.0)
                  } else {
                    let value =
                      entry["intersectionRect"]["height"] /.
                      Math.min(entry["boundingClientRect"]["height"], rootBounds["height"])
                    let value = value > 0.99 ? 1.0 : value < 0.01 ? 0.00 : value
                    let () = root["style"]["setProperty"](. "--scroll-progress", value)
                  }
                } else if entry["boundingClientRect"]["bottom"] < rootBounds["height"] {
                  let () = root["style"]["setProperty"](. "--scroll-progress", 1.0)
                }

              | None => ()
              }
            })
          }, {"threshold": threshold})
          intersectionObserver->IntersectionObserver.observe(scroll)
          Some(() => intersectionObserver->IntersectionObserver.unobserve(scroll))
        | _ => None
        }
      })
    }
