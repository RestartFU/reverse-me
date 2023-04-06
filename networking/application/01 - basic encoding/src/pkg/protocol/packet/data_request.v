module packet

pub struct DataRequest{
	pub:
	id int
	kind string
}

pub fn(d DataRequest) encode() []u8 {
	return "${int(ID.data_request)}|${d.id}+${d.kind}".bytes()
}

pub fn(_ DataRequest) decode(buf []u8) !Packet {
	split := buf.bytestr().split("+")
	if split.len < 2 {
		return error("data request: message too short")
	}
	return DataRequest{
		id: split[0].int()
		kind: split[1]
	}
}