# serde_tuple

> [!Warning]
> This is a modified version of `serde_tuple` crate,
> which instead of using `serde::Serialize` and `serde::Deserialize` traits provides its own `serde_tuple::SerializeTuple` and `serde_tuple::DeserializeTuple` traits.
> Allowing usage of normal and tuple serialization/deserialization at the same time. 
> 
> For the original `serde_tuple` crate go [here](https://github.com/kardeiz/serde_tuple)

# Usage

```rust
use serde_tuple::*;

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