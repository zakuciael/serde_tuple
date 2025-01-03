use serde_tuple_explicit::*;

#[derive(Debug, SerializeTuple, DeserializeTuple)]
pub struct Foo {
    field_a: String,
    field_b: u32,
    field_c: bool,
}

fn main() {
    let foo = Foo {
        field_a: "test 123".to_string(),
        field_b: 666,
        field_c: true,
    };

    let json = {
        let mut buf = vec![];
        let mut serializer = serde_json::Serializer::pretty(&mut buf);
        foo.serialize_tuple(&mut serializer).unwrap();

        unsafe { String::from_utf8_unchecked(buf) }
    };

    println!("{}", &json);

    let foo = {
        let mut deserializer = serde_json::Deserializer::from_str(&json);
        Foo::deserialize_tuple(&mut deserializer).unwrap()
    };

    println!("{:?}", &foo);
}
