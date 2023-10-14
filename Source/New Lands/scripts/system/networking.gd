extends Node

func create_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(8888)
	multiplayer.multiplayer_peer = peer

func create_client(ip):
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, 8888)
	multiplayer.multiplayer_peer = peer 
