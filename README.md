# serde_tuple_explicit

A fork of the [`serde_tuple`](https://github.com/kardeiz/serde_tuple) crate using explicit traits to de/serialize structs.

# Usage

```rust
use serde_tuple_explicit::*;

#[derive(SerializeTuple, DeserializeTuple)]
pub struct Foo<'a> {
    bar: &'a str,
    baz: i32
}

let foo = Foo { bar: "Yes", baz: 22 };

let json = {
  let mut buf = vec![];
  let mut serializer = serde_json::Serializer::pretty(&mut buf);
  foo.serialize_tuple(&mut serializer).unwrap();

  unsafe { String::from_utf8_unchecked(buf) }
};

println!("{}", &json);
// # => ["Yes",22]
```

License: MIT
