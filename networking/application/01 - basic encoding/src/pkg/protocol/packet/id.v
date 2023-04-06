module packet

pub enum ID {
	data_request
	data_response
}

pub fn from_id(id ID) Packet {
	match id {
		.data_request {return DataRequest{}}
		.data_response {return DataResponse{}}
	}
}