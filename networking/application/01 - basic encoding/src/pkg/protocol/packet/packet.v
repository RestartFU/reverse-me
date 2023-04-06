module packet

pub interface Packet{
	encode() []u8
	decode([]u8) !Packet
}