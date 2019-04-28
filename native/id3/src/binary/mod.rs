use rustler::{Decoder, Encoder, Env, NifResult, Term};

pub struct Binary(pub Vec<u8>);

impl Binary {
    pub fn vec(&self) -> Vec<u8> {
        self.0.to_vec()
    }
}

impl Encoder for Binary {
    fn encode<'a>(&self, env: Env<'a>) -> Term<'a> {
        let Binary(s) = self;

        // ## About `unsafe`
        // We won't touch this as a Rust `String` beyond here,
        // and Elixir will receive this as a `:binary`, so it is safe to do this.
        let string = unsafe { String::from_utf8_unchecked(s.to_owned()) };

        string.encode(env)
    }
}

impl<'a> Decoder<'a> for Binary {
    fn decode(term: Term<'a>) -> NifResult<Self> {
        let binary = rustler::Binary::from_term(term)?;
        Ok(Binary(binary.as_slice().to_owned()))
    }
}
