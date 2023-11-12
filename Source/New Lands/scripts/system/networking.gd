extends Node

func create_server():
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_server(8888)
	if result == OK:
		print("Server created")
	peer.peer_connected.connect(on_peer_connected)
	multiplayer.multiplayer_peer = peer

func create_client(ip):
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, 8888)
	multiplayer.multiplayer_peer = peer

func on_peer_connected(id):
	print("Connected ", id)
