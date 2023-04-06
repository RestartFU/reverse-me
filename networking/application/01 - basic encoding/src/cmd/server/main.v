module main

import pkg.protocol
import pkg.protocol.packet

fn main(){
	mut l := protocol.listen("127.0.0.1:8010")!
	for {
		mut conn := l.accept()!
		spawn fn [mut conn]() ! {
			for {
				pk := conn.read_packet() or {
					return
				}
				match pk {
					packet.DataRequest {
						if pk.kind == "secret" {
							conn.write_packet(packet.DataResponse{
								id: pk.id
								data: "b4s3sixtyfour"
							})!
						} else if pk.kind == "smurf" {
							conn.write_packet(packet.DataResponse{
								id: pk.id
								data: "I love touching grass"
							})!
						} else {
							conn.write_packet(packet.DataResponse{
								id: pk.id
								data: "nice try :)"
							})!
						}
					}
				else { error("unhandled packet ${pk}")}
				}
			}
		}()
	}
}
