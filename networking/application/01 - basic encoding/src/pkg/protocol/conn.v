module protocol

import net
import pkg.protocol.packet
import time
import encoding.base64

pub struct Conn {
	mut:
	conn &net.TcpConn
}

pub fn dial(address string) !&Conn {
	conn := net.dial_tcp(address)!
	return &Conn{
		conn: conn
	}
}

pub fn (mut c Conn) expect_packet[T]() !&T {
	pk := c.read_packet()!
	if pk is T {
		return pk
	}
	return error("received unexpected packet")
}

pub fn (mut c Conn) write_packet(pk packet.Packet) ! {
	time.sleep(time.millisecond * 100)
	c.conn.write(base64.encode(pk.encode()).bytes())!
}

pub fn (mut c Conn) read_packet() !packet.Packet {
	mut buf := []u8{len:1024}
	n := c.conn.read(mut buf)!
	if n <= 0 {
		return error("read_packet: message too short")
	}
	time.sleep(time.millisecond * 100)

	buf = base64.decode(buf[..n].bytestr())
	mut split := buf.bytestr().split("|")
	if split.len < 1 {
		return error("read_packet: missing packet id")
	}
	pk := packet.from_id(unsafe { packet.ID(split[0].int()) })
	return pk.decode(split[1].bytes())
}