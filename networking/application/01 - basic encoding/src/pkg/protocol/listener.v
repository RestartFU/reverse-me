module protocol

import net

pub struct Listener {
	mut:
	l &net.TcpListener
}

pub fn listen(address string) !&Listener {
	l := net.listen_tcp(net.AddrFamily.ip, address)!
	return &Listener{
		l: l
	}
}

pub fn (mut l Listener) accept() !&Conn {
	conn := l.l.accept()!
	return &Conn{
		conn: conn
	}
}