module packet

pub struct DataResponse {
	pub:
	id int
	data string
}

pub fn(d DataResponse) encode() []u8 {
	return "${int(ID.data_response)}|${d.id}+${d.data}".bytes()
}

pub fn(_ DataResponse) decode(buf []u8) !Packet {
	split := buf.bytestr().split("+")
	if split.len < 2 {
		return error("data response: message too short")
	}
	return DataResponse{
		id: split[0].int()
		data: split[1]
	}
}