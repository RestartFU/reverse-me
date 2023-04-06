module main

import pkg.protocol
import pkg.protocol.packet
import time

fn main(){
	mut conn := protocol.dial("127.0.0.1:8010")!

	mut id := 0

	for {
		time.sleep(time.second)
		conn.write_packet(packet.DataRequest{id: id, kind: "smurf"})!
		pk := conn.expect_packet[packet.DataResponse]() or {
			println(err)
			continue
		}
		println(pk.data)
		id++
	}
}
