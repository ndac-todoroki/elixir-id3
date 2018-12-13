use id3::Timestamp;
use rustler::types::atom::Atom as NifAtom;

mod atoms {
    rustler_atoms! {
        atom ok;
        atom error;
        atom calendar_iso = "Elixir.Calendar.ISO";
    }
}

#[derive(NifStruct)]
#[module = "NaiveDateTime"]
/// Struct matching Elixir's `NaiveDateTime`.
pub struct NaiveDateTime {
    pub year: i32,
    pub month: u8,
    pub day: u8,
    pub hour: u8,
    pub minute: u8,
    pub second: u8,
    pub calendar: NifAtom,
    pub microsecond: (u32, u32),
}

impl From<Timestamp> for NaiveDateTime {
    fn from(ts: Timestamp) -> Self {
        Self {
            year: ts.year,
            month: ts.month.unwrap_or(0),
            day: ts.day.unwrap_or(0),
            hour: ts.hour.unwrap_or(0),
            minute: ts.minute.unwrap_or(0),
            second: ts.second.unwrap_or(0),
            calendar: atoms::calendar_iso(),
            microsecond: (0, 0),
        }
    }
}

impl From<NaiveDateTime> for Timestamp {
    fn from(dt: NaiveDateTime) -> Self {
        Self {
            year: dt.year,
            month: Some(dt.month),
            day: Some(dt.day),
            hour: Some(dt.hour),
            minute: Some(dt.minute),
            second: Some(dt.second),
        }
    }
}
